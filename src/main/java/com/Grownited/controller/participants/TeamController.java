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

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.SubmissionRepository;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.entity.SubmissionEntity;
import com.Grownited.entity.EvaluationEntity;
import com.Grownited.enums.SubmissionType;
import com.Grownited.service.MailerService;
import com.Grownited.service.NotificationService;
import com.Grownited.repository.TeamCommunicationRepository;
import com.Grownited.entity.TeamCommunicationEntity;

import jakarta.servlet.http.HttpSession;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

@Controller
public class TeamController {

	@Autowired
	HackathonRepository hackathonRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	HackathonTeamRepository hackathonTeamRepository;

	@Autowired
	HackathonTeamMemberRepository hackathonTeamMemberRepository;

	@Autowired
	HackathonRegistrationRepository registrationRepository;

	@Autowired
	NotificationService notificationService;

	@Autowired
	MailerService mailerService;

	@Autowired
	SubmissionRepository submissionRepository;

	@Autowired
	EvaluationRepository evaluationRepository;

	@Autowired
	TeamCommunicationRepository teamCommunicationRepository;

	@GetMapping("/participant/team-register")
	public String openTeamRegister(@RequestParam Integer hackathonId, HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user == null)
			return "redirect:/login";

		HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElseThrow();

		// Check if user already created a team for this hackathon
		boolean hasCreatedTeam = hackathonTeamRepository.existsByHackathon_HackathonIdAndTeamLeader_UserId(hackathonId,
				user.getUserId());

		List<HackathonRegistrationEntity> registrations = registrationRepository
				.findByHackathon_HackathonId(hackathonId);

