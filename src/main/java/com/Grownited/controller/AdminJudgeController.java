package com.Grownited.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Grownited.entity.EvaluationEntity;
import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonJudgeEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.enums.AssignmentStatus;
import com.Grownited.enums.SubmissionType;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonJudgeRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.SubmissionRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.MailerService;
import com.Grownited.service.NotificationService;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminJudgeController {

	@Autowired
	UserRepository userRepository;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	MailerService mailerService;
	
	@Autowired
	NotificationService notificationService;
	
	@Autowired
	private HackathonRepository hackathonRepository;

	@Autowired
	private HackathonJudgeRepository hackathonJudgeRepository;

	@Autowired
	HackathonTeamRepository teamRepository;

	@Autowired
	EvaluationRepository evaluationRepo;

	@Autowired
	SubmissionRepository submissionRepository;

	@GetMapping("/admin/invite-judge")
	public String inviteJudge() {
		return "InviteJudge";
	}

	@GetMapping("/judge/dashboard")
	public String judgeDashBoard(HttpSession session, Model model) {
		UserEntity judge = (UserEntity) session.getAttribute("user");

		List<HackathonJudgeEntity> assignments = hackathonJudgeRepository.findByUserWithHackathon(judge.getUserId());

		model.addAttribute("assignments", assignments);
		return "/judge/JudgeDashBoard";
	}

	@PostMapping("/admin/invite-judge")
	public String inviteJudge(String email, RedirectAttributes ra) {

		// 🔒 check duplicate
		if (userRepository.findByEmail(email).isPresent()) {
			ra.addFlashAttribute("error", "User already exists");
			return "redirect:/admin/invite-judge";
		}

		// 🎲 generate random password
		String rawPassword = java.util.UUID.randomUUID().toString().substring(0, 8);

		UserEntity user = new UserEntity();
		user.setEmail(email);
		user.setPassword(passwordEncoder.encode(rawPassword));
		user.setRole("JUDGE");
		user.setActive(true);
		user.setFirstLogin(true);
		user.setCreatedAt(LocalDate.now());

		userRepository.save(user);

		// 📩 send mail
		mailerService.sendJudgeInviteMail(email, rawPassword);

		ra.addFlashAttribute("success", "Judge invited successfully!");

		return "redirect:/admin/judge-management";
	}

	@PostMapping("/admin/assign-judge")
	public String assignJudgeToHackathon(Integer judgeId, Integer hackathonId, RedirectAttributes ra) {

		// 🔍 Fetch user (judge)
		UserEntity user = userRepository.findById(judgeId).orElse(null);

		if (user == null || !user.getRole().equals("JUDGE")) {
			ra.addFlashAttribute("error", "Invalid Judge selected");
			return "redirect:/admin/judge-management";
		}

		// 🔍 Fetch hackathon
		HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElse(null);

		if (hackathon == null) {
			ra.addFlashAttribute("error", "Invalid Hackathon selected");
			return "redirect:/admin/judge-management";
		}

		// 🚫 Prevent duplicate assignment
		boolean exists = hackathonJudgeRepository.existsByUser_UserIdAndHackathon_HackathonId(judgeId, hackathonId);

		if (exists) {
			ra.addFlashAttribute("error", "Judge already assigned to this hackathon");
			return "redirect:/admin/judge-management";
		}

		// ✅ Create assignment
		HackathonJudgeEntity hj = new HackathonJudgeEntity();
		hj.setUser(user);
		hj.setHackathon(hackathon);
		hj.setStatus(AssignmentStatus.ASSIGNED); // enum
		hj.setAssignedAt(LocalDate.now());

		hackathonJudgeRepository.save(hj);

		ra.addFlashAttribute("success", "Judge assigned successfully!");

		return "redirect:/admin/judge-management";
	}

	@GetMapping("/admin/judge-management")
	public String judgeManagement(Model model) {

		// Get all judges
		List<UserEntity> judges = userRepository.findByRole("JUDGE");

		// Get all hackathons
		List<HackathonEntity> hackathons = hackathonRepository.findAll();

		// Get all assignments
		List<HackathonJudgeEntity> assignments = hackathonJudgeRepository.findAllWithDetails();

		model.addAttribute("judges", judges);
		model.addAttribute("hackathons", hackathons);
		model.addAttribute("assignments", assignments);
		return "/AssignJudge";
	}

	@GetMapping("/judge/view-teams")
	public String viewTeams(Integer hackathonId, Model model) {

		List<HackathonTeamEntity> teams = teamRepository.findByHackathon_HackathonId(hackathonId);

		model.addAttribute("teams", teams);

		return "/judge/ViewTeams";
	}

	@GetMapping("/judge/evaluate")
	public String evaluatePage(@RequestParam Integer teamId, Model model) {

		HackathonTeamEntity team = teamRepository.findById(teamId).get();

		// Load final submission
		var finalSubs = submissionRepository.findByTeamAndType(team, SubmissionType.FINAL);

		// Load all active member submissions
		var memberSubs = submissionRepository.findByTeamAndTypeAndStatus(team, SubmissionType.MEMBER, "ACTIVE");

		model.addAttribute("team", team);
		model.addAttribute("finalSubs", finalSubs);
		model.addAttribute("memberSubs", memberSubs);

		return "judge/evaluate";
	}


	@PostMapping("/judge/submit-evaluation")
	public String submitEvaluation(@Valid EvaluationEntity eval, BindingResult result, @RequestParam Integer teamId, HttpSession session, Model model) {

		if (result.hasErrors()) {
			HackathonTeamEntity team = teamRepository.findById(teamId).orElse(null);
			var finalSubs = submissionRepository.findByTeamAndType(team, SubmissionType.FINAL);
			var memberSubs = submissionRepository.findByTeamAndTypeAndStatus(team, SubmissionType.MEMBER, "ACTIVE");
			model.addAttribute("team", team);
			model.addAttribute("finalSubs", finalSubs);
			model.addAttribute("memberSubs", memberSubs);
			model.addAttribute("error", "Please ensure all scores are between 0 and 100.");
			return "judge/evaluate";
		}
		
		HackathonTeamEntity team = teamRepository.findById(teamId).orElse(null);

		if (team == null) {
			throw new RuntimeException("Team not found");
		}
		UserEntity judge = (UserEntity) session.getAttribute("user");
		if (judge == null) {
		    return "redirect:/login";
		}

		// 🔒 Prevent duplicate evaluation
		EvaluationEntity existing = evaluationRepo.findByTeamAndJudge(team, judge);
		if (existing != null) {
			return "redirect:/judge/dashboard?error=alreadyEvaluated";
		}
		
		eval.setTeam(team);
		eval.setJudge(judge);

		int total = eval.getInnovation() + eval.getTechnical() + eval.getUiUx() + eval.getFunctionality() + eval.getPresentation() + eval.getImpact();
		eval.setTotalScore(total);

		evaluationRepo.save(eval);

		// 🔔 Notify all ACCEPTED team members
		if (team.getMembers() != null) {
			for (HackathonTeamMembersEntity tm : team.getMembers()) {
				if ("ACCEPTED".equals(tm.getStatus())) {
					notificationService.createNotification(
							tm.getMember(),
							"Your team's submission for " + team.getHackathon().getTitle() + " has been evaluated.",
							"EVALUATION",
							"/participant/team"
					);
				}
			}
		}

		return "redirect:/judge/dashboard?success=evaluated";
	}
}
