package com.Grownited.entity;

import java.time.LocalDate;

import jakarta.persistence.*;
import com.Grownited.enums.AssignmentStatus;

@Entity
@Table(name = "hackathon_judge", uniqueConstraints = @UniqueConstraint(columnNames = { "user_id", "hackathon_id" }))
public class HackathonJudgeEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackathonJudgeId;

	// 🔗 Many Judges → One Hackathon
	@ManyToOne
	@JoinColumn(name = "hackathon_id", nullable = false)
	private HackathonEntity hackathon;

	// 🔗 Many Assignments → One User (Judge)
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private UserEntity user;

	// 📌 Status of evaluation
	@Enumerated(EnumType.STRING)
	private AssignmentStatus status;

	// 📅 Assignment date
	private LocalDate assignedAt;

	// ✅ Getters & Setters

	public Integer getHackathonJudgeId() {
		return hackathonJudgeId;
	}

	public void setHackathonJudgeId(Integer hackathonJudgeId) {
		this.hackathonJudgeId = hackathonJudgeId;
	}

	public HackathonEntity getHackathon() {
		return hackathon;
	}

	public void setHackathon(HackathonEntity hackathon) {
		this.hackathon = hackathon;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public AssignmentStatus getStatus() {
		return status;
	}

	public void setStatus(AssignmentStatus status) {
		this.status = status;
	}

	public LocalDate getAssignedAt() {
		return assignedAt;
	}

	public void setAssignedAt(LocalDate assignedAt) {
		this.assignedAt = assignedAt;
	}
}