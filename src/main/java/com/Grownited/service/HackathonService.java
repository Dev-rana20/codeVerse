package com.Grownited.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.repository.EvaluationRepository;
import com.Grownited.repository.HackathonRepository;
import com.Grownited.repository.HackathonTeamMemberRepository;
import com.Grownited.repository.HackathonTeamRepository;

@Service
public class HackathonService {

    @Autowired
    private HackathonRepository hackathonRepository;

    @Autowired
    private EvaluationRepository evaluationRepository;

    @Autowired
    private HackathonTeamRepository hackathonTeamRepository;

    @Autowired
    private NotificationService notificationService;

    @Transactional
    public void updateHackathonStatuses() {
        LocalDate today = LocalDate.now();

        // 1. Close registrations
        hackathonRepository.updateStatusToClose(today);

        // 2. Start events
        hackathonRepository.updateStatusToInProgress(today);

        // 3. Complete events
        // Fetch only those that actually need to be finished
        List<HackathonEntity> potentialFinished = hackathonRepository.findFinishedHackathons(today);
        
        for (HackathonEntity h : potentialFinished) {
            h.setStatus("COMPLETED");
            hackathonRepository.save(h);
            
            // Trigger Ranking - rankTeams has its own idempotency check
            rankTeams(h);
        }
    }

    @Transactional
    public void rankTeams(HackathonEntity hackathon) {
        // Prevent duplicate ranking and notifications
        // If any team in this hackathon already has a placement, we assume ranking was already done
        List<HackathonTeamEntity> allTeams = hackathonTeamRepository.findByHackathon_HackathonId(hackathon.getHackathonId());
        boolean alreadyRanked = allTeams.stream().anyMatch(t -> t.getPlacement() != null);
        
        if (alreadyRanked) {
            return; 
        }

        List<HackathonTeamEntity> rankedTeams = evaluationRepository.getRankedTeamsByHackathon(hackathon.getHackathonId());
        
        if (rankedTeams == null || rankedTeams.isEmpty()) {
            return;
        }

        for (int i = 0; i < rankedTeams.size() && i < 3; i++) {
            HackathonTeamEntity team = rankedTeams.get(i);
            team.setPlacement(i + 1);
            hackathonTeamRepository.save(team);
            
            // Notify members
            if (team.getMembers() != null) {
                // Use distinct() to ensure each user gets only one notification 
                // even if they appear multiple times in the members list
                team.getMembers().stream()
                    .filter(member -> "ACCEPTED".equalsIgnoreCase(member.getStatus()))
                    .map(member -> member.getMember())
                    .filter(user -> user != null)
                    .distinct() // CRITICAL: Fixes duplicate notifications per user
                    .forEach(user -> {
                        notificationService.createNotification(
                            user,
                            "Congratulations! Your team won " + team.getPlacement() + " place in " + hackathon.getTitle() + "!",
                            "WINNER",
                            "/participant/team"
                        );
                    });
            }
        }
    }
}
