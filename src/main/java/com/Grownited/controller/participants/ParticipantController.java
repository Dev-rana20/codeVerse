package com.Grownited.controller.participants;

import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.crypto.password.PasswordEncoder;
import com.cloudinary.Cloudinary;
import java.io.IOException;
import java.util.Optional;

import com.Grownited.dto.LeaderboardDTO;
import com.Grownited.entity.HackathonDescriptionEntity;
import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.NotificationEntity;
import com.Grownited.entity.UserDetailEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonDescriptionRepository;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.NotificationRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserDetailRepository;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

import com.Grownited.service.HackathonService;

@Controller
public class ParticipantController {

	@Autowired
	private HackathonRepository hackathonRepository;

	@Autowired
	HackathonDescriptionRepository hackathonDescriptionRepository;
	@Autowired
	private HackathonRegistrationRepository registrationRepository;

	@Autowired
	private HackathonTeamRepository hackathonTeamRepository;

	@Autowired
	private HackathonTeamMemberRepository hackathonTeamMemberRepository;
	
	 @Autowired
	    NotificationRepository notificationRepository;
	 @Autowired
	 EvaluationRepository evaluationRepo;

	@Autowired
	private UserDetailRepository userDetailRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private Cloudinary cloudinary;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private HackathonService hackathonService;


	@GetMapping("userHome")
	public String userHomePage(Model model, HttpSession session) {

		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		if (currentUser == null) return "redirect:/login";

		// 1. All Hackathons (for discovery)
		LocalDate today = LocalDate.now();
		hackathonService.updateHackathonStatuses();
		List<HackathonEntity> hackathonList = hackathonRepository.findByStatusIn(Arrays.asList("UPCOMING", "ONGOING", "IN_PROGRESS", "Close"));
		
		// 2. My Registrations
		List<HackathonRegistrationEntity> myRegistrations = registrationRepository
				.findByUserUserId(currentUser.getUserId());
		
		// 3. Count Stats
		int hackathonCount = myRegistrations.size();
		long submissionsCount = 0; // Will be calculated below

		// 4. Closest Submission Deadline (Participated Hackathons Only)
		HackathonEntity nextSubmissionHack = null;
		
		for (HackathonRegistrationEntity reg : myRegistrations) {
			HackathonEntity h = reg.getHackathon();
			
			// Attach teamName dynamically
			HackathonTeamMembersEntity tm = hackathonTeamMemberRepository
					.findByMember_UserIdAndTeam_Hackathon_HackathonId(currentUser.getUserId(), h.getHackathonId());

			if (tm != null && "ACCEPTED".equals(tm.getStatus())) {
				reg.setTeamName(tm.getTeam().getTeamName());
				if (tm.getTeam().getFinalSubmissionLink() != null) submissionsCount++;
			} else {
				// Second chance for leaders
				HackathonTeamEntity leadTeam = hackathonTeamRepository.findByHackathon_HackathonIdAndTeamLeader_UserId(h.getHackathonId(), currentUser.getUserId());
				if (leadTeam != null) {
					reg.setTeamName(leadTeam.getTeamName());
					if (leadTeam.getFinalSubmissionLink() != null) submissionsCount++;
				} else {
					reg.setTeamName("—");
				}
			}
			
			// Find closest upcoming submission deadline
			if (h.getSubmissionDeadline() != null && !h.getSubmissionDeadline().isBefore(today)) {
				if (nextSubmissionHack == null || h.getSubmissionDeadline().isBefore(nextSubmissionHack.getSubmissionDeadline())) {
					nextSubmissionHack = h;
				}
			}
		}

		// 5. My Team Status (for Quick Access card)
		// Get most recent team membership
		List<HackathonTeamMembersEntity> myTeams = hackathonTeamMemberRepository.findByMember(currentUser);
		HackathonTeamMembersEntity latestTeam = myTeams.isEmpty() ? null : myTeams.get(myTeams.size() - 1);

		// Feature 5: Participant counts for hackathon cards
		Map<Integer, Long> participantCounts = buildParticipantCountMap();

		model.addAttribute("user", currentUser);
		model.addAttribute("hackathonList", hackathonList);
		model.addAttribute("myRegistrations", myRegistrations);
		model.addAttribute("hackathonCount", hackathonCount);
		model.addAttribute("submissionsCount", submissionsCount);
		model.addAttribute("upcomingHackathon", nextSubmissionHack);
		model.addAttribute("latestTeam", latestTeam);
		model.addAttribute("participantCounts", participantCounts);
		
		if (nextSubmissionHack != null && nextSubmissionHack.getSubmissionDeadline() != null) {
			long millis = nextSubmissionHack.getSubmissionDeadline().atStartOfDay(java.time.ZoneId.systemDefault()).toInstant().toEpochMilli();
			model.addAttribute("submissionDeadlineMillis", millis);
		}

		return "/participants/DashBoard";
	}

