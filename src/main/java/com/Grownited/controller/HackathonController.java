package com.Grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Comparator;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Grownited.entity.HackathonDescriptionEntity;
import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.HackathonDescriptionRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.UserTypeRepository;
import com.cloudinary.Cloudinary;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonJudgeRepository;
import com.Grownited.repository.HackathonPrizeRepository;
import com.Grownited.repository.SubmissionRepository;
import com.Grownited.repository.TeamJoinRequestRepository;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.service.NotificationService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

import com.Grownited.service.HackathonService;

@Controller
public class HackathonController {

	@Autowired
	HackathonRepository hackathonRepository;

	@Autowired
	UserTypeRepository userTypeRepository;

	@Autowired
	HackathonDescriptionRepository hackathonDescriptionRepository;

	@Autowired
	Cloudinary cloudinary;
	
	@Autowired
	EvaluationRepository evaluationRepository;
	
	@Autowired
	HackathonTeamRepository hackathonTeamRepository;
	
	@Autowired
	NotificationService notificationService;

	@Autowired
	HackathonRegistrationRepository hackathonRegistrationRepository;

	@Autowired
	HackathonTeamMemberRepository hackathonTeamMemberRepository;

	@Autowired
	HackathonJudgeRepository hackathonJudgeRepository;

	@Autowired
	HackathonPrizeRepository hackathonPrizeRepository;

	@Autowired
	SubmissionRepository submissionRepository;

	@Autowired
	TeamJoinRequestRepository teamJoinRequestRepository;

	@Autowired
	HackathonService hackathonService;

	@GetMapping("newHackathon")
	public String newHackathon(Model model) {

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("allUserType", allUserType);
		return "NewHackathon";
	}



	@PostMapping("saveHackathon")
	public String saveHackathon(@Valid HackathonEntity hackathonEntity, BindingResult result, HttpSession session, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("error", "Please correct the highlighted errors.");
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "NewHackathon";
		}

		// Server-side date consistency checks
		if (hackathonEntity.getRegistrationStartDate() != null && hackathonEntity.getRegistrationEndDate() != null) {
			if (hackathonEntity.getRegistrationEndDate().isBefore(hackathonEntity.getRegistrationStartDate())) {
				model.addAttribute("error", "Registration end date cannot be before start date.");
				model.addAttribute("allUserType", userTypeRepository.findAll());
				return "NewHackathon";
			}
		}

		UserEntity currentLogInUser = (UserEntity) session.getAttribute("user");

