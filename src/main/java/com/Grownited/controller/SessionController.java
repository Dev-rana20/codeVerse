package com.Grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

import com.Grownited.entity.UserDetailEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.UserDetailRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserTypeRepository;
import com.Grownited.service.MailerService;
import com.Grownited.service.OtpService;
import com.Grownited.service.RateLimiterService;
import com.cloudinary.Cloudinary;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {

	@Autowired
	UserRepository userRepository;

	@Autowired
	UserTypeRepository userTypeRepository;

	@Autowired
	UserDetailRepository userDetailRepository;

	@Autowired
	MailerService mailerService;

	@Autowired
	OtpService otpService;

	@Autowired
	RateLimiterService rateLimiterService;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	Cloudinary cloudinary;

	private static final int MAX_FAILED_LOGINS = 5;
	private static final int MAX_FAILED_OTPS = 3;
	private static final int LOCK_TIME_MINUTES = 15;


	@GetMapping("/signup")
	public String openSignupPage(Model model) {

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();

		model.addAttribute("allUserType", allUserType);
		return "Signup";
	}

	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}

	@GetMapping("/forgetPassword")
	public String forgetPassword() {
		return "ForgetPassword";
	}

	@PostMapping("/register")
	public String register(@Valid UserEntity userEntity, BindingResult result, @Valid UserDetailEntity userDetailEntity, BindingResult detailResult, MultipartFile profilePic, Model model) {

		if (result.hasErrors() || detailResult.hasErrors()) {
			model.addAttribute("error", "Please correct the highlighted errors.");
			// Optionally pass all errors to the model if JSP can handle them
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "Signup";
		}

		// ✅ Check if email already exists
		if (userRepository.findByEmail(userEntity.getEmail()).isPresent()) {
			model.addAttribute("error", "Email already registered. Try logging in.");
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "Signup";
		}

		userEntity.setCreatedAt(LocalDate.now());
		userEntity.setActive(true);
		userEntity.setRole("PARTICIPANT");

		// encode password
		String encodedPassword = passwordEncoder.encode(userEntity.getPassword());
		userEntity.setPassword(encodedPassword);

		// file uploading
		if (profilePic != null && !profilePic.isEmpty()) {
			try {
				Map<?, ?> map = cloudinary.uploader().upload(profilePic.getBytes(), null);
				String profilePicURL = map.get("secure_url").toString();
				userEntity.setProfilePicURL(profilePicURL);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		userRepository.save(userEntity); 
		userDetailEntity.setUserId(userEntity.getUserId());
		userDetailRepository.save(userDetailEntity);

		mailerService.sendWalcomeMail(userEntity);

		return "Login";
	}

	@PostMapping("/authenticate")
	public String authenticate(String email, String password, Model model, HttpSession session, HttpServletRequest request) {

		String ip = request.getRemoteAddr();
		
		// 1. IP Throttling (auth attempts)
		if (!rateLimiterService.isAllowed(ip, "AUTH", 2000)) { // 2s cooldown for attempts
			model.addAttribute("error", "Slow down. Please try again in a few seconds.");
			return "Login";
		}
		rateLimiterService.recordAttempt(ip, "AUTH");

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		// ✅ check user exists
		if (opUser.isEmpty()) {
			model.addAttribute("error", "Invalid Credentials");
			return "Login";
		}

		UserEntity dbUser = opUser.get();

		// 2. Check Account Lock
		if (dbUser.getLockedUntil() != null && LocalDateTime.now().isBefore(dbUser.getLockedUntil())) {
			model.addAttribute("error", "Account is temporarily locked due to multiple failed attempts. Please try again after " + dbUser.getLockedUntil());
			return "Login";
		}

		// ✅ check password
		if (!passwordEncoder.matches(password, dbUser.getPassword())) {
			int attempts = dbUser.getFailedLoginAttempts() + 1;
			dbUser.setFailedLoginAttempts(attempts);
			
			if (attempts >= MAX_FAILED_LOGINS) {
				dbUser.setLockedUntil(LocalDateTime.now().plusMinutes(LOCK_TIME_MINUTES));
				dbUser.setFailedLoginAttempts(0); // reset count after lock triggers
				userRepository.save(dbUser);
				model.addAttribute("error", "Too many failed attempts. Account locked for " + LOCK_TIME_MINUTES + " minutes.");
			} else {
				userRepository.save(dbUser);
				model.addAttribute("error", "Invalid Credentials. (" + (MAX_FAILED_LOGINS - attempts) + " attempts remaining)");
			}
			return "Login";
		}

		// ✅ check account status
		if (dbUser.getActive() == null || !dbUser.getActive()) {
			model.addAttribute("error", "Account disabled");
			return "Login";
		}

		// Success: Reset failed attempts
		dbUser.setFailedLoginAttempts(0);
		dbUser.setLockedUntil(null);
		userRepository.save(dbUser);

		// ✅ store in session
		session.setAttribute("user", dbUser);

		// ✅ role-based redirect
		if (dbUser.getRole().equals("ADMIN")) {
			return "redirect:/admin-dashboard";
		} else if (dbUser.getRole().equals("PARTICIPANT")) {
			return "redirect:/userHome";
		} else if (dbUser.getRole().equals("JUDGE")) {

			// 🔥 IMPORTANT: first login check
			if (dbUser.isFirstLogin()) {
				return "redirect:/judge/complete-profile";
			}

			return "redirect:/judge/dashboard";
		}

		return "Login";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();
		
		// Prevent back-button from showing protected pages after logout
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		
		return "redirect:/login";
	}

	@PostMapping("/resetPassword")
	public String resetPassword(String email, Model model, HttpServletRequest request) {

		String ip = request.getRemoteAddr();
		
		if (!rateLimiterService.isAllowed(ip, "RESET_PWD", 60000)) { // 1 min per IP
			model.addAttribute("error", "Please wait a minute before requesting another OTP");
			return "ForgetPassword";
		}
		rateLimiterService.recordAttempt(ip, "RESET_PWD");

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isPresent()) {
			UserEntity user = opUser.get();
			
			// If already locked from auth attempts, don't allow reset either? 
			// Actually reset allows getting back in, but let's prevent spam.
			if (user.getLockedUntil() != null && LocalDateTime.now().isBefore(user.getLockedUntil())) {
				model.addAttribute("error", "Account is locked. Please try again later.");
				return "ForgetPassword";
			}

			String otp = otpService.generateOtp();

			// Hash OTP and store with expiry
			user.setOtp(passwordEncoder.encode(otp));
			user.setOtpExpiresAt(LocalDateTime.now().plusMinutes(10));
			user.setFailedOtpAttempts(0); // Reset OTP attempts for new code
			userRepository.save(user);

			mailerService.sendOtp(email, otp);

			model.addAttribute("email", email);
			model.addAttribute("success", "OTP sent to your email. Please check.");
			return "VerifyOtp";
		}

		model.addAttribute("error", "Email not registered");
		return "ForgetPassword";
	}


	@PostMapping("/verifyOtp")
	public String verifyOtp(String email, String otp, Model model, HttpSession session) {

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isPresent()) {
			UserEntity user = opUser.get();

			// 1. Check account lock
			if (user.getLockedUntil() != null && LocalDateTime.now().isBefore(user.getLockedUntil())) {
				model.addAttribute("error", "Account temporarily locked.");
				return "VerifyOtp";
			}

			// 2. Check expiry
			if (user.getOtpExpiresAt() == null || LocalDateTime.now().isAfter(user.getOtpExpiresAt())) {
				model.addAttribute("error", "OTP has expired");
				model.addAttribute("email", email);
				return "VerifyOtp";
			}

			// 3. Verify hash
			if (passwordEncoder.matches(otp, user.getOtp())) {
				// Authorize password change for this session/email
				session.setAttribute("otpVerifiedEmail", email);
				
				// Clear OTP and reset security counters
				user.setOtp(null); 
				user.setOtpExpiresAt(null);
				user.setFailedOtpAttempts(0);
				user.setLockedUntil(null);
				userRepository.save(user);

				model.addAttribute("email", email);
				return "ChangePassword";
			} else {
				// Record failure
				int attempts = user.getFailedOtpAttempts() + 1;
				user.setFailedOtpAttempts(attempts);
				
				if (attempts >= MAX_FAILED_OTPS) {
					user.setLockedUntil(LocalDateTime.now().plusMinutes(LOCK_TIME_MINUTES));
					user.setOtp(null); // Invalidate OTP on too many failures
					user.setOtpExpiresAt(null);
					userRepository.save(user);
					model.addAttribute("error", "Too many failed attempts. Account locked and OTP invalidated.");
				} else {
					userRepository.save(user);
					model.addAttribute("error", "Invalid OTP. (" + (MAX_FAILED_OTPS - attempts) + " attempts remaining)");
				}
			}
		}

		model.addAttribute("email", email);
		return "VerifyOtp";
	}


	@PostMapping("/updatePassword")
	public String updatePassword(String email, String Password, String confirmPassword, Model model, HttpSession session, RedirectAttributes ra) {


		// Verify session authorization
		String verifiedEmail = (String) session.getAttribute("otpVerifiedEmail");
		if (verifiedEmail == null || !verifiedEmail.equals(email)) {
			return "redirect:/forgetPassword";
		}

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isEmpty()) {
			return "redirect:/login";
		} else if (!Password.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match");
			model.addAttribute("email", email);
			return "ChangePassword";
		} else {
			UserEntity user = opUser.get();
			String encodedPassword = passwordEncoder.encode(confirmPassword);
			user.setPassword(encodedPassword);
			// OTP already cleared in verifyOtp, but ensuring it's null
			user.setOtp(null);
			user.setOtpExpiresAt(null);
			userRepository.save(user);
			session.removeAttribute("otpVerifiedEmail");
			ra.addFlashAttribute("success", "Password updated successfully. Please login.");
		}

		return "redirect:/login";
	}


	// judge password change
	@GetMapping("/judge/complete-profile")
	public String changePasswordPage() {
		return "/judge/JudgeChangePassword";
	}

	@PostMapping("/judge/complete-profile")
	public String completeProfile(
	        String firstName,
	        String lastName,
	        String contactNum,
	        String gender,
	        String newPassword,
	        HttpSession session) {

	    UserEntity user = (UserEntity) session.getAttribute("user");

	    // Update profile fields
	    user.setFirstName(firstName);
	    user.setLastName(lastName);
	    user.setContactNum(contactNum);
	    user.setGender(gender);

	    // Update password
	    String encodedPassword = passwordEncoder.encode(newPassword);
	    user.setPassword(encodedPassword);

	    // First login completed
	    user.setFirstLogin(false);

	    userRepository.save(user);

	    return "redirect:/judge/dashboard";
	}

	
}
