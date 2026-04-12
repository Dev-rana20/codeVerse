package com.Grownited.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.service.HackathonService;

@Controller
public class PublicController {

    @Autowired
    HackathonRepository hackathonRepository;

    @Autowired
    HackathonRegistrationRepository registrationRepository;

    @Autowired
    HackathonService hackathonService;

    @GetMapping("/")
    public String index(Model model) {
        hackathonService.updateHackathonStatuses();

        // Fetch only Open and Upcoming hackathons for public discovery and limit to 3
        List<String> activeStatuses = Arrays.asList("UPCOMING", "ONGOING", "OPEN", "IN_PROGRESS");
        List<HackathonEntity> hackathons = hackathonRepository.findByStatusIn(activeStatuses)
            .stream()
            .limit(3)
            .collect(java.util.stream.Collectors.toList());
        model.addAttribute("hackathons", hackathons);

        // Feature 5: Participant counts for landing page hackathon cards
        List<Object[]> rawCounts = registrationRepository.countByHackathonGrouped();
        Map<Integer, Long> participantCounts = new HashMap<>();
        for (Object[] row : rawCounts) {
            participantCounts.put((Integer) row[0], (Long) row[1]);
        }
        model.addAttribute("participantCounts", participantCounts);

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
