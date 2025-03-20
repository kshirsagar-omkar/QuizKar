package com.quizkar.dto;

public class GlobalLeaderBoardDTO {
	private String  username;
	private String  quizTitle;
	private Integer score;
	private String  participationDate;
	private Integer timeLimit;
	private Integer timeTaken;
	private Integer rank;
	
	
	public Integer getRank() {
		return rank;
	}
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getQuizTitle() {
		return quizTitle;
	}
	public void setQuizTitle(String quizTitle) {
		this.quizTitle = quizTitle;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getParticipationDate() {
		return participationDate;
	}
	public void setParticipationDate(String participationDate) {
		this.participationDate = participationDate;
	}
	public Integer getTimeLimit() {
		return timeLimit;
	}
	public void setTimeLimit(Integer timeLimit) {
		this.timeLimit = timeLimit;
	}
	public Integer getTimeTaken() {
		return timeTaken;
	}
	public void setTimeTaken(Integer timeTaken) {
		this.timeTaken = timeTaken;
	}
	
	
}
