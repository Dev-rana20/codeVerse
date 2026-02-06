package com.Grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HackathonDescriptionController {

	
	@GetMapping("hackathonDescription")
	public String hackathonDescription() {
		return "HackathonDescription";
	}
}
