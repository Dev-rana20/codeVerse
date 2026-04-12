package com.Grownited.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="user_details")
public class UserDetailEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer userDetailId;
	private Integer userId;

	@NotBlank(message = "Qualification is required")
	private String qualification;

	@NotBlank(message = "City is required")
	private String city;

	@NotBlank(message = "State is required")
	private String state;

	@NotBlank(message = "Country is required")
	private String country;

	private String workExperience;
	private Integer userTypeId;

	@Size(max = 1000, message = "Bio cannot exceed 1000 characters")
	@Column(length = 1000)
	private String bio;

	private String githubLink;

	// Comma-separated skill tags, e.g. "Java,React,Machine Learning"
	@Column(length = 500)
	private String skills;
	
	
	public Integer getUserDetailId() {
		return userDetailId;
	}
	public void setUserDetailId(Integer userDetailId) {
		this.userDetailId = userDetailId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer uerId) {
		this.userId = uerId;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getWorkExperience() {
		return workExperience;
	}
	public void setWorkExperience(String workExperience) {
		this.workExperience = workExperience;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}

	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getGithubLink() {
		return githubLink;
	}
	public void setGithubLink(String githubLink) {
		this.githubLink = githubLink;
	}

	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}

	// Feature 3: Social media links
	private String linkedinLink;
	private String twitterLink;

	public String getLinkedinLink() {
		return linkedinLink;
	}
	public void setLinkedinLink(String linkedinLink) {
		this.linkedinLink = linkedinLink;
	}

	public String getTwitterLink() {
		return twitterLink;
	}
	public void setTwitterLink(String twitterLink) {
		this.twitterLink = twitterLink;
	}
}
