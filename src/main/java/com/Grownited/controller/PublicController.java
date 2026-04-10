package com.Grownited.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.repository.HackathonRepository;

@Controller
public class PublicController {

    @Autowired
    HackathonRepository hackathonRepository;

    @GetMapping("/")
    public String index(Model model) {
        // Fetch only Open and Upcoming hackathons for public discovery
        List<String> activeStatuses = Arrays.asList("UPCOMING", "ONGOING", "OPEN", "IN_PROGRESS");
        List<HackathonEntity> hackathons = hackathonRepository.findByStatusIn(activeStatuses);
        model.addAttribute("hackathons", hackathons);
        return "LandingPage";
    }

    @GetMapping("/faq")
    public String faq() {
        return "FAQ";
    }

    @GetMapping("/contact")
    public String contact() {
        return "ContactUs";
    }
}
