package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonDescriptionEntity;

@Repository
public interface HackathonDescriptionRepository extends JpaRepository<HackathonDescriptionEntity, Integer>{
	
}
