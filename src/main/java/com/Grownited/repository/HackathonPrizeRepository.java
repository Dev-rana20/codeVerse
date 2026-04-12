package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.Grownited.entity.HackathonPrizeEntity;

@Repository
public interface HackathonPrizeRepository extends JpaRepository<HackathonPrizeEntity, Integer>{

	// Feature 1: Cascade delete all prizes for a hackathon
	void deleteByHackathonId(Integer hackathonId);
}
