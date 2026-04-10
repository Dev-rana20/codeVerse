package com.Grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.service.AnalyticsService;

@Controller
public class AdminController {
	
	@Autowired
	UserRepository userRepository;
	@Autowired
	HackathonRepository hackathonRepository;
	@Autowired
	AnalyticsService analyticsService;
	
	@GetMapping(value = {"admin-dashboard"})
	public String adminDashboard(Model model) {
		
		List<UserEntity> user= userRepository.findAll();
		java.time.LocalDate today = java.time.LocalDate.now();
		
		// Bulk update statuses efficiently
		hackathonRepository.updateStatusToClose(today);
		hackathonRepository.updateStatusToInProgress(today);
		
		List<HackathonEntity> allHackathon= hackathonRepository.findAll();
		model.addAttribute("user",user);
		model.addAttribute("allHackathon",allHackathon);

		// Add Analytics Data
		java.util.Map<String, Object> analytics = analyticsService.getPlatformAnalytics();
		model.addAttribute("analytics", analytics);
		
		// Convert to JSON for JS usage
		try {
			com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
			// Register JavaTimeModule if needed, but for simple maps it might be fine. 
			// Actually, LocalDate might need JavaTimeModule.
			mapper.registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule());
			model.addAttribute("analyticsJson", mapper.writeValueAsString(analytics));
		} catch (Exception e) {
			model.addAttribute("analyticsJson", "{}");
		}

		return "AdminDashboard";
	}
}
