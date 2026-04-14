package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.SubmissionEntity;
import com.Grownited.enums.SubmissionType;

@Repository
public interface SubmissionRepository extends JpaRepository<SubmissionEntity, Integer>{

    List<SubmissionEntity> findByTeamAndType(
            HackathonTeamEntity team,
            SubmissionType type);

    List<SubmissionEntity> findByTeam(HackathonTeamEntity team);

    // ✅ Only active submissions
    List<SubmissionEntity> findByTeamAndTypeAndStatus(
            HackathonTeamEntity team,
            SubmissionType type,
            String status);

    boolean existsByTeamAndTypeAndStatus(
            HackathonTeamEntity team,
            SubmissionType type,
            String status);

    // Feature 1: Cascade delete all submissions for a hackathon
    void deleteByTeam_Hackathon_HackathonId(Integer hackathonId);

}