package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonTeamEntity;
import com.Grownited.entity.TeamCommunicationEntity;

@Repository
public interface TeamCommunicationRepository extends JpaRepository<TeamCommunicationEntity, Integer> {
    List<TeamCommunicationEntity> findByTeamOrderByCreatedAtAsc(HackathonTeamEntity team);
}
