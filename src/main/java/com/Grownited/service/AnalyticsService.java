package com.Grownited.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Grownited.repository.UserRepository;
import com.Grownited.repository.HackathonTeamRepository;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.SubmissionRepository;
import com.Grownited.repository.HackathonJudgeRepository;
import com.Grownited.enums.AssignmentStatus;

@Service
public class AnalyticsService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    HackathonTeamRepository teamRepository;

    @Autowired
    HackathonRegistrationRepository registrationRepository;

    @Autowired
    SubmissionRepository submissionRepository;

    @Autowired
    HackathonJudgeRepository judgeRepository;

    public Map<String, Object> getPlatformAnalytics() {
        Map<String, Object> analytics = new HashMap<>();

        // 1. Registrations over time (last 30 days)
        // Use TreeMap to keep dates sorted
        Map<String, Long> registrationTrend = new TreeMap<>();
        LocalDate today = LocalDate.now();
        for (int i = 29; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            long count = userRepository.countByCreatedAt(date);
            registrationTrend.put(date.toString(), count);
        }
        analytics.put("registrationTrend", registrationTrend);

        // 2. Team Formation Rates
        long totalTeams = teamRepository.count();
        long totalRegistrations = registrationRepository.count();
        double teamFormationRate = totalRegistrations == 0 ? 0 : (double) totalTeams / totalRegistrations * 100;
        analytics.put("totalTeams", totalTeams);
        analytics.put("totalParticipants", totalRegistrations);
        analytics.put("teamFormationRate", Math.round(teamFormationRate * 100.0) / 100.0);

        // 3. Submission Counts
        long totalSubmissions = submissionRepository.count();
        analytics.put("totalSubmissions", totalSubmissions);

        // 4. Judge Completion Rates
        long totalAssignments = judgeRepository.count();
        long completedAssignments = judgeRepository.countByStatus(AssignmentStatus.COMPLETED);
        double judgeCompletionRate = totalAssignments == 0 ? 0 : (double) completedAssignments / totalAssignments * 100;
        analytics.put("judgeCompletionRate", Math.round(judgeCompletionRate * 100.0) / 100.0);
        analytics.put("completedEvaluations", completedAssignments);
        analytics.put("pendingEvaluations", totalAssignments - completedAssignments);

        // 5. Revenue
        Long totalRevenue = registrationRepository.getTotalRevenue();
        analytics.put("totalRevenue", totalRevenue != null ? totalRevenue : 0);

        return analytics;
    }
}
