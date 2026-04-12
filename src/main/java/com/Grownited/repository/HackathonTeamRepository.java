package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamEntity;

@Repository
public interface HackathonTeamRepository extends JpaRepository<HackathonTeamEntity, Integer>{

	List<HackathonTeamEntity> findByHackathon_HackathonId(Integer hackathonId);

	HackathonTeamEntity findByHackathon_HackathonIdAndTeamLeader_UserId(Integer hackathonId, Integer userId);

	boolean existsByHackathon_HackathonIdAndTeamLeader_UserId(Integer id, Integer userId);

	// Feature 1: Cascade delete all teams for a hackathon
	void deleteByHackathon_HackathonId(Integer hackathonId);
}
