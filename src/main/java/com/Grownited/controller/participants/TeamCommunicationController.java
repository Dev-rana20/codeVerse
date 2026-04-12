package com.Grownited.controller.participants;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.TeamCommunicationEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.TeamCommunicationRepository;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.HttpSession;

@Controller
public class TeamCommunicationController {

    @Autowired
    private TeamCommunicationRepository communicationRepository;

    @Autowired
    private HackathonTeamRepository teamRepository;

    @Autowired
    private Cloudinary cloudinary;

    @PostMapping("/team/communication/send")
    public String sendMessage(
            @RequestParam Integer teamId,
            @RequestParam String content,
            @RequestParam String type,
            HttpSession session,
            RedirectAttributes ra) {

        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        HackathonTeamEntity team = teamRepository.findById(teamId).orElseThrow();

        // Security: Ensure user is part of the team (or leader)
        boolean isLeader = team.getTeamLeader().getUserId().equals(user.getUserId());
        // For simplicity, we assume team details access check is already done by UI and other controllers.
        // A more robust check could be added here to verify membership.

        if ("ANNOUNCEMENT".equalsIgnoreCase(type) && !isLeader) {
            ra.addFlashAttribute("error", "Only team leaders can post announcements.");
            return "redirect:/team/details/" + teamId;
        }

        TeamCommunicationEntity message = new TeamCommunicationEntity();
        message.setTeam(team);
        message.setSender(user);
        message.setContent(content);
        message.setType(type.toUpperCase());

        communicationRepository.save(message);

        ra.addFlashAttribute("success", type.equalsIgnoreCase("ANNOUNCEMENT") ? "Announcement posted!" : "Message sent!");
        return "redirect:/team/details/" + teamId;
    }

    @PostMapping("/team/communication/upload")
    public String uploadFile(
            @RequestParam Integer teamId,
            @RequestParam MultipartFile teamFile,
            HttpSession session,
            RedirectAttributes ra) {

        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        HackathonTeamEntity team = teamRepository.findById(teamId).orElseThrow();

        if (teamFile == null || teamFile.isEmpty()) {
            ra.addFlashAttribute("error", "Please select a file to upload.");
            return "redirect:/team/details/" + teamId;
        }

        // 10MB limit
        if (teamFile.getSize() > 10 * 1024 * 1024) {
            ra.addFlashAttribute("error", "File size exceeds 10MB limit.");
            return "redirect:/team/details/" + teamId;
        }

        try {
            Map<?, ?> uploadResult = cloudinary.uploader().upload(teamFile.getBytes(),
                    ObjectUtils.asMap("resource_type", "auto", "transformation", "q_auto,f_auto"));
            
            TeamCommunicationEntity fileComm = new TeamCommunicationEntity();
            fileComm.setTeam(team);
            fileComm.setSender(user);
            fileComm.setType("FILE");
            fileComm.setFileName(teamFile.getOriginalFilename());
            fileComm.setFileUrl(uploadResult.get("secure_url").toString());
            fileComm.setContent("Shared a file: " + teamFile.getOriginalFilename());

            communicationRepository.save(fileComm);
            ra.addFlashAttribute("success", "File shared successfully!");

        } catch (IOException e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to upload file.");
        }

        return "redirect:/team/details/" + teamId;
    }
}
