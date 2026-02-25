package com.Grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathon_description")
public class HackathonDescriptionEntity {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackathonDescriptionId;
	private Integer hackathonId; //fk
	private String hackathonDetails;
	
	
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
	public Integer getHackathonId() {
		return hackathonId;
	}
	public void setHackathonId(Integer hackathonId) {
		this.hackathonId = hackathonId;
	}
	
	
}
