package com.Grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name = "evaluations",
       uniqueConstraints = @UniqueConstraint(columnNames = {"team_id", "judge_id"}))
public class EvaluationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer evaluationId;

    @ManyToOne
    @JoinColumn(name = "team_id")
    private HackathonTeamEntity team;

    @ManyToOne
    @JoinColumn(name = "judge_id")
    private UserEntity judge;

    private Integer innovation;
    private Integer technical;
    private Integer uiUx;
    private Integer functionality;
    private Integer presentation;
    private Integer impact;

    private Integer totalScore;

    private String remarks;

	public Integer getEvaluationId() {
		return evaluationId;
	}

	public void setEvaluationId(Integer evaluationId) {
		this.evaluationId = evaluationId;
	}

	public HackathonTeamEntity getTeam() {
		return team;
	}

	public void setTeam(HackathonTeamEntity team) {
		this.team = team;
	}

	public UserEntity getJudge() {
		return judge;
	}

	public void setJudge(UserEntity judge) {
		this.judge = judge;
	}

	public Integer getInnovation() {
		return innovation;
	}

	public void setInnovation(Integer innovation) {
		this.innovation = innovation;
	}

	public Integer getTechnical() {
		return technical;
	}

	public void setTechnical(Integer technical) {
		this.technical = technical;
	}

	public Integer getUiUx() {
		return uiUx;
	}

	public void setUiUx(Integer uiUx) {
		this.uiUx = uiUx;
	}

	public Integer getFunctionality() {
		return functionality;
	}

	public void setFunctionality(Integer functionality) {
		this.functionality = functionality;
	}

	public Integer getPresentation() {
		return presentation;
	}

	public void setPresentation(Integer presentation) {
		this.presentation = presentation;
	}

	public Integer getImpact() {
		return impact;
	}

	public void setImpact(Integer impact) {
		this.impact = impact;
	}

	public Integer getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(Integer totalScore) {
		this.totalScore = totalScore;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
    
    
   // getters & setters
    
    
}