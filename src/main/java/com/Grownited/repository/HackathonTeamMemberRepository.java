package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamMembersEntity;

@Repository
public interface HackathonTeamMemberRepository extends JpaRepository<HackathonTeamMembersEntity, Integer> {

}
