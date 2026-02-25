package com.Grownited.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.io.IOException;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.Grownited.entity.UserDetailEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.UserDetailRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserTypeRepository;
import com.Grownited.service.MailerService;
import com.Grownited.service.OtpService;
import com.cloudinary.Cloudinary;

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
	PasswordEncoder passwordEncoder;

	@Autowired
	Cloudinary cloudinary;

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
	public String register(UserEntity userEntity, UserDetailEntity userDetailEntity, MultipartFile profilePic) {

		userEntity.setCreatedAt(LocalDate.now());
		userEntity.setActive(true);
		userEntity.setRole("PARTICIPANT");

		// encode password

		String encodedPassword = passwordEncoder.encode(userEntity.getPassword());
		System.out.println(encodedPassword);
		userEntity.setPassword(encodedPassword);

		// file uploading

//		System.out.println(profilePic.getOriginalFilename());

		try {
			Map map = cloudinary.uploader().upload(profilePic.getBytes(), null);
			String profilePicURL = map.get("secure_url").toString();
			System.out.println(profilePic);
			userEntity.setProfilePicURL(profilePicURL);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		userRepository.save(userEntity); // users insert -> userId
		userDetailEntity.setUserId(userEntity.getUserId());
		userDetailRepository.save(userDetailEntity);

		mailerService.sendWalcomeMail(userEntity);

		return "Login";
	}

	@PostMapping("/authenticate")
	public String authenticate(String email, String password, Model model, HttpSession session) {

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isPresent()) {
			UserEntity dbUser = opUser.get();
			session.setAttribute("user", dbUser);
			if (passwordEncoder.matches(password, dbUser.getPassword())) {
				if (dbUser.getRole().equals("ADMIN")) {
					return "redirect:/admin-dashboard";
				} else if (dbUser.getRole().equals("PARTICIPANT")) {
					return "redirect:/user-dashboard";
				} else if (dbUser.getRole().equals("JUDGE")) {
					return "redirect:/judge-dashboard";
				}
			}
		}

		model.addAttribute("error", "Invalid Cridemtials");
		return "Login";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Login";
	}

	@PostMapping("/resetPassword")
	public String resetPassword(String email, Model model) {

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isPresent()) {

			UserEntity user = opUser.get();

			String otp = otpService.generateOtp();

			user.setOtp(otp);
			userRepository.save(user);

			mailerService.sendOtp(email, otp);

			model.addAttribute("email", email);
			return "VerifyOtp";
		}

		model.addAttribute("error", "Email not registered");
		return "ForgetPassword";
	}

	@PostMapping("/verifyOtp")
	public String verifyOtp(String email, String otp, Model model) {

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isPresent()) {

			UserEntity user = opUser.get();

			if (otp.equals(user.getOtp())) {

				model.addAttribute("email", email);
				return "ChangePassword";
			}
		}

		model.addAttribute("error", "Invalid OTP");
		model.addAttribute("email", email);

		return "VerifyOtp";
	}

	@PostMapping("/updatePassword")
	public String resetPassword(String email, String Password, String confirmPassword, Model model) {

		Optional<UserEntity> opUser = userRepository.findByEmail(email);

		if (opUser.isEmpty()) {

			System.out.println(opUser);
			return "";
		} else if (!Password.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match");
			model.addAttribute("email", email);
			return "ChangePassword";
		} else {
			UserEntity user = opUser.get();
			String encodedPassword = passwordEncoder.encode(confirmPassword);
			user.setPassword(encodedPassword);
			user.setOtp(null);
			userRepository.save(user);
		}

		return "redirect:/login";
	}
}
