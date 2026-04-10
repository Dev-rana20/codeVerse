package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonJudgeEntity;

@Repository
public interface HackathonJudgeRepository extends JpaRepository<HackathonJudgeEntity, Integer> {
	boolean existsByUser_UserIdAndHackathon_HackathonId(Integer userId, Integer hackathonId);
	@Query("SELECT hj FROM HackathonJudgeEntity hj JOIN FETCH hj.hackathon JOIN FETCH hj.user")
	List<HackathonJudgeEntity> findAllWithDetails();
	@Query("SELECT hj FROM HackathonJudgeEntity hj JOIN FETCH hj.hackathon WHERE hj.user.userId = :userId")
	List<HackathonJudgeEntity> findByUserWithHackathon(Integer userId);

	long countByStatus(com.Grownited.enums.AssignmentStatus status);
}
