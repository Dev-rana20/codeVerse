package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonRegistrationEntity;

@Repository
public interface HackathonRegistrationRepository extends JpaRepository<HackathonRegistrationEntity, Integer>{

	
	
	  boolean existsByUserUserIdAndHackathonHackathonId(Integer userId, Integer hackathonId);
	  
	  // Get all registrations for a user
	    List<HackathonRegistrationEntity> findByUserUserId(Integer userId);
	    List<HackathonRegistrationEntity> findByHackathon_HackathonId(Integer hackathonId);
	    
	    //delete registration
	    void deleteByUserUserIdAndHackathonHackathonId(Integer userId, Integer hackathonId);
}
