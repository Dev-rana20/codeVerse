package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.Grownited.entity.TeamJoinRequestEntity;

public interface TeamJoinRequestRepository extends JpaRepository<TeamJoinRequestEntity, Integer> {

List<TeamJoinRequestEntity> findByTeamId(Integer teamId);

boolean existsByTeamIdAndUserIdAndStatus(Integer teamId, Integer userId, String status);

// Feature 1: Cascade delete all join requests for teams belonging to a hackathon
@Modifying
@Query("DELETE FROM TeamJoinRequestEntity t WHERE t.teamId IN (SELECT ht.hackathonTeamId FROM HackathonTeamEntity ht WHERE ht.hackathon.hackathonId = :hackathonId)")
void deleteByHackathonId(@Param("hackathonId") Integer hackathonId);
}
