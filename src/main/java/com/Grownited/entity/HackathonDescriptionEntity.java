package com.Grownited.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_description")
public class HackathonDescriptionEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hackathonDescriptionId;

    @OneToOne
    @JoinColumn(name = "hackathon_id", unique = true) // ensures only 1 description per hackathon
    private HackathonEntity hackathon;

	@Column(columnDefinition = "LONGTEXT")
	private String hackathonDetailsText;
	private String hackathonDetailsURL;

	public Integer getHackathonDescriptionId() {
		return hackathonDescriptionId;
	}

	public void setHackathonDescriptionId(Integer hackathonDescriptionId) {
		this.hackathonDescriptionId = hackathonDescriptionId;
	}

	public String getHackathonDetailsText() {
		return hackathonDetailsText;
	}

	public void setHackathonDetailsText(String hackathonDetailsText) {
		this.hackathonDetailsText = hackathonDetailsText;
	}


	public HackathonEntity getHackathon() {
		return hackathon;
	}

	public void setHackathon(HackathonEntity hackathon) {
		this.hackathon = hackathon;
	}

	public String getHackathonDetailsURL() {
		return hackathonDetailsURL;
	}

	public void setHackathonDetailsURL(String hackathonDetailsURL) {
		this.hackathonDetailsURL = hackathonDetailsURL;
	}

}
