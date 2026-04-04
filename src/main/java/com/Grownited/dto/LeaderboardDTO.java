package com.Grownited.dto;

public class LeaderboardDTO {

    private String teamName;
    private Integer innovation;
    private Integer technical;
    private Integer uiUx;
    private Integer functionality;
    private Integer presentation;
    private Integer impact;
    private Integer totalScore;
    private String remarks;

    public LeaderboardDTO(String teamName, Integer innovation, Integer technical,
                          Integer uiUx, Integer functionality, Integer presentation,
                          Integer impact, Integer totalScore, String remarks) {

        this.teamName = teamName;
        this.innovation = innovation;
        this.technical = technical;
        this.uiUx = uiUx;
        this.functionality = functionality;
        this.presentation = presentation;
        this.impact = impact;
        this.totalScore = totalScore;
        this.remarks = remarks;
    }

	public String getTeamName() {
		return teamName;
	}

	public Integer getInnovation() {
		return innovation;
	}

	public Integer getTechnical() {
		return technical;
	}

	public Integer getUiUx() {
		return uiUx;
	}

	public Integer getFunctionality() {
		return functionality;
	}

	public Integer getPresentation() {
		return presentation;
	}

	public Integer getImpact() {
		return impact;
	}

	public Integer getTotalScore() {
		return totalScore;
	}

	public String getRemarks() {
		return remarks;
	}

    
}
