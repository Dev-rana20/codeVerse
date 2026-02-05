package com.Grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CatagoryController {

	
	
	@GetMapping("newCatagory")
	public String newCatagory() {
		return "NewCatagory";
	}
}