	// Hackathon list page
	@GetMapping("hackathons")
	public String hackathonList(Model model, HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		java.time.LocalDate today = java.time.LocalDate.now();
		
		// Bulk update statuses efficiently
		hackathonService.updateHackathonStatuses();
		
		List<HackathonEntity> hackathonList = hackathonRepository.findAll();

		// Check which hackathons the user has registered for
		List<Integer> registeredHackathonIds = registrationRepository.findByUserUserId(currentUser.getUserId()).stream()
				.map(reg -> reg.getHackathon().getHackathonId()).collect(Collectors.toList());

		// Feature 5: Participant counts
		Map<Integer, Long> participantCounts = buildParticipantCountMap();

		model.addAttribute("user", currentUser);
		model.addAttribute("hackathonList", hackathonList);
		model.addAttribute("registeredHackathonIds", registeredHackathonIds); // use in JSP to show registration status
		model.addAttribute("participantCounts", participantCounts);
		return "/participants/Hackathons";
	}

	// Register user to a hackathon

	@PostMapping("/hackathons/{hackathonId}/register")
	public String register(@PathVariable Integer hackathonId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		boolean exists = registrationRepository.existsByUserUserIdAndHackathonHackathonId(user.getUserId(),
				hackathonId);

		if (exists) {
			redirectAttributes.addFlashAttribute("error", "Already registered!");
		} else {
			HackathonEntity hackathon = hackathonRepository.findById(hackathonId).get();
            
            // Check if registration is closed or hackathon completed
			String status = hackathon.getStatus();
			if ("Close".equalsIgnoreCase(status) || "CLOSED".equalsIgnoreCase(status) || "COMPLETED".equalsIgnoreCase(status)) {
				redirectAttributes.addFlashAttribute("error", "Registrations are no longer accepted for this hackathon!");
				return "redirect:/hackathons";
			}

			// Security Check: If PAID, must go through payment flow
			if ("PAID".equalsIgnoreCase(hackathon.getPayment())) {
				return "redirect:/hackathons/" + hackathonId + "/checkout";
			}

			HackathonRegistrationEntity reg = new HackathonRegistrationEntity();
			reg.setUser(user);
			reg.setHackathon(hackathon);
			reg.setRegistrationDate(LocalDate.now());

			registrationRepository.save(reg);

			redirectAttributes.addFlashAttribute("success", "Registration successful!");
		}

		return "redirect:/hackathons";
	}

	// cancel registration
	@Transactional
	@PostMapping("/hackathons/{hackathonId}/cancel")
	public String cancelRegistration(@PathVariable Integer hackathonId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		// ✅ Check team join
		boolean joined = hackathonTeamMemberRepository
				.existsByMember_UserIdAndTeam_Hackathon_HackathonId(user.getUserId(), hackathonId);

		if (joined) {

			redirectAttributes.addFlashAttribute("error", "Cannot cancel after joining team");

			return "redirect:/userHome";
		}

		registrationRepository.deleteByUserUserIdAndHackathonHackathonId(user.getUserId(), hackathonId);

		redirectAttributes.addFlashAttribute("success", "Registration cancelled");

		return "redirect:/userHome";
	}

	@GetMapping("myTeam")
	public String myTeam(Model model, HttpSession session) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		// Fetch all team memberships of this user
		List<HackathonTeamMembersEntity> myTeams = hackathonTeamMemberRepository.findByMember(user);

		model.addAttribute("myTeams", myTeams);

		return "/participants/MyTeam";
	}

	// Profile page
	@GetMapping("profile")
	public String profile(HttpSession session, Model model) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) return "redirect:/login";
		
		Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(user.getUserId());
		if (opUserDetail.isPresent()) {
			model.addAttribute("userDetail", opUserDetail.get());
		} else {
			model.addAttribute("userDetail", new UserDetailEntity());
		}

		List<HackathonRegistrationEntity> registrations = registrationRepository.findByUserUserId(user.getUserId());
		model.addAttribute("registrations", registrations);
		
		return "/participants/profile";
	}


	@PostMapping("updateProfile")
	public String updateProfile(UserEntity userEntity, UserDetailEntity userDetailEntity,
			@RequestParam("profilePic") MultipartFile profilePic,
			@RequestParam(value = "removeProfilePic", required = false) String removeProfilePic,
			HttpSession session, RedirectAttributes redirectAttributes, Model model) {
		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		if (currentUser == null) return "redirect:/login";

		// Update UserEntity
		currentUser.setFirstName(userEntity.getFirstName());
		currentUser.setLastName(userEntity.getLastName());
		currentUser.setGender(userEntity.getGender());
		currentUser.setBirthYear(userEntity.getBirthYear());
		currentUser.setContactNum(userEntity.getContactNum());

		// Feature 2: Handle remove profile picture
		if ("true".equals(removeProfilePic)) {
			currentUser.setProfilePicURL(null);
		}
		// Handle Profile Picture Upload
		else if (profilePic != null && !profilePic.isEmpty()) {
			// Server-side validation: max 5MB, image types only
			if (profilePic.getSize() > 5 * 1024 * 1024) {
				redirectAttributes.addFlashAttribute("error", "Profile picture must be smaller than 5MB!");
				return "redirect:/profile";
			}
			String contentType = profilePic.getContentType();
			if (contentType == null || !contentType.startsWith("image/")) {
				redirectAttributes.addFlashAttribute("error", "Please upload a valid image file (JPEG, PNG, WebP)!");
				return "redirect:/profile";
			}
			try {
				Map<String, Object> map = cloudinary.uploader().upload(profilePic.getBytes(), null);
				String profilePicURL = map.get("secure_url").toString();
				currentUser.setProfilePicURL(profilePicURL);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		userRepository.save(currentUser);
		session.setAttribute("user", currentUser);

		// Update UserDetailEntity
		Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(currentUser.getUserId());
		UserDetailEntity dbDetail;
		if (opUserDetail.isPresent()) {
			dbDetail = opUserDetail.get();
		} else {
			dbDetail = new UserDetailEntity();
			dbDetail.setUserId(currentUser.getUserId());
		}

		dbDetail.setQualification(userDetailEntity.getQualification());
		dbDetail.setCity(userDetailEntity.getCity());
		dbDetail.setState(userDetailEntity.getState());
		dbDetail.setCountry(userDetailEntity.getCountry());
		dbDetail.setWorkExperience(userDetailEntity.getWorkExperience());
		dbDetail.setBio(userDetailEntity.getBio());
		dbDetail.setGithubLink(userDetailEntity.getGithubLink());
		dbDetail.setSkills(userDetailEntity.getSkills());
		// Feature 3: Social media links
		dbDetail.setLinkedinLink(userDetailEntity.getLinkedinLink());
		dbDetail.setTwitterLink(userDetailEntity.getTwitterLink());

		userDetailRepository.save(dbDetail);

		redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
		return "redirect:/profile";
	}

	@GetMapping("settings")
	public String settings(HttpSession session, Model model) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) return "redirect:/login";
		return "/participants/settings";
	}

	@PostMapping("participant/updatePassword")
	public String updatePassword(@RequestParam String currentPassword, @RequestParam String newPassword, @RequestParam String confirmPassword, HttpSession session, RedirectAttributes redirectAttributes) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
			redirectAttributes.addFlashAttribute("error", "Incorrect current password!");
			return "redirect:/settings";
		}

		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "New passwords do not match!");
			return "redirect:/settings";
		}

		user.setPassword(passwordEncoder.encode(newPassword));
		userRepository.save(user);
		session.setAttribute("user", user);

		redirectAttributes.addFlashAttribute("success", "Password updated successfully!");
		return "redirect:/settings";
	}

	@GetMapping("/hackathonDetail/{id}")
	public String hackathonDetail(@PathVariable Integer id, Model model, HttpSession session) {

		HackathonEntity hack = hackathonRepository.findById(id).orElseThrow();
		HackathonDescriptionEntity description = hackathonDescriptionRepository.findByHackathon_HackathonId(id);
		UserEntity user = (UserEntity) session.getAttribute("user");

		boolean isRegistered = false;
		boolean hasCreatedTeam = false;

		if (user != null) {
			isRegistered = registrationRepository.existsByUserUserIdAndHackathonHackathonId(user.getUserId(), id);

			// Check if user already created a team for this hackathon
			hasCreatedTeam = hackathonTeamRepository.existsByHackathon_HackathonIdAndTeamLeader_UserId(id,
					user.getUserId());
		}

		// Get all teams with their members
		List<HackathonTeamEntity> teams = hackathonTeamRepository.findByHackathon_HackathonId(id);

		// Feature 5: Participant count for this hackathon
		long participantCount = registrationRepository.countByHackathon_HackathonId(id);

		model.addAttribute("hack", hack);
		model.addAttribute("description", description);
		model.addAttribute("isRegistered", isRegistered);
		model.addAttribute("hasCreatedTeam", hasCreatedTeam);
		model.addAttribute("teams", teams);
		model.addAttribute("participantCount", participantCount);

		return "participants/HackathonDetails";
	}
	
	
	//notification
	
	 @GetMapping("/participant/notifications")
	    public String notifications(HttpSession session, Model model) {

	        UserEntity user = (UserEntity) session.getAttribute("user");

	        // not logged in
	        if (user == null) {
	            return "redirect:/login";
	        }

	        // get user notifications
	        List<NotificationEntity> notifications =
	                notificationRepository
	                .findByUserUserIdOrderByCreatedAtDesc(user.getUserId());

	        model.addAttribute("notifications", notifications);

	        return "participants/notifications";
	    }
	 
	 //leaderBoard
	 
	 @GetMapping("/leaderboard")
	 public String leaderboard(@RequestParam Integer hackathonId, Model model) {

	     List<LeaderboardDTO> leaderboard = evaluationRepo.getLeaderboard(hackathonId);

	     model.addAttribute("leaderboard", leaderboard);
	     // Feature 4: Pass hackathonId to JSP for CSV export link
	     model.addAttribute("hackathonId", hackathonId);

	     return "/participants/leaderboard";
	 }

	 // Feature 4: Export leaderboard to CSV
	 @GetMapping("/leaderboard/export")
	 public void exportLeaderboardCsv(@RequestParam Integer hackathonId, HttpServletResponse response) throws IOException {
	     response.setContentType("text/csv");
	     response.setHeader("Content-Disposition", "attachment; filename=leaderboard_" + hackathonId + ".csv");

	     List<LeaderboardDTO> leaderboard = evaluationRepo.getLeaderboard(hackathonId);

	     PrintWriter writer = response.getWriter();
	     // CSV Header
	     writer.println("Rank,Team,Innovation,Technical,UI/UX,Functionality,Presentation,Impact,Total,Remarks");

	     int rank = 1;
	     for (LeaderboardDTO e : leaderboard) {
	         writer.println(
	             rank + "," +
	             escapeCsv(e.getTeamName()) + "," +
	             e.getInnovation() + "," +
	             e.getTechnical() + "," +
	             e.getUiUx() + "," +
	             e.getFunctionality() + "," +
	             e.getPresentation() + "," +
	             e.getImpact() + "," +
	             e.getTotalScore() + "," +
	             escapeCsv(e.getRemarks())
	         );
	         rank++;
	     }
	     writer.flush();
	 }

	 // Helper: escape CSV fields that may contain commas or quotes
	 private String escapeCsv(String value) {
	     if (value == null) return "";
	     if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
	         return "\"" + value.replace("\"", "\"\"") + "\"";
	     }
	     return value;
	 }
	 
	 //leaderboardlist
	 
	 @GetMapping("/leaderboardList")
	 public String leaderboardList(Model model){

	     List<HackathonEntity> hackathons = hackathonRepository.findAll();

	     model.addAttribute("hackathons", hackathons);

	     return "/participants/leaderboardList";
	 }

	 // Discovery & Public Profile
	 @GetMapping("/participant/discovery")
	 public String discovery(Model model, HttpSession session) {
		 UserEntity currentUser = (UserEntity) session.getAttribute("user");
		 if (currentUser == null) return "redirect:/login";

		 List<UserEntity> participants = userRepository.findByRole("PARTICIPANT");
		 
		 // Optimization: Fetch all details in batch to avoid N+1 in JSP
		 List<Integer> participantIds = participants.stream().map(UserEntity::getUserId).collect(Collectors.toList());
		 List<UserDetailEntity> details = userDetailRepository.findByUserIdIn(participantIds);
		 
		 // Build a map for easy lookup in JSP
		 Map<Integer, UserDetailEntity> detailMap = details.stream()
				 .collect(Collectors.toMap(UserDetailEntity::getUserId, d -> d));

		 model.addAttribute("participants", participants);
		 model.addAttribute("detailMap", detailMap); 
		 return "/participants/Discovery";
	 }

	 @GetMapping("/participant/profile/{userId}")
	 public String publicProfile(@PathVariable Integer userId, Model model, HttpSession session) {
		 UserEntity currentUser = (UserEntity) session.getAttribute("user");
		 if (currentUser == null) return "redirect:/login";

		 UserEntity user = userRepository.findById(userId).orElseThrow();
		 UserDetailEntity userDetail = userDetailRepository.findByUserId(userId).orElse(new UserDetailEntity());
		 List<HackathonRegistrationEntity> registrations = registrationRepository.findByUserUserId(userId);

		 model.addAttribute("publicUser", user);
		 model.addAttribute("publicUserDetail", userDetail);
		 model.addAttribute("registrations", registrations);
		 return "/participants/PublicProfile";
	 }

	 // Feature 5: Helper method to build participant count map (avoids N+1)
	 private Map<Integer, Long> buildParticipantCountMap() {
		 List<Object[]> rawCounts = registrationRepository.countByHackathonGrouped();
		 Map<Integer, Long> map = new HashMap<>();
		 for (Object[] row : rawCounts) {
			 map.put((Integer) row[0], (Long) row[1]);
		 }
		 return map;
	 }

	 // Certificate Generation
	 @GetMapping("/participant/certificate/{hackathonId}")
	 public String getCertificate(@PathVariable Integer hackathonId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		 UserEntity currentUser = (UserEntity) session.getAttribute("user");
		 if (currentUser == null) return "redirect:/login";

		 // 1. Verify participation (must be in an ACCEPTED team member state or team leader)
		 HackathonTeamMembersEntity member = hackathonTeamMemberRepository.findByMember_UserIdAndTeam_Hackathon_HackathonId(currentUser.getUserId(), hackathonId);
		 
		 HackathonTeamEntity team = null;
		 if (member != null && "ACCEPTED".equals(member.getStatus())) {
			 team = member.getTeam();
		 } else {
			 // Fallback for team leaders
			 team = hackathonTeamRepository.findByHackathon_HackathonIdAndTeamLeader_UserId(hackathonId, currentUser.getUserId());
		 }

		 if (team == null) {
			 redirectAttributes.addFlashAttribute("error", "Certificate only available for participants who were part of an accepted team.");
			 return "redirect:/userHome";
		 }

		 HackathonEntity hackathon = team.getHackathon();
		 if (!"COMPLETED".equalsIgnoreCase(hackathon.getStatus())) {
			 redirectAttributes.addFlashAttribute("error", "Certificates are only issued after the hackathon is completed.");
			 return "redirect:/userHome";
		 }

		 model.addAttribute("user", currentUser);
		 model.addAttribute("hackathon", hackathon);
		 model.addAttribute("team", team);
		 model.addAttribute("placement", team.getPlacement());

		 return "/participants/Certificate";
	 }

}