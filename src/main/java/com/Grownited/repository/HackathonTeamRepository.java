package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamEntity;

@Repository
public interface HackathonTeamRepository extends JpaRepository<HackathonTeamEntity, Integer>{

	List<HackathonTeamEntity> findByHackathon_HackathonId(Integer hackathonId);

	boolean existsByHackathon_HackathonIdAndTeamLeader_UserId(Integer id, Integer userId);	
}
