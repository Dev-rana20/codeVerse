package com.Grownited.controller;



import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.UserTypeRepository;



@Controller
public class HackathonController {
	
	@Autowired
	HackathonRepository hackathonRepository;
	
	@Autowired
	UserTypeRepository userTypeRepository;
	
	@GetMapping("newHackathon")
	public String newHackathon(Model model) {
		
	List<UserTypeEntity> allUserType= userTypeRepository.findAll();
	
	model.addAttribute("allUserType", allUserType);
		return "NewHackathon";
	}
	
	
	@PostMapping("saveHackathon")
	public String saveHackathon(HackathonEntity hackathonEntity){
		
		hackathonRepository.save(hackathonEntity);
		return "redirect:/listHackathon";
	}
	
	@GetMapping("listHackathon")
	public String listHackathon(Model model) {
		
	List<HackathonEntity> allHackathon=	hackathonRepository.findAll();
	model.addAttribute("allHackathon",allHackathon);
		return "ListHackathon"; 
	}
	
	@GetMapping("deleteHackathon")
	public String deletehackathon(Integer hackathonId) {
		hackathonRepository.deleteById(hackathonId);
		return "redirect:/listHackathon";
	}
	
	@GetMapping("viewHackathon")
	public String viewHackathon( Integer hackathonId, Model model) {
		
		Optional<HackathonEntity> opHackathon= hackathonRepository.findById(hackathonId);
		
		if(opHackathon.isEmpty()) {
			return "";
		}
		else {
			HackathonEntity hackathonEntity =opHackathon.get();
			model.addAttribute("hackathon",hackathonEntity);
		}
		return "ViewHackathon";
	}
}