		List<UserEntity> registeredUsers = registrations.stream().map(HackathonRegistrationEntity::getUser)
				.filter(u -> !u.getUserId().equals(user.getUserId())) // ❌ remove self
				.filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole())) // ❌ remove admins
				.toList();

		List<HackathonTeamEntity> teams = hackathonTeamRepository.findByHackathon_HackathonId(hackathonId);

		model.addAttribute("hackathon", hackathon);
		model.addAttribute("users", registeredUsers);
		model.addAttribute("teams", teams);
		model.addAttribute("hasCreatedTeam", hasCreatedTeam);

		return "participants/teamRegister";
	}


	@PostMapping("/team/create")
	public String createTeam(@Valid HackathonTeamEntity team, BindingResult result, @RequestParam Integer hackathonId,
			@RequestParam(required = false) List<Integer> memberIds, HttpSession session,
			Model model, RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			UserEntity user = (UserEntity) session.getAttribute("user");
			HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElseThrow();
			List<HackathonRegistrationEntity> registrations = registrationRepository.findByHackathon_HackathonId(hackathonId);
			List<UserEntity> registeredUsers = registrations.stream().map(HackathonRegistrationEntity::getUser)
					.filter(u -> !u.getUserId().equals(user.getUserId())).filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole())).toList();
			List<HackathonTeamEntity> teams = hackathonTeamRepository.findByHackathon_HackathonId(hackathonId);
			
			model.addAttribute("hackathon", hackathon);
			model.addAttribute("users", registeredUsers);
			model.addAttribute("teams", teams);
			model.addAttribute("error", "Team name is required and must be at least 3 characters.");
			return "participants/teamRegister";
		}

		UserEntity currentUser = (UserEntity) session.getAttribute("user");

		if (currentUser == null) {
			return "redirect:/login";
		}

		HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElseThrow();

		// Check if user already created or joined a team for this hackathon
		boolean hasTeam = hackathonTeamRepository.existsByHackathon_HackathonIdAndTeamLeader_UserId(hackathonId,
				currentUser.getUserId());
		boolean alreadyInTeam = hackathonTeamMemberRepository.existsByMember_UserIdAndTeam_Hackathon_HackathonId(
				currentUser.getUserId(), hackathonId);

		if (hasTeam || alreadyInTeam) {
			redirectAttributes.addFlashAttribute("error",
					"You are already part of a team or have pending invites/requests for this hackathon.");
			return "redirect:/participant/team-register?hackathonId=" + hackathonId;
		}

		// ✅ Enforce max team size at creation
		int invitedCount = (memberIds != null) ? memberIds.size() : 0;
		int totalOnCreate = 1 + invitedCount; // leader + invitees
		if (hackathon.getMaxTeamSize() != null && totalOnCreate > hackathon.getMaxTeamSize()) {
			redirectAttributes.addFlashAttribute("error",
					"Team size exceeds the maximum allowed (" + hackathon.getMaxTeamSize() + " members).");
			return "redirect:/participant/team-register?hackathonId=" + hackathonId;
		}

		// 1. CREATE TEAM (team object already bound from request)
		team.setHackathon(hackathon);
		team.setTeamLeader(currentUser);

		hackathonTeamRepository.save(team);

		// 2. ADD CREATOR AS ACCEPTED MEMBER
		HackathonTeamMembersEntity owner = new HackathonTeamMembersEntity();
		owner.setTeam(team);
		owner.setMember(currentUser);
		owner.setStatus("ACCEPTED");
		owner.setRoleTitle("LEADER");

		hackathonTeamMemberRepository.save(owner);

		// 3. ADD INVITED MEMBERS AS PENDING
		if (memberIds != null) {
			for (Integer userId : memberIds) {
				UserEntity user = userRepository.findById(userId).orElse(null);

				if (user != null && !user.getUserId().equals(currentUser.getUserId())) {
					HackathonTeamMembersEntity tm = new HackathonTeamMembersEntity();
					tm.setTeam(team);
					tm.setMember(user);
					tm.setStatus("PENDING");
					tm.setRoleTitle("MEMBER");

					hackathonTeamMemberRepository.save(tm);
					notificationService.createNotification(user,
							"You have been invited to join team " + team.getTeamName(), "INVITE", "/participant/team");
					mailerService.sendTeamInviteMail(user, team);
				}
			}
		}

		redirectAttributes.addFlashAttribute("success", "Team created successfully!");
		return "redirect:/hackathonDetail/" + hackathonId;
	}

	@GetMapping("/participant/team")
	public String myTeamPage(HttpSession session, Model model) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user == null) {
			return "redirect:/login";
		}

		// Teams where user is a member
		List<HackathonTeamMembersEntity> myTeams = hackathonTeamMemberRepository.findByMember(user);

		model.addAttribute("myTeams", myTeams);

		return "participants/MyTeam";
	}

	@PostMapping("/team/accept")
	public String acceptInvite(@RequestParam Integer teamId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				user.getUserId());

		if (tm != null && "PENDING".equals(tm.getStatus())) {
			tm.setStatus("ACCEPTED");
			hackathonTeamMemberRepository.save(tm);
			mailerService.sendInviteAcceptedMail(tm.getTeam().getTeamLeader(), user, tm.getTeam());
			redirectAttributes.addFlashAttribute("success", "Invitation accepted!");
		}

		return "redirect:/participant/team";
	}

	@PostMapping("/team/reject")
	public String rejectInvite(@RequestParam Integer teamId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				user.getUserId());

		if (tm != null && "PENDING".equals(tm.getStatus())) {
			hackathonTeamMemberRepository.delete(tm);
			redirectAttributes.addFlashAttribute("success", "Invitation rejected!");
		}

		return "redirect:/participant/team";
	}

	@GetMapping("/team/details/{teamId}")
	public String teamDetails(@PathVariable Integer teamId, Model model, HttpSession session) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		List<HackathonTeamMembersEntity> members = hackathonTeamMemberRepository.findByTeam(team);

		// 🔥 ONLY REQUESTED USERS
		List<HackathonTeamMembersEntity> requests = members.stream().filter(m -> "REQUESTED".equals(m.getStatus()))
				.toList();

		// 🎁 FETCH ELIGIBLE USERS TO INVITE (Registered but not in any team for this hackathon)
		List<HackathonRegistrationEntity> registrations = registrationRepository
				.findByHackathon_HackathonId(team.getHackathon().getHackathonId());

		List<UserEntity> eligibleUsers = registrations.stream().map(HackathonRegistrationEntity::getUser)
				.filter(u -> !u.getUserId().equals(user.getUserId())) // not self
				.filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole())) // not admin
				.filter(u -> !hackathonTeamMemberRepository.existsByMember_UserIdAndTeam_Hackathon_HackathonId(u.getUserId(),
						team.getHackathon().getHackathonId()))
				.toList();

		// 🚀 FETCH SUBMISSIONS
		List<SubmissionEntity> submissions = submissionRepository.findByTeam(team);
		SubmissionEntity finalSubmission = submissions.stream()
				.filter(s -> SubmissionType.FINAL.equals(s.getType()))
				.findFirst()
				.orElse(null);

		// Check if team is evaluated (fallback check)
		boolean isEvaluated = evaluationRepository.findByTeam(team) != null && !evaluationRepository.findByTeam(team).isEmpty();

		// 💬 FETCH TEAM COMMUNICATIONS
		List<TeamCommunicationEntity> communications = teamCommunicationRepository.findByTeamOrderByCreatedAtAsc(team);

		model.addAttribute("team", team);
		model.addAttribute("members", members);
		model.addAttribute("requests", requests);
		model.addAttribute("eligibleUsers", eligibleUsers);
		model.addAttribute("submissions", submissions);
		model.addAttribute("finalSubmission", finalSubmission);
		model.addAttribute("isEvaluated", isEvaluated);
		model.addAttribute("communications", communications);

		return "participants/TeamDetails";
	}

	@PostMapping("/team/invite")
	public String inviteMember(@RequestParam Integer teamId, @RequestParam Integer memberId, HttpSession session,
			RedirectAttributes ra) {

		UserEntity currentUser = (UserEntity) session.getAttribute("user");
		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ✅ Only leader
		if (!team.getTeamLeader().getUserId().equals(currentUser.getUserId())) {
			ra.addFlashAttribute("error", "Only leader can invite members");
			return "redirect:/participant/team";
		}

		UserEntity userToInvite = userRepository.findById(memberId).orElseThrow();

		// ❌ Check if already in a team
		boolean alreadyInTeam = hackathonTeamMemberRepository.existsByMember_UserIdAndTeam_Hackathon_HackathonId(memberId,
				team.getHackathon().getHackathonId());
		if (alreadyInTeam) {
			ra.addFlashAttribute("error", "User is already part of a team or has a pending invite.");
			return "redirect:/team/details/" + teamId;
		}

		// ✅ Create invite
		HackathonTeamMembersEntity invite = new HackathonTeamMembersEntity();
		invite.setTeam(team);
		invite.setMember(userToInvite);
		invite.setStatus("PENDING");
		invite.setRoleTitle("MEMBER");

		hackathonTeamMemberRepository.save(invite);

		notificationService.createNotification(userToInvite, "You have been invited to join team " + team.getTeamName(),
				"INVITE", "/participant/team");
		mailerService.sendTeamInviteMail(userToInvite, team);

		ra.addFlashAttribute("success", "Invitation sent to " + userToInvite.getFirstName());

		return "redirect:/team/details/" + teamId;
	}

	// Delete Team
	@PostMapping("/team/delete")
	public String deleteTeam(@RequestParam Integer teamId, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ✅ Only leader can delete
		if (!team.getTeamLeader().getUserId().equals(user.getUserId())) {
			ra.addFlashAttribute("error", "Only team leader can delete team");
			return "redirect:/participant/myTeam";
		}

		// ❌ Check for final submissions
		List<SubmissionEntity> finalSubmissions = submissionRepository.findByTeamAndType(team, SubmissionType.FINAL);
		if (finalSubmissions != null && !finalSubmissions.isEmpty()) {
			ra.addFlashAttribute("error", "Team cannot be deleted after making a final submission.");
			return "redirect:/participant/team";
		}

		// 🔥 delete evaluations first
		List<EvaluationEntity> evaluations = evaluationRepository.findByTeam(team);
		if (evaluations != null && !evaluations.isEmpty()) {
			evaluationRepository.deleteAll(evaluations);
		}

		// 🔥 delete submissions
		List<SubmissionEntity> submissions = submissionRepository.findByTeam(team);
		if (submissions != null && !submissions.isEmpty()) {
			submissionRepository.deleteAll(submissions);
		}

		// 🔥 delete members first
		hackathonTeamMemberRepository.deleteAll(team.getMembers());

		// 🔥 delete team
		hackathonTeamRepository.delete(team);

		ra.addFlashAttribute("success", "Team deleted successfully");

		return "redirect:/participant/team";
	}

	@PostMapping("/team/removeMember")
	public String removeMember(@RequestParam Integer memberId, @RequestParam Integer teamId, HttpSession session,
			RedirectAttributes ra) {

		UserEntity currentUser = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ✅ Only leader allowed
		if (!team.getTeamLeader().getUserId().equals(currentUser.getUserId())) {
			ra.addFlashAttribute("error", "Only leader can remove members");
			return "redirect:/participant/myTeam";
		}

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				memberId);

		if (tm != null) {
			hackathonTeamMemberRepository.delete(tm);
		}

		ra.addFlashAttribute("success", "Member removed");

		return "redirect:/participant/team";
	}

	@PostMapping("/team/requestJoin")
	public String requestJoin(@RequestParam Integer teamId, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		if (user == null)
			return "redirect:/login";

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ❌ prevent duplicate in the same hackathon
		boolean alreadyInTeam = hackathonTeamMemberRepository.existsByMember_UserIdAndTeam_Hackathon_HackathonId(
				user.getUserId(), team.getHackathon().getHackathonId());

		if (alreadyInTeam) {
			ra.addFlashAttribute("error", "You are already part of a team or have pending invites/requests for this hackathon.");
			return "redirect:/participant/team-register?hackathonId=" + team.getHackathon().getHackathonId();
		}

		// ✅ create request
		HackathonTeamMembersEntity req = new HackathonTeamMembersEntity();

		req.setTeam(team);
		req.setMember(user);
		req.setStatus("REQUESTED");
		req.setRoleTitle("MEMBER");

		hackathonTeamMemberRepository.save(req);

		// 🔔 CREATE NOTIFICATION TO TEAM LEADER
		notificationService.createNotification(team.getTeamLeader(),
				user.getFirstName() + " requested to join team " + team.getTeamName(), "REQUEST",
				"/team/details/" + teamId);

		ra.addFlashAttribute("success", "Request sent to team leader!");

		return "redirect:/participant/team-register?hackathonId=" + team.getHackathon().getHackathonId();
	}

	// by team leader
	@PostMapping("/team/acceptRequest")
	public String acceptRequest(@RequestParam Integer teamId, @RequestParam Integer memberId, HttpSession session,
			RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ✅ only leader
		if (!team.getTeamLeader().getUserId().equals(user.getUserId())) {
			ra.addFlashAttribute("error", "Not authorized");
			return "redirect:/participant/team";
		}

		// ✅ Enforce max team size before accepting
		long acceptedCount = hackathonTeamMemberRepository.findByTeam(team).stream()
				.filter(m -> "ACCEPTED".equals(m.getStatus())).count();
		Integer maxSize = team.getHackathon().getMaxTeamSize();
		if (maxSize != null && acceptedCount >= maxSize) {
			ra.addFlashAttribute("error", "Team is full. Maximum " + maxSize + " members allowed.");
			return "redirect:/team/details/" + teamId;
		}

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				memberId);

		if (tm != null && "REQUESTED".equals(tm.getStatus())) {
			tm.setStatus("ACCEPTED");
			hackathonTeamMemberRepository.save(tm);
			notificationService.createNotification(tm.getMember(),
					"Your request accepted for team " + team.getTeamName(), "REQUEST_ACCEPT", "/participant/team");
			mailerService.sendInviteAcceptedMail(team.getTeamLeader(), tm.getMember(), team);
		}

		return "redirect:/team/details/" + teamId;
	}

	// by team leader
	@PostMapping("/team/rejectRequest")
	public String rejectRequest(@RequestParam Integer teamId, @RequestParam Integer memberId, HttpSession session) {

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				memberId);

		if (tm != null && "REQUESTED".equals(tm.getStatus())) {
			hackathonTeamMemberRepository.delete(tm);
		}

		return "redirect:/team/details/" + teamId;
	}

	// Member only
	@PostMapping("/team/leave")
	public String leaveTeam(@RequestParam Integer teamId, HttpSession session, RedirectAttributes ra) {

		UserEntity user = (UserEntity) session.getAttribute("user");

		HackathonTeamEntity team = hackathonTeamRepository.findById(teamId).orElseThrow();

		// ❌ Leader cannot leave
		if (team.getTeamLeader().getUserId().equals(user.getUserId())) {
			ra.addFlashAttribute("error", "Leader cannot leave team. Delete it instead.");
			return "redirect:/participant/myTeam";
		}

		HackathonTeamMembersEntity tm = hackathonTeamMemberRepository.findByTeam_HackathonTeamIdAndMember_UserId(teamId,
				user.getUserId());

		if (tm != null) {
			hackathonTeamMemberRepository.delete(tm);
		}

		ra.addFlashAttribute("success", "You left the team");

		return "redirect:/userHome";
	}

}