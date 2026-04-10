package com.Grownited.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="users")
public class UserEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer userId;

	@NotBlank(message = "First name is required")
	@Size(min = 2, max = 50, message = "First name must be between 2 and 50 characters")
	private String firstName;

	@NotBlank(message = "Last name is required")
	@Size(min = 2, max = 50, message = "Last name must be between 2 and 50 characters")
	private String lastName;

	@NotBlank(message = "Email is required")
	@Email(message = "Invalid email format")
	private String email;

	@NotBlank(message = "Password is required")
	@Size(min = 6, message = "Password must be at least 6 characters")
	private String password;

	private LocalDate createdAt;
	private String role; //admin , participant , judge
	private String gender;

	@Min(value = 1900, message = "Invalid birth year")
	@Max(value = 2026, message = "Birth year cannot be in the future")
	private Integer birthYear;

	@Pattern(regexp = "^\\d{10}$", message = "Contact number must be 10 digits")
	private String contactNum; 

	private String profilePicURL;
	private String otp;
	private Boolean active;
	private boolean firstLogin = true;
	private LocalDateTime otpExpiresAt;

	private Integer failedLoginAttempts = 0;
	private Integer failedOtpAttempts = 0;
	private LocalDateTime lockedUntil;

	
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Integer getBirthYear() {
		return birthYear;
	}
	public void setBirthYear(Integer birthYear) {
		this.birthYear = birthYear;
	}
	public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getProfilePicURL() {
		return profilePicURL;
	}
	public void setProfilePicURL(String profilePicURL) {
		this.profilePicURL = profilePicURL;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	public LocalDate getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDate createdAt) {
		this.createdAt = createdAt;
	}
	public boolean isFirstLogin() {
		return firstLogin;
	}
	public void setFirstLogin(boolean firstLogin) {
		this.firstLogin = firstLogin;
	}
	public LocalDateTime getOtpExpiresAt() {
		return otpExpiresAt;
	}
	public void setOtpExpiresAt(LocalDateTime otpExpiresAt) {
		this.otpExpiresAt = otpExpiresAt;
	}

	public Integer getFailedLoginAttempts() {
		return failedLoginAttempts != null ? failedLoginAttempts : 0;
	}
	public void setFailedLoginAttempts(Integer failedLoginAttempts) {
		this.failedLoginAttempts = failedLoginAttempts;
	}

	public Integer getFailedOtpAttempts() {
		return failedOtpAttempts != null ? failedOtpAttempts : 0;
	}
	public void setFailedOtpAttempts(Integer failedOtpAttempts) {
		this.failedOtpAttempts = failedOtpAttempts;
	}

	public LocalDateTime getLockedUntil() {
		return lockedUntil;
	}
	public void setLockedUntil(LocalDateTime lockedUntil) {
		this.lockedUntil = lockedUntil;
	}

	
	
}
