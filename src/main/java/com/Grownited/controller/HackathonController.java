package com.Grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;

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

	@GetMapping("newHackathon")
	public String newHackathon(Model model) {

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("allUserType", allUserType);
		return "NewHackathon";
	}



	@PostMapping("saveHackathon")
	public String saveHackathon(@Valid HackathonEntity hackathonEntity, BindingResult result, HttpSession session, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("error", "Please correct the highlighted errors.");
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "NewHackathon";
		}

		// Server-side date consistency checks
		if (hackathonEntity.getRegistrationStartDate() != null && hackathonEntity.getRegistrationEndDate() != null) {
			if (hackathonEntity.getRegistrationEndDate().isBefore(hackathonEntity.getRegistrationStartDate())) {
				model.addAttribute("error", "Registration end date cannot be before start date.");
				model.addAttribute("allUserType", userTypeRepository.findAll());
				return "NewHackathon";
			}
		}

		UserEntity currentLogInUser = (UserEntity) session.getAttribute("user");

		hackathonEntity.setUserId(currentLogInUser.getUserId());
		hackathonRepository.save(hackathonEntity);
		return "redirect:/addHackathonDescription";
	}
	@GetMapping("listHackathon")
	public String listHackathon(Model model) {
		java.time.LocalDate today = java.time.LocalDate.now();
		
		// Perform bulk updates in single DB calls instead of looping
		hackathonRepository.updateStatusToClose(today);
		hackathonRepository.updateStatusToInProgress(today);
		
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
	    if (hackathonDetails != null && !hackathonDetails.isEmpty()) {
		    try {
		        Map<?, ?> map = cloudinary.uploader().upload(hackathonDetails.getBytes(), null);
		        String uploadedURL = map.get("secure_url").toString();
		        description.setHackathonDetailsURL(uploadedURL);
		        System.out.println("Uploaded URL: " + uploadedURL);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
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

	// ── Edit Hackathon ──────────────────────────────────────────────

	@GetMapping("editHackathon")
	public String editHackathon(@org.springframework.web.bind.annotation.RequestParam Integer hackathonId, Model model) {

		HackathonEntity hackathon = hackathonRepository.findById(hackathonId)
				.orElseThrow(() -> new RuntimeException("Hackathon not found: " + hackathonId));

		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("hackathon", hackathon);
		model.addAttribute("allUserType", allUserType);
		return "EditHackathon";
	}

	@PostMapping("updateHackathon")
	public String updateHackathon(@Valid HackathonEntity hackathonEntity, BindingResult result, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("error", "Please correct the highlighted errors.");
			model.addAttribute("hackathon", hackathonEntity);
			model.addAttribute("allUserType", userTypeRepository.findAll());
			return "EditHackathon";
		}

		// Server-side date consistency checks
		if (hackathonEntity.getRegistrationStartDate() != null && hackathonEntity.getRegistrationEndDate() != null) {
			if (hackathonEntity.getRegistrationEndDate().isBefore(hackathonEntity.getRegistrationStartDate())) {
				model.addAttribute("error", "Registration end date cannot be before start date.");
				model.addAttribute("hackathon", hackathonEntity);
				model.addAttribute("allUserType", userTypeRepository.findAll());
				return "EditHackathon";
			}
		}

		// Ensure we are updating the existing one (the ID should be in the entity from the hidden form field)
		hackathonRepository.save(hackathonEntity);
		return "redirect:/listHackathon";
	}

}
