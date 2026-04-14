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

import com.Grownited.service.MailerService;
import com.Grownited.service.NotificationService;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.Map;

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

	@Autowired
	MailerService mailerService;

	@Autowired
	Cloudinary cloudinary;

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

		for (HackathonRegistrationEntity reg : myRegistrations) {
			HackathonTeamMembersEntity tm = hackathonTeamMemberRepository
					.findByMember_UserIdAndTeam_Hackathon_HackathonId(user.getUserId(), reg.getHackathon().getHackathonId());
			
			if (tm != null) {
				boolean exists = submissionRepository.existsByTeamAndTypeAndStatus(tm.getTeam(), SubmissionType.FINAL, "SUBMITTED");
				reg.setFinalSubmitted(exists);
			}
		}

		model.addAttribute("registrations", myRegistrations);

		return "participants/submissionHome"; // NEW JSP
	}


	@PostMapping("/team/upload")
	public String uploadWork(@Valid SubmissionEntity submission, BindingResult result, @RequestParam Integer teamId,
			@RequestParam(required = false) String link,
			@RequestParam(required = false) MultipartFile projectFile,
			@RequestParam(required = false) MultipartFile projectVideo, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");
		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		if (result.hasErrors()) {
			ra.addFlashAttribute("error", result.getFieldError("description").getDefaultMessage());
			return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
		}

		// 🚫 Enforce submission deadline
		java.time.LocalDate deadline = team.getHackathon().getSubmissionDeadline();
		if (deadline != null && java.time.LocalDate.now().isAfter(deadline)) {
			ra.addFlashAttribute("error", "Submission deadline has passed for this hackathon.");
			return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
		}

		// 🚫 Prevent upload if FINAL submission is already done
		boolean finalDone = submissionRepository.existsByTeamAndTypeAndStatus(team, SubmissionType.FINAL, "SUBMITTED");
		if (finalDone) {
			ra.addFlashAttribute("error", "Final submission is already done. No more uploads allowed.");
			return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
		}

		submission.setTeam(team);
		submission.setUser(user);
		submission.setGithubLink(link);
		submission.setType(SubmissionType.MEMBER);
		submission.setStatus("ACTIVE");

		// 📁 HANDLE FILE UPLOAD (Max 10MB)
		if (projectFile != null && !projectFile.isEmpty()) {
			if (projectFile.getSize() > 10 * 1024 * 1024) {
				ra.addFlashAttribute("error", "Project file exceeds 10MB limit.");
				return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
			}
			try {
				Map<?, ?> uploadResult = cloudinary.uploader().upload(projectFile.getBytes(),
						ObjectUtils.asMap("resource_type", "auto", "transformation", "q_auto,f_auto"));
				submission.setFileUrl(uploadResult.get("secure_url").toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 🎥 HANDLE VIDEO UPLOAD (Max 50MB)
		if (projectVideo != null && !projectVideo.isEmpty()) {
			if (projectVideo.getSize() > 50 * 1024 * 1024) {
				ra.addFlashAttribute("error", "Demo video exceeds 50MB limit.");
				return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
			}
			try {
				Map<?, ?> uploadResult = cloudinary.uploader().upload(projectVideo.getBytes(),
						ObjectUtils.asMap("resource_type", "video", "transformation", "w_720"));
				submission.setVideoUrl(uploadResult.get("secure_url").toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		submissionRepository.save(submission);
		mailerService.sendSubmissionConfirmationMail(user, team, submission);
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
	public String finalSubmit(@Valid SubmissionEntity submission, BindingResult result, @RequestParam Integer teamId, 
			@RequestParam(required = false) String finalLink,
			@RequestParam(required = false) MultipartFile projectFile,
			@RequestParam(required = false) MultipartFile projectVideo, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");
		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		if (result.hasErrors()) {
			ra.addFlashAttribute("error", result.getFieldError("description").getDefaultMessage());
			return "redirect:/team/details/" + teamId;
		}

		// 🚫 Enforce submission deadline
		java.time.LocalDate deadline = team.getHackathon().getSubmissionDeadline();
		if (deadline != null && java.time.LocalDate.now().isAfter(deadline)) {
			ra.addFlashAttribute("error", "Submission deadline has passed for this hackathon.");
			return "redirect:/team/details/" + teamId;
		}

		// 🚫 Prevent resubmission if FINAL submission is already done
		boolean finalDone = submissionRepository.existsByTeamAndTypeAndStatus(team, SubmissionType.FINAL, "SUBMITTED");
		if (finalDone) {
			ra.addFlashAttribute("error", "Final submission is already done. You cannot submit again.");
			return "redirect:/participant/submissions/" + team.getHackathon().getHackathonId();
		}

		// leader check
		if (!team.getTeamLeader().getUserId().equals(user.getUserId())) {
			ra.addFlashAttribute("error", "Only leader can submit final work");
			return "redirect:/team/details/" + teamId;
		}

		// 👥 MIN TEAM SIZE CHECK
		long acceptedCount = hackathonTeamMemberRepository.findByTeam(team).stream()
				.filter(m -> "ACCEPTED".equals(m.getStatus())).count();
		Integer minSize = team.getHackathon().getMinTeamSize();
		
		if (minSize != null && acceptedCount < minSize) {
			ra.addFlashAttribute("error", "Team does not meet minimum size requirement. At least " + minSize + " members must have accepted the invitation.");
			return "redirect:/team/details/" + teamId;
		}

		List<SubmissionEntity> finals = submissionRepository.findByTeamAndTypeAndStatus(team, SubmissionType.FINAL,
				"SUBMITTED");

		SubmissionEntity subToSave = finals.isEmpty() ? submission : finals.get(0);
		
		if (!finals.isEmpty()) {
			subToSave.setDescription(submission.getDescription());
			// other fields would be updated below
		}

		subToSave.setTeam(team);
		subToSave.setUser(user);
		subToSave.setGithubLink(finalLink);
		subToSave.setType(SubmissionType.FINAL);
		subToSave.setStatus("SUBMITTED");

		// 📁 HANDLE FILE UPLOAD (Max 10MB)
		if (projectFile != null && !projectFile.isEmpty()) {
			if (projectFile.getSize() > 10 * 1024 * 1024) {
				ra.addFlashAttribute("error", "Project file exceeds 10MB limit.");
				return "redirect:/team/details/" + teamId;
			}
			try {
				Map<?, ?> uploadResult = cloudinary.uploader().upload(projectFile.getBytes(),
						ObjectUtils.asMap("resource_type", "auto", "transformation", "q_auto,f_auto"));
				subToSave.setFileUrl(uploadResult.get("secure_url").toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 🎥 HANDLE VIDEO UPLOAD (Max 50MB)
		if (projectVideo != null && !projectVideo.isEmpty()) {
			if (projectVideo.getSize() > 50 * 1024 * 1024) {
				ra.addFlashAttribute("error", "Demo video exceeds 50MB limit.");
				return "redirect:/team/details/" + teamId;
			}
			try {
				Map<?, ?> uploadResult = cloudinary.uploader().upload(projectVideo.getBytes(),
						ObjectUtils.asMap("resource_type", "video", "transformation", "w_720"));
				subToSave.setVideoUrl(uploadResult.get("secure_url").toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		submissionRepository.save(subToSave);
		mailerService.sendSubmissionConfirmationMail(user, team, subToSave);

		if (finals.isEmpty()) {
			// 🔔 Notify Team Members
			List<HackathonTeamMembersEntity> members = hackathonTeamMemberRepository.findByTeam(team);
			for (HackathonTeamMembersEntity m : members) {
				notificationService.createNotification(m.getMember(),
						"Final submission submitted for team " + team.getTeamName(), "FINAL_SUBMISSION",
						"/team/details/" + teamId);
			}
		}

		if (finalLink != null) {
			team.setFinalSubmissionLink(finalLink);
			hackathonTeamRepository.save(team);
		}

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
