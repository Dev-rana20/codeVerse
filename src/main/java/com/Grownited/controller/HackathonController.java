package com.Grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.Grownited.entity.HackathonDescriptionEntity;
import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserTypeEntity;
import com.Grownited.repository.HackathonDescriptionRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.UserTypeRepository;
import com.cloudinary.Cloudinary;

import jakarta.servlet.http.HttpSession;

@Controller
public class HackathonController {

	@Autowired
	HackathonRepository hackathonRepository;

	@Autowired
	UserTypeRepository userTypeRepository;

	@Autowired
	HackathonDescriptionRepository hackathonDescriptionRepository;

	@Autowired
	Cloudinary cloudinary;
//	
//	@Autowired
//	HackathonDescriptionEntity hackathonDescriptionEntity;

	@GetMapping("newHackathon")
	public String newHackathon(Model model) {

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("allUserType", allUserType);
		return "NewHackathon";
	}

	@PostMapping("saveHackathon")
	public String saveHackathon(HackathonEntity hackathonEntity, HttpSession session) {

		UserEntity currentLogInUser = (UserEntity) session.getAttribute("user");

		hackathonEntity.setUserId(currentLogInUser.getUserId());
		hackathonRepository.save(hackathonEntity);
		return "redirect:/addHackathonDescription";
	}

	@GetMapping("listHackathon")
	public String listHackathon(Model model) {

		List<HackathonEntity> allHackathon = hackathonRepository.findAll();
		model.addAttribute("allHackathon", allHackathon);
		return "ListHackathon";
	}

	@GetMapping("deleteHackathon")
	public String deletehackathon(Integer hackathonId) {
	    hackathonDescriptionRepository.deleteById(hackathonId);
		hackathonRepository.deleteById(hackathonId);

		return "redirect:/listHackathon";
	}

//	@GetMapping("viewHackathon")
//	public String viewHackathon(Integer hackathonId, Integer hackathonDescriptionId, Model model) {
//
//		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
//
//		if (opHackathon.isEmpty()) {
//			return "redirect:/listHackathon";
//		}
//
//		HackathonEntity hackathonEntity = opHackathon.get();
//		model.addAttribute("hackathon", hackathonEntity);
//
//		if (hackathonDescriptionId != null) {
//			Optional<HackathonDescriptionEntity> opDetails = hackathonDescriptionRepository
//					.findById(hackathonDescriptionId);
//
//			if (opDetails.isPresent()) {
//				HackathonDescriptionEntity hackathonDescriptionEntity = opDetails.get();
//				model.addAttribute("hackathonDescriptionEntity", hackathonDescriptionEntity);
//				System.out.println(hackathonDescriptionEntity.getHackathonDetailsURL());
//			}
//
//		}
//
//		return "ViewHackathon";
//	}

	@GetMapping("viewHackathon")
	public String viewHackathon(Integer hackathonId, Model model) {

		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);

		if (opHackathon.isEmpty()) {
			return "redirect:/listHackathon";
		}

		HackathonEntity hackathonEntity = opHackathon.get();
		model.addAttribute("hackathon", hackathonEntity);

		HackathonDescriptionEntity descList = 
		        hackathonDescriptionRepository.findByHackathon_HackathonId(hackathonId);

		model.addAttribute("descList", descList);


		model.addAttribute("hackathonDescriptionEntity", descList);

		return "ViewHackathon";
	}

	@GetMapping("addHackathonDescription")
	public String addHackathonDescription(Model model) {

		List<HackathonEntity> hackathons = hackathonRepository.findAll();

		model.addAttribute("hackathons", hackathons);

		return "AddHackathonDescription";
	}



	@PostMapping("saveHackathonDescription")
	public String saveHackathonDescription(
	        @RequestParam("hackathonId") Integer hackathonId,
	        @RequestParam("hackathonDetails") MultipartFile hackathonDetails,
	        @RequestParam("hackathonDetailsText") String hackathonDetailsText) {

	    HackathonDescriptionEntity description = new HackathonDescriptionEntity();

	    // 1️⃣ Set the text
	    description.setHackathonDetailsText(hackathonDetailsText);

	    // 2️⃣ Upload file to Cloudinary
	    try {
	        Map<?, ?> map = cloudinary.uploader().upload(hackathonDetails.getBytes(), null);
	        String uploadedURL = map.get("secure_url").toString();
	        description.setHackathonDetailsURL(uploadedURL);
	        System.out.println("Uploaded URL: " + uploadedURL);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    // 3️⃣ Fetch the Hackathon entity and set it
	    HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElse(null);
	    if (hackathon == null) {
	        throw new RuntimeException("Hackathon ID not found: " + hackathonId);
	    }
	    description.setHackathon(hackathon);

	    // 4️⃣ Save the description
	    hackathonDescriptionRepository.save(description);

	    return "redirect:/listHackathon";
	}
	

	}


