package com.Grownited.entity;


import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathon")
public class HackathonEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackthonId;
	private String title;
	private boolean status;
	private String eventType;
	private boolean payment;
	private Integer minTeamSize;
	private Integer maxTeamSize;
	private String location;
	private String userType;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate registrationStartDate;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate registrationEndDate;
	
	
	//getter & setter
	public Integer getHackthonId() {
		return hackthonId;
	}
	public void setHackthonId(Integer hackthonId) {
		this.hackthonId = hackthonId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public boolean isPayment() {
		return payment;
	}
	public void setPayment(boolean payment) {
		this.payment = payment;
	}
	public Integer getMinTeamSize() {
		return minTeamSize;
	}
	public void setMinTeamSize(Integer minTeamSize) {
		this.minTeamSize = minTeamSize;
	}
	public Integer getMaxTeamSize() {
		return maxTeamSize;
	}
	public void setMaxTeamSize(Integer maxTeamSize) {
		this.maxTeamSize = maxTeamSize;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public LocalDate getRegistrationStartDate() {
		return registrationStartDate;
	}
	public void setRegistrationStartDate(LocalDate registrationStartDate) {
		this.registrationStartDate = registrationStartDate;
	}
	public LocalDate getRegistrationEndDate() {
		return registrationEndDate;
	}
	public void setRegistrationEndDate(LocalDate registrationEndDate) {
		this.registrationEndDate = registrationEndDate;
	}
	
	
}
