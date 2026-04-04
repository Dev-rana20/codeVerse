package com.Grownited.entity;

import java.time.LocalDate;
import jakarta.persistence.Transient;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_registration")
public class HackathonRegistrationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer hackathonRegistrationId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name = "hackathon_id")
    private HackathonEntity hackathon;

    private LocalDate registrationDate;

    

    @Transient
    private String teamName;

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

	public Integer getHackathonRegistrationId() {
		return hackathonRegistrationId;
	}

	public void setHackathonRegistrationId(Integer hackathonRegistrationId) {
		this.hackathonRegistrationId = hackathonRegistrationId;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public HackathonEntity getHackathon() {
		return hackathon;
	}

	public void setHackathon(HackathonEntity hackathon) {
		this.hackathon = hackathon;
	}

	public LocalDate getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(LocalDate registrationDate) {
		this.registrationDate = registrationDate;
	}
}
