package com.Grownited.controller;

import java.util.List;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


import com.Grownited.entity.UserDetailEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.UserDetailRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserTypeRepository;





@Controller
public class SessionController {
	
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	UserTypeRepository userTypeRepository;
	
	@Autowired
	UserDetailRepository userDetailRepository;
	
	@GetMapping("/signup")
	public String openSignupPage(Model model) {
		
		List<UserTypeEntity> allUserType = userTypeRepository.findAll(); 
		
		model.addAttribute("allUserType",allUserType);
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
		
		userEntity.setCreatedAt(LocalDate.now());
		
		userEntity.setActive(true);
		userEntity.setRole("PARTICIPANT");
		
		
		
		userRepository.save(userEntity); //users insert  -> userId 
		userDetailEntity.setUserId(userEntity.getUserId());
		userDetailRepository.save(userDetailEntity);
		
		return "Login";
	}
	
	
}


	