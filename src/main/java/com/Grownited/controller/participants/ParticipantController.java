package com.Grownited.controller.participants;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Grownited.dto.LeaderboardDTO;
import com.Grownited.entity.HackathonDescriptionEntity;
import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.NotificationEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonDescriptionRepository;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.NotificationRepository;
import com.Grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

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


	@GetMapping("userHome")
	public String userHomePage(Model model, HttpSession session) {

		UserEntity currentUser = (UserEntity) session.getAttribute("user");

		List<HackathonEntity> hackathonList = hackathonRepository.findAll();

		List<HackathonRegistrationEntity> myRegistrations = registrationRepository
				.findByUserUserId(currentUser.getUserId());
		// 🔥 Attach teamName dynamically
		for (HackathonRegistrationEntity reg : myRegistrations) {

			HackathonTeamMembersEntity tm = hackathonTeamMemberRepository
					.findByMember_UserIdAndTeam_Hackathon_HackathonId(currentUser.getUserId(),
							reg.getHackathon().getHackathonId());

			if (tm != null) {
				reg.setTeamName(tm.getTeam().getTeamName()); // ✔ from your entity
			} else {
				reg.setTeamName("—");
			}
		}

		model.addAttribute("user", currentUser);
		model.addAttribute("hackathonList", hackathonList);
		model.addAttribute("myRegistrations", myRegistrations);

		return "/participants/DashBoard";
	}

	// Hackathon list page
	@GetMapping("hackathons")
	public String hackathonList(Model model, HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		List<HackathonEntity> hackathonList = hackathonRepository.findAll();

		// Check which hackathons the user has registered for
		List<Integer> registeredHackathonIds = registrationRepository.findByUserUserId(currentUser.getUserId()).stream()
				.map(reg -> reg.getHackathon().getHackathonId()).collect(Collectors.toList());

		model.addAttribute("user", currentUser);
		model.addAttribute("hackathonList", hackathonList);
		model.addAttribute("registeredHackathonIds", registeredHackathonIds); // use in JSP to show registration status
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
	public String profile() {
		return "/participants/profile";
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

		model.addAttribute("hack", hack);
		model.addAttribute("description", description);
		model.addAttribute("isRegistered", isRegistered);
		model.addAttribute("hasCreatedTeam", hasCreatedTeam);
		model.addAttribute("teams", teams);

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

	     return "/participants/leaderboard";
	 }
	 
	 //leaderboardlist
	 
	 @GetMapping("/leaderboardList")
	 public String leaderboardList(Model model){

	     List<HackathonEntity> hackathons = hackathonRepository.findAll();

	     model.addAttribute("hackathons", hackathons);

	     return "/participants/leaderboardList";
	 }

}