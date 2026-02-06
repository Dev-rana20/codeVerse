package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.repository.HackathonRepository;

@Controller
public class HackathonController {
	
	@Autowired
	HackathonRepository hackathonRepository;
	
	
	@GetMapping("newHackathon")
	public String newHackathon() {
		return "NewHackathon";
	}
	
	
	@PostMapping("saveHackathon")
	public String saveHackathon(HackathonEntity hackathonEntity){
		
		hackathonRepository.save(hackathonEntity);
		return "AdminDashboard";
	}
}
