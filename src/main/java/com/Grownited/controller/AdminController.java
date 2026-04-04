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

@Controller
public class AdminController {
	
	@Autowired
	UserRepository userRepository;
	@Autowired
	HackathonRepository hackathonRepository;
	
	@GetMapping(value = {"admin-dashboard","/"})
	public String adminDashboard(Model model) {
		
		List<UserEntity> user= userRepository.findAll();
		List<HackathonEntity> allHackathon= hackathonRepository.findAll();
		model.addAttribute("user",user);
		model.addAttribute("allHackathon",allHackathon);
		return "AdminDashboard";
	}
}
