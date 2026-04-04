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
import com.Grownited.entity.UserEntity;
import com.Grownited.enums.AssignmentStatus;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonJudgeRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.MailerService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminJudgeController {

	@Autowired
	UserRepository userRepository;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	MailerService mailerService;
	@Autowired
	private HackathonRepository hackathonRepository;

	@Autowired
	private HackathonJudgeRepository hackathonJudgeRepository;

	@Autowired
	HackathonTeamRepository teamRepository;

	@Autowired
	EvaluationRepository evaluationRepo;

	@PostMapping("/admin/invite-judge")
	public String inviteJudge(String email, Model model) {

		// 🔒 check duplicate
		if (userRepository.findByEmail(email).isPresent()) {
			model.addAttribute("error", "User already exists");
			return "AdminInviteJudge";
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

		model.addAttribute("success", "Judge invited successfully!");

		return "redirect:/admin-dashboard";
	}

	@GetMapping("/judge-dashboard")
	public String judgeDashBoard(HttpSession session, Model model) {
		UserEntity judge = (UserEntity) session.getAttribute("user");

		List<HackathonJudgeEntity> assignments = hackathonJudgeRepository.findByUserWithHackathon(judge.getUserId());

		model.addAttribute("assignments", assignments);
		return "/judge/JudgeDashBoard";
	}

	@GetMapping("/judge/assignJudge")
	public String assignJudgePage(Model model) {

		// ✅ Get all judges
		List<UserEntity> judges = userRepository.findByRole("JUDGE");

		// ✅ Get all hackathons
		List<HackathonEntity> hackathons = hackathonRepository.findAll();

		// 🎯 Send data to JSP
		model.addAttribute("judges", judges);
		model.addAttribute("hackathons", hackathons);

		return "/judge/AssignJudge"; // JSP file
	}

	@PostMapping("/admin/assign-judge")
	public String assignJudgeToHackathon(Integer judgeId, Integer hackathonId, Model model) {

		// 🔍 Fetch user (judge)
		UserEntity user = userRepository.findById(judgeId).orElse(null);

		if (user == null || !user.getRole().equals("JUDGE")) {
			model.addAttribute("error", "Invalid Judge selected");
			return "redirect:/admin-dashboard";
		}

		// 🔍 Fetch hackathon
		HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElse(null);

		if (hackathon == null) {
			model.addAttribute("error", "Invalid Hackathon selected");
			return "redirect:/admin-dashboard";
		}

		// 🚫 Prevent duplicate assignment
		boolean exists = hackathonJudgeRepository.existsByUser_UserIdAndHackathon_HackathonId(judgeId, hackathonId);

		if (exists) {
			model.addAttribute("error", "Judge already assigned to this hackathon");
			return "redirect:/admin-dashboard";
		}

		// ✅ Create assignment
		HackathonJudgeEntity hj = new HackathonJudgeEntity();
		hj.setUser(user);
		hj.setHackathon(hackathon);
		hj.setStatus(AssignmentStatus.ASSIGNED); // enum
		hj.setAssignedAt(LocalDate.now());

		hackathonJudgeRepository.save(hj);

		model.addAttribute("success", "Judge assigned successfully!");

		return "redirect:/admin-dashboard";
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
		return "/judge/AssignJudge";
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

		model.addAttribute("team", team);

		return "judge/evaluate";
	}

	@PostMapping("/judge/submit-evaluation")
	public String submitEvaluation(@RequestParam Integer teamId, @RequestParam Integer innovation,
			@RequestParam Integer technical, @RequestParam Integer uiUx, @RequestParam Integer functionality,
			@RequestParam Integer presentation, @RequestParam Integer impact, @RequestParam String remarks,
			HttpSession session) {

		
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
			return "redirect:/judge-dashboard?error=alreadyEvaluated";
		}
		
		// ✅ Create evaluation
		EvaluationEntity eval = new EvaluationEntity();

		eval.setTeam(team);
		eval.setJudge(judge);

		eval.setInnovation(innovation);
		eval.setTechnical(technical);
		eval.setUiUx(uiUx);
		eval.setFunctionality(functionality);
		eval.setPresentation(presentation);
		eval.setImpact(impact);

		int total = innovation + technical + uiUx + functionality + presentation + impact;
		eval.setTotalScore(total);

		eval.setRemarks(remarks);
		
		evaluationRepo.save(eval);

		return "redirect:/judge-dashboard?success=evaluated";
	}
}
