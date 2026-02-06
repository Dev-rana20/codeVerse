package com.Grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathonDescription")
public class HackathonDescriptionEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackathonDescriptionId;
	private String hackathonDetails;
	
	
	//getter & setter
	public Integer getHackathonDescriptionId() {
		return hackathonDescriptionId;
	}
	public void setHackathonDescriptionId(Integer hackathonDescriptionId) {
		this.hackathonDescriptionId = hackathonDescriptionId;
	}
	public String getHackathonDetails() {
		return hackathonDetails;
	}
	public void setHackathonDetails(String hackathonDetails) {
		this.hackathonDetails = hackathonDetails;
	}
	
	
	
}
