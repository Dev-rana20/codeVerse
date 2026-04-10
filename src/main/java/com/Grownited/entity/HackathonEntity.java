package com.Grownited.entity;

import java.time.LocalDate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="hackathon")
public class HackathonEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer hackathonId;

	@NotBlank(message = "Title is required")
	@Size(min = 5, max = 100, message = "Title must be between 5 and 100 characters")
	String title;

	String status;

	@NotBlank(message = "Event type is required")
	String eventType;

	@NotBlank(message = "Payment type is required")
	String payment;

	@Min(value = 0, message = "Fee cannot be negative")
	Integer fee;

	@NotNull(message = "Minimum team size is required")
	@Min(value = 1, message = "Minimum team size must be at least 1")
	Integer minTeamSize;

	@NotNull(message = "Maximum team size is required")
	@Min(value = 1, message = "Maximum team size must be at least 1")
	Integer maxTeamSize;

	String location;
	Integer userTypeId;// fk

	@NotNull(message = "Registration start date is required")
	LocalDate registrationStartDate;

	@NotNull(message = "Registration end date is required")
	LocalDate registrationEndDate;

	LocalDate eventStartDate;
	LocalDate eventEndDate;
	LocalDate submissionDeadline;

	Integer userId; // fk
	
	 @OneToOne(mappedBy = "hackathon", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	    private HackathonDescriptionEntity description;

	
	public Integer getHackathonId() {
		return hackathonId;
	}
	public void setHackathonId(Integer hackathonId) {
		this.hackathonId = hackathonId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public Integer getMinTeamSize() {
		return minTeamSize;
	}
	public void setMinTeamSize(Integer minTeamSize) {
		this.minTeamSize = minTeamSize;
	}
	public Integer getFee() {
		return fee;
	}
	public void setFee(Integer fee) {
		this.fee = fee;
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
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
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
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public HackathonDescriptionEntity getDescription() {
		return description;
	}
	public void setDescription(HackathonDescriptionEntity description) {
		this.description = description;
	}

	public LocalDate getEventStartDate() {
		return eventStartDate;
	}
	public void setEventStartDate(LocalDate eventStartDate) {
		this.eventStartDate = eventStartDate;
	}

	public LocalDate getEventEndDate() {
		return eventEndDate;
	}
	public void setEventEndDate(LocalDate eventEndDate) {
		this.eventEndDate = eventEndDate;
	}

	public LocalDate getSubmissionDeadline() {
		return submissionDeadline;
	}
	public void setSubmissionDeadline(LocalDate submissionDeadline) {
		this.submissionDeadline = submissionDeadline;
	}



}
