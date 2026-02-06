package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.HackathonEntity;

@Repository
public interface HackathonRepository extends JpaRepository<HackathonEntity, Integer>{

}
