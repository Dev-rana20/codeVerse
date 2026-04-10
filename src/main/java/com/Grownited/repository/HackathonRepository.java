package com.Grownited.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.Grownited.entity.HackathonEntity;

@Repository
public interface HackathonRepository extends JpaRepository<HackathonEntity, Integer> {

	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE HackathonEntity h SET h.status = 'Close' WHERE h.registrationEndDate < :today AND h.status NOT IN ('Close', 'IN_PROGRESS')")
	void updateStatusToClose(@Param("today") LocalDate today);

	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE HackathonEntity h SET h.status = 'IN_PROGRESS' WHERE :today >= h.eventStartDate AND :today <= h.eventEndDate AND h.status != 'IN_PROGRESS'")
	void updateStatusToInProgress(@Param("today") LocalDate today);

	@Query("SELECT h FROM HackathonEntity h WHERE h.eventStartDate = :tomorrow")
	List<HackathonEntity> findHackathonsStartingOn(@Param("tomorrow") LocalDate tomorrow);

	@Query("SELECT h FROM HackathonEntity h WHERE h.submissionDeadline = :tomorrow")
	List<HackathonEntity> findHackathonsWithDeadlineOn(@Param("tomorrow") LocalDate tomorrow);

	List<HackathonEntity> findByStatusIn(List<String> statuses);
}
