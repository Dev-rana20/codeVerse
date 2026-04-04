package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.TeamJoinRequestEntity;

public interface TeamJoinRequestRepository extends JpaRepository<TeamJoinRequestEntity, Integer> {

List<TeamJoinRequestEntity> findByTeamId(Integer teamId);

boolean existsByTeamIdAndUserIdAndStatus(Integer teamId, Integer userId, String status);
}

