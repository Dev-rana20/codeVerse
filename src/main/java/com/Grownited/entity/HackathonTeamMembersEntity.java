package com.Grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathon_team_members")
public class HackathonTeamMembersEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer hackathonTeamMemberId;

    @ManyToOne
    @JoinColumn(name = "team_id")
    private HackathonTeamEntity team;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private UserEntity member;

    private String roleTitle;
    
    private String status;

	public Integer getHackathonTeamMemberId() {
		return hackathonTeamMemberId;
	}

	public void setHackathonTeamMemberId(Integer hackathonTeamMemberId) {
		this.hackathonTeamMemberId = hackathonTeamMemberId;
	}

	public HackathonTeamEntity getTeam() {
		return team;
	}

	public void setTeam(HackathonTeamEntity team) {
		this.team = team;
	}

	public UserEntity getMember() {
		return member;
	}

	public void setMember(UserEntity member) {
		this.member = member;
	}

	public String getRoleTitle() {
		return roleTitle;
	}

	public void setRoleTitle(String roleTitle) {
		this.roleTitle = roleTitle;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
    
    
    
}