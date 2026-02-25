package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonJudgeEntity;

@Repository
public interface HackathonJudgeRepository extends JpaRepository<HackathonJudgeEntity, Integer> {

}
