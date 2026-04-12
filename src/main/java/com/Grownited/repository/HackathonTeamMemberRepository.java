package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.HackathonTeamMembersEntity;
import com.Grownited.entity.UserEntity;

@Repository
public interface HackathonTeamMemberRepository
        extends JpaRepository<HackathonTeamMembersEntity, Integer> {

    // ✔ by team object
    List<HackathonTeamMembersEntity> findByTeam(HackathonTeamEntity team);

    // ✔ by member object
    List<HackathonTeamMembersEntity> findByMember(UserEntity member);

    // ✔ check duplicate request
    boolean existsByTeamAndMember(HackathonTeamEntity team, UserEntity member);

	HackathonTeamMembersEntity findByTeam_HackathonTeamIdAndMember_UserId(Integer teamId, Integer userId);
	
	HackathonTeamMembersEntity findByMember_UserIdAndTeam_Hackathon_HackathonId(Integer userId, Integer hackathonId);
	
	 boolean existsByMember_UserIdAndTeam_Hackathon_HackathonId(
	            Integer userId,
	            Integer hackathonId);

	 // Feature 1: Cascade delete all team members for a hackathon
	 void deleteByTeam_Hackathon_HackathonId(Integer hackathonId);
}