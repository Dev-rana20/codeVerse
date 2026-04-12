package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
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

	    @Query("SELECT SUM(h.amount) FROM HackathonRegistrationEntity h")
	    Long getTotalRevenue();

	    // Feature 1: Cascade delete all registrations for a hackathon
	    void deleteByHackathon_HackathonId(Integer hackathonId);

	    // Feature 5: Count participants per hackathon (bulk)
	    @Query("SELECT r.hackathon.hackathonId, COUNT(r) FROM HackathonRegistrationEntity r GROUP BY r.hackathon.hackathonId")
	    List<Object[]> countByHackathonGrouped();

	    // Feature 5: Count participants for a single hackathon
	    long countByHackathon_HackathonId(Integer hackathonId);
}
