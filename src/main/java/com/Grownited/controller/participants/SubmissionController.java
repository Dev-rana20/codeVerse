package com.Grownited.controller.participants;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.SubmissionEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.enums.SubmissionType;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.SubmissionRepository;

import com.Grownited.service.NotificationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SubmissionController {

	@Autowired
	HackathonTeamRepository hackathonTeamRepository;

	
	@Autowired
	HackathonTeamMemberRepository hackathonTeamMemberRepository;

	@Autowired
	SubmissionRepository submissionRepository;

	@Autowired
	HackathonRegistrationRepository registrationRepository;

	@Autowired
	NotificationService notificationService;

	@GetMapping("/participant/submissions/{hackId}")
	public String submissionPage(@PathVariable Integer hackId, HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user == null) {
			return "redirect:/login";
		}

		// ✅ Get user's team for this hackathon
		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository
				.findByMember_UserIdAndTeam_Hackathon_HackathonId(user.getUserId(), hackId);

		if (tm == null) {
			model.addAttribute("error", "You are not part of any team for this hackathon");
			return "participants/submissions";
		}

		HackathonTeamEntity team = tm.getTeam();

		// ✅ Get member submissions (ACTIVE only)
		List<SubmissionEntity> submissions = submissionRepository.findByTeamAndTypeAndStatus(team,
				SubmissionType.MEMBER, "ACTIVE");

		// ✅ Get final submission (Single expected)
		List<SubmissionEntity> finalSubmissions = submissionRepository.findByTeamAndType(team, SubmissionType.FINAL);

		SubmissionEntity finalSubmission = null;

		if (finalSubmissions != null && !finalSubmissions.isEmpty()) {
			finalSubmission = finalSubmissions.get(0);
		}

		model.addAttribute("team", team);
		model.addAttribute("submissions", submissions);
		model.addAttribute("finalSubmission", finalSubmission);

		return "participants/submissions";
	}

	@GetMapping("/participant/submissions")
	public String submissionsHome(HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		// All hackathons user registered in
		List<HackathonRegistrationEntity> myRegistrations = registrationRepository.findByUserUserId(user.getUserId());

		model.addAttribute("registrations", myRegistrations);

		return "participants/submissionHome"; // NEW JSP
	}

	@PostMapping("/team/upload")
	public String uploadWork(@RequestParam Integer teamId, @RequestParam String link, @RequestParam String description,
			HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		SubmissionEntity submission = new SubmissionEntity();
		submission.setTeam(team);
		submission.setUser(user);
		submission.setGithubLink(link);
		submission.setDescription(description);
		submission.setType(SubmissionType.MEMBER);
		submission.setStatus("ACTIVE");

		submissionRepository.save(submission);
		// 🔔 Notify Team Members
		List<HackathonTeamMembersEntity> members = hackathonTeamMemberRepository.findByTeam(team);

		for (HackathonTeamMembersEntity m : members) {

			// Skip uploader
			if (!m.getMember().getUserId().equals(user.getUserId())) {

				notificationService.createNotification(m.getMember(),
						user.getFirstName() + " uploaded new work in team " + team.getTeamName(), "SUBMISSION",
						"/participant/submissions/" + team.getHackathon().getHackathonId());
			}
		}

		ra.addFlashAttribute("success", "Work uploaded successfully!");

		Integer hackId = team.getHackathon().getHackathonId();

		return "redirect:/participant/submissions/" + hackId;
	}

	@PostMapping("/team/finalSubmit")
	public String finalSubmit(@RequestParam Integer teamId, @RequestParam String finalLink,@RequestParam String description, HttpSession session,
			RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// leader check
		if (!team.getTeamLeader().getUserId().equals(user.getUserId())) {
			ra.addFlashAttribute("error", "Only leader can submit final work");
			return "redirect:/team/details/" + teamId;
		}

		List<SubmissionEntity> finals = submissionRepository.findByTeamAndTypeAndStatus(team, SubmissionType.FINAL,
				"SUBMITTED");

		SubmissionEntity existingFinal = null;

		if (!finals.isEmpty()) {
			existingFinal = finals.get(0);
		}

		if (existingFinal != null) {
			existingFinal.setGithubLink(finalLink);
			existingFinal.setDescription(description); 
			submissionRepository.save(existingFinal);
		} else {
			SubmissionEntity finalSubmission = new SubmissionEntity();
			finalSubmission.setTeam(team);
			finalSubmission.setUser(user);
			finalSubmission.setGithubLink(finalLink);
			finalSubmission.setDescription(description);
			finalSubmission.setType(SubmissionType.FINAL);
			finalSubmission.setStatus("SUBMITTED");

			submissionRepository.save(finalSubmission);

			// 🔔 Notify Team Members
			List<HackathonTeamMembersEntity> members = hackathonTeamMemberRepository.findByTeam(team);

			for (HackathonTeamMembersEntity m : members) {

				notificationService.createNotification(m.getMember(),
						"Final submission submitted for team " + team.getTeamName(), "FINAL_SUBMISSION",
						"/team/details/" + teamId);
			}
		}
		team.setFinalSubmissionLink(finalLink);
		hackathonTeamRepository.save(team);

		ra.addFlashAttribute("success", "Final submission done!");
		return "redirect:/team/details/" + teamId;
	}

	@PostMapping("/team/deleteSubmission")
	public String deleteSubmission(@RequestParam Integer submissionId, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		SubmissionEntity submission = submissionRepository.findById(submissionId).orElse(null);

		if (submission == null) {
			ra.addFlashAttribute("error", "Submission not found");
			return "redirect:/participant/submissions";
		}

		HackathonTeamEntity team = submission.getTeam();

		// ✅ Allow only owner OR team leader
		if (!submission.getUser().getUserId().equals(user.getUserId())
				&& !team.getTeamLeader().getUserId().equals(user.getUserId())) {

			ra.addFlashAttribute("error", "You can't delete this submission");
			return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
		}

		// ✅ Soft delete (recommended)
		submission.setStatus("DELETED");
		submissionRepository.save(submission);

		ra.addFlashAttribute("success", "Submission deleted");

		return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
	}
}
