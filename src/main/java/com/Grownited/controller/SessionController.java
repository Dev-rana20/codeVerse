package com.Grownited.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


import com.Grownited.entity.UserDetailEntity;
import com.Grownited.entity.UserEntity;


import com.Grownited.repository.UserRepository;



@Controller
public class SessionController {
	
	
	@Autowired
	UserRepository userRepository;

	@GetMapping("/signup")
	public String openSignupPage() {
		return "Signup";
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@GetMapping("/forgetPassword")
	public String forgetPassword() {
		return "ForgetPassword";
	}
	
	@PostMapping("/register")
	public String register(UserEntity userEntity,UserDetailEntity userDetailEntity) {
		
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());
		System.out.println(userEntity.getEmail());
		
		
		System.out.println(userDetailEntity.getCity());
		System.out.println(userDetailEntity.getState());
		
		userEntity.setCreateAt(LocalDate.now());
		
		userEntity.setActive(true);
		userEntity.setRole("PARTICIPANT");
		
		
		
		userRepository.save(userEntity);
		
		return "Login";
	}
	
	
}


	