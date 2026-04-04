package com.Grownited.entity;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="hackathon_team")
public class HackathonTeamEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer hackathonTeamId;

    @ManyToOne
    @JoinColumn(name = "hackathon_id")
    private HackathonEntity hackathon;

    @ManyToOne
    @JoinColumn(name = "team_leader_id")
    private UserEntity teamLeader;

    private String teamName;

    private boolean teamStatus;
    
    private String finalSubmissionLink;
    
    @OneToMany(mappedBy = "team")
    private List<HackathonTeamMembersEntity> members;

	public Integer getHackathonTeamId() {
		return hackathonTeamId;
	}

	public void setHackathonTeamId(Integer hackathonTeamId) {
		this.hackathonTeamId = hackathonTeamId;
	}

	public HackathonEntity getHackathon() {
		return hackathon;
	}

	public void setHackathon(HackathonEntity hackathon) {
		this.hackathon = hackathon;
	}

	public UserEntity getTeamLeader() {
		return teamLeader;
	}

	public void setTeamLeader(UserEntity teamLeader) {
		this.teamLeader = teamLeader;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public boolean isTeamStatus() {
		return teamStatus;
	}

	public void setTeamStatus(boolean teamStatus) {
		this.teamStatus = teamStatus;
	}

	public List<HackathonTeamMembersEntity> getMembers() {
		return members;
	}

	public void setMembers(List<HackathonTeamMembersEntity> members) {
		this.members = members;
	}

	public String getFinalSubmissionLink() {
		return finalSubmissionLink;
	}

	public void setFinalSubmissionLink(String finalSubmissionLink) {
		this.finalSubmissionLink = finalSubmissionLink;
	}

	
    
    
    
}