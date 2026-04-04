package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.Grownited.dto.LeaderboardDTO;
import com.Grownited.entity.EvaluationEntity;
import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.UserEntity;

public interface EvaluationRepository extends JpaRepository<EvaluationEntity, Integer> {

	// prevent duplicate evaluation
	EvaluationEntity findByTeamAndJudge(HackathonTeamEntity team, UserEntity judge);

	@Query("""
			SELECT new com.Grownited.dto.LeaderboardDTO(
			    e.team.teamName,
			    e.innovation,
			    e.technical,
			    e.uiUx,
			    e.functionality,
			    e.presentation,
			    e.impact,
			    e.totalScore,
			    e.remarks
			)
			FROM EvaluationEntity e
			WHERE e.team.hackathon.hackathonId = :hackathonId
			ORDER BY e.totalScore DESC
			""")
	List<LeaderboardDTO> getLeaderboard(Integer hackathonId);

}
