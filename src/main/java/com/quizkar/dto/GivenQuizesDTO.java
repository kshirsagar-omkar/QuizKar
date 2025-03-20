package com.quizkar.dto;

import com.quizkar.entities.LeaderBoard;
import com.quizkar.entities.Quiz;

public class GivenQuizesDTO {
	private Integer quizId;
	private String  quizTitle; 
	private Integer quizTimeLimit;
	private Integer leaderBoardScore;
	private String  leaderBoardParticipationDate;
	private Integer leaderBoardTimeTaken;
	
	
	
	
	public Integer getQuizId() {
		return quizId;
	}
	public void setQuizId(Integer quizId) {
		this.quizId = quizId;
	}
	public String getQuizTitle() {
		return quizTitle;
	}
	public void setQuizTitle(String quizTitle) {
		this.quizTitle = quizTitle;
	}
	public Integer getQuizTimeLimit() {
		return quizTimeLimit;
	}
	public void setQuizTimeLimit(Integer quizTimeLimit) {
		this.quizTimeLimit = quizTimeLimit;
	}
	public Integer getLeaderBoardScore() {
		return leaderBoardScore;
	}
	public void setLeaderBoardScore(Integer leaderBoardScore) {
		this.leaderBoardScore = leaderBoardScore;
	}
	public String getLeaderBoardParticipationDate() {
		return leaderBoardParticipationDate;
	}
	public void setLeaderBoardParticipationDate(String leaderBoardParticipationDate) {
		this.leaderBoardParticipationDate = leaderBoardParticipationDate;
	}
	public Integer getLeaderBoardTimeTaken() {
		return leaderBoardTimeTaken;
	}
	public void setLeaderBoardTimeTaken(Integer leaderBoardTimeTaken) {
		this.leaderBoardTimeTaken = leaderBoardTimeTaken;
	}
	

	
	
	
}
