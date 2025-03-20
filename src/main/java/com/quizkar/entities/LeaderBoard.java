package com.quizkar.entities;

public class LeaderBoard {
	
	//@Id
	private Integer leaderBoardId;
	
	//@Columns
	private String participationDate;
	private Integer quizId;  			// Reference com.quizkar.entities -> Quiz.quizId
	private Integer userId;  			// Reference com.quizkar.entities -> Users.userId
	private Integer score;
	
	
	
	public Integer getLeaderBoardId() {
		return leaderBoardId;
	}
	public void setLeaderBoardId(Integer leaderBoardId) {
		this.leaderBoardId = leaderBoardId;
	}
	public String getParticipationDate() {
		return participationDate;
	}
	public void setParticipationDate(String participationDate) {
		this.participationDate = participationDate;
	}
	public Integer getQuizId() {
		return quizId;
	}
	public void setQuizId(Integer quizId) {
		this.quizId = quizId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	
	
}