		hackathonEntity.setUserId(currentLogInUser.getUserId());
		hackathonRepository.save(hackathonEntity);
		return "redirect:/addHackathonDescription";
	}

	@GetMapping("listHackathon")
	public String listHackathon(Model model) {
		java.time.LocalDate today = java.time.LocalDate.now();
		
		// Perform bulk updates in single DB calls instead of looping
		hackathonService.updateHackathonStatuses();
		
		List<HackathonEntity> allHackathon = hackathonRepository.findAll();
		model.addAttribute("allHackathon", allHackathon);
		return "ListHackathon";
	}

	// Feature 1: Safe cascade hard-delete (changed from GET to POST, added @Transactional)
	@Transactional
	@PostMapping("deleteHackathon")
	public String deleteHackathon(@RequestParam Integer hackathonId, RedirectAttributes redirectAttributes) {
		try {
			// Delete in correct FK dependency order:
			// 1. Evaluations (depends on teams)
			evaluationRepository.deleteByTeam_Hackathon_HackathonId(hackathonId);
			// 2. Submissions (depends on teams)
			submissionRepository.deleteByTeam_Hackathon_HackathonId(hackathonId);
			// 3. Team join requests (depends on teams)
			teamJoinRequestRepository.deleteByHackathonId(hackathonId);
			// 4. Team members (depends on teams)
			hackathonTeamMemberRepository.deleteByTeam_Hackathon_HackathonId(hackathonId);
			// 5. Teams (depends on hackathon)
			hackathonTeamRepository.deleteByHackathon_HackathonId(hackathonId);
			// 6. Registrations (depends on hackathon)
			hackathonRegistrationRepository.deleteByHackathon_HackathonId(hackathonId);
			// 7. Judge assignments (depends on hackathon)
			hackathonJudgeRepository.deleteByHackathon_HackathonId(hackathonId);
			// 8. Prizes (depends on hackathon)
			hackathonPrizeRepository.deleteByHackathonId(hackathonId);
			// 9. Description (depends on hackathon)
			HackathonDescriptionEntity desc = hackathonDescriptionRepository.findByHackathon_HackathonId(hackathonId);
			if (desc != null) {
				hackathonDescriptionRepository.delete(desc);
			}
			// 10. Hackathon itself
			hackathonRepository.deleteById(hackathonId);

			redirectAttributes.addFlashAttribute("success", "Hackathon deleted successfully!");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "Failed to delete hackathon: " + e.getMessage());
		}

		return "redirect:/listHackathon";
	}

	@GetMapping("viewHackathon")
	public String viewHackathon(Integer hackathonId, Model model) {

		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);

		if (opHackathon.isEmpty()) {
			return "redirect:/listHackathon";
		}

		HackathonEntity hackathonEntity = opHackathon.get();
		model.addAttribute("hackathon", hackathonEntity);

		HackathonDescriptionEntity descList = 
		        hackathonDescriptionRepository.findByHackathon_HackathonId(hackathonId);

		model.addAttribute("descList", descList);


		model.addAttribute("hackathonDescriptionEntity", descList);
		
		if ("COMPLETED".equals(hackathonEntity.getStatus())) {
			List<HackathonTeamEntity> allTeams = hackathonTeamRepository.findByHackathon_HackathonId(hackathonId);
			List<HackathonTeamEntity> winners = allTeams.stream()
				.filter(t -> t.getPlacement() != null)
				.sorted(Comparator.comparing(HackathonTeamEntity::getPlacement))
				.collect(Collectors.toList());
			model.addAttribute("winners", winners);
		}

		return "ViewHackathon";
	}

	@GetMapping("addHackathonDescription")
	public String addHackathonDescription(Model model) {

		List<HackathonEntity> hackathons = hackathonRepository.findAll();

		model.addAttribute("hackathons", hackathons);

		return "AddHackathonDescription";
	}



	@PostMapping("saveHackathonDescription")
	public String saveHackathonDescription(
	        @RequestParam("hackathonId") Integer hackathonId,
	        @RequestParam("hackathonDetails") MultipartFile hackathonDetails,
	        @RequestParam("hackathonDetailsText") String hackathonDetailsText) {

	    HackathonDescriptionEntity description = new HackathonDescriptionEntity();

	    // 1️⃣ Set the text
	    description.setHackathonDetailsText(hackathonDetailsText);

	    // 2️⃣ Upload file to Cloudinary
	    if (hackathonDetails != null && !hackathonDetails.isEmpty()) {
		    try {
		        Map<?, ?> map = cloudinary.uploader().upload(hackathonDetails.getBytes(), null);
		        String uploadedURL = map.get("secure_url").toString();
		        description.setHackathonDetailsURL(uploadedURL);
		        System.out.println("Uploaded URL: " + uploadedURL);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
	    }

	    // 3️⃣ Fetch the Hackathon entity and set it
	    HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElse(null);
	    if (hackathon == null) {
	        throw new RuntimeException("Hackathon ID not found: " + hackathonId);
	    }
	    description.setHackathon(hackathon);

	    // 4️⃣ Save the description
	    hackathonDescriptionRepository.save(description);

	    return "redirect:/listHackathon";
	}

	// ── Edit Hackathon ──────────────────────────────────────────────

	@GetMapping("editHackathon")
	public String editHackathon(@RequestParam Integer hackathonId, Model model) {

		HackathonEntity hackathon = hackathonRepository.findById(hackathonId)
				.orElseThrow(() -> new RuntimeException("Hackathon not found: " + hackathonId));

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("hackathon", hackathon);
		model.addAttribute("allUserType", allUserType);
		return "EditHackathon";
	}

	@PostMapping("updateHackathon")
	public String updateHackathon(@Valid HackathonEntity hackathonEntity, BindingResult result, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("error", "Please correct the highlighted errors.");
			model.addAttribute("hackathon", hackathonEntity);
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "EditHackathon";
		}

		// Server-side date consistency checks
		if (hackathonEntity.getRegistrationStartDate() != null && hackathonEntity.getRegistrationEndDate() != null) {
			if (hackathonEntity.getRegistrationEndDate().isBefore(hackathonEntity.getRegistrationStartDate())) {
				model.addAttribute("error", "Registration end date cannot be before start date.");
				model.addAttribute("hackathon", hackathonEntity);
				model.addAttribute("allUserType", userTypeRepository.findAll());
				return "EditHackathon";
			}
		}

		// Capture the old status to detect when it changes to COMPLETED
		HackathonEntity oldHackathon = hackathonRepository.findById(hackathonEntity.getHackathonId()).orElse(null);
		boolean justCompleted = oldHackathon != null 
		                        && !"COMPLETED".equals(oldHackathon.getStatus()) 
		                        && "COMPLETED".equals(hackathonEntity.getStatus());

		// Ensure we are updating the existing one (the ID should be in the entity from the hidden form field)
		hackathonRepository.save(hackathonEntity);
		
		if (justCompleted) {
			List<HackathonTeamEntity> rankedTeams = evaluationRepository.getRankedTeamsByHackathon(hackathonEntity.getHackathonId());
			for (int i = 0; i < rankedTeams.size() && i < 3; i++) {
				HackathonTeamEntity team = rankedTeams.get(i);
				team.setPlacement(i + 1);
				hackathonTeamRepository.save(team);
				
				// Notify all members
				if (team.getMembers() != null) {
					for (HackathonTeamMembersEntity member : team.getMembers()) {
						if ("ACCEPTED".equals(member.getStatus())) {
							notificationService.createNotification(
								member.getMember(),
								"Congratulations! Your team won " + (i + 1) + " place in " + hackathonEntity.getTitle() + "!",
								"WINNER",
								"/participant/team"
							);
						}
					}
				}
			}
		}
		
		return "redirect:/listHackathon";
	}

}
