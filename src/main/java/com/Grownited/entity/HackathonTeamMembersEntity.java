package com.Grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathon_team_members")
public class HackathonTeamMembersEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackathonTeamMemberId;
	private Integer teamId;//fk
	private Integer hackathonId;//fk
	private Integer memberId;// fk
	private String rollTitle;
	public Integer getHackathonTeamMemberId() {
		return hackathonTeamMemberId;
	}
	public void setHackathonTeamMemberId(Integer hackathonTeamMemberId) {
		this.hackathonTeamMemberId = hackathonTeamMemberId;
	}
	public Integer getTeamId() {
		return teamId;
	}
	public void setTeamId(Integer teamId) {
		this.teamId = teamId;
	}
	public Integer getHackathonId() {
		return hackathonId;
	}
	public void setHackathonId(Integer hackathonId) {
		this.hackathonId = hackathonId;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getRollTitle() {
		return rollTitle;
	}
	public void setRollTitle(String rollTitle) {
		this.rollTitle = rollTitle;
	}
	
	
}
