package com.Grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.UserTypeRepository;

@Controller
public class UserTypeController {

	@Autowired
	UserTypeRepository userTypeRepository;

	@GetMapping("newUserType")
	public String newUserType() {
		return "NewUserType";
	}

	@PostMapping("saveUserType")
	public String saveUserType(UserTypeEntity userTypeEntity) {

		userTypeRepository.save(userTypeEntity);
		return "redirect:/listUserType";
	}

	@GetMapping("listUserType")
	public String listUserType(Model model) {
		
	List<UserTypeEntity>userTypeList= userTypeRepository.findAll();
	model.addAttribute("userTypeList",userTypeList);
		return "ListUserType";
	}

	@GetMapping("deleteUserType")
	public String deleteUserType(Integer id) {
		userTypeRepository.deleteById(id);
		return "redirect:/listUserType";
	}
}
