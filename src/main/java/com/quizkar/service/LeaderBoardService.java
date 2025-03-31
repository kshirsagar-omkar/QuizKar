package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.entities.LeaderBoard;

public interface LeaderBoardService {

	
	//Add a record in LeaderBoard
	public abstract Integer addLeaderBoard(LeaderBoard leaderBoard) throws SQLException;
	
	
	//If record already exist it returns true else false
	public abstract Boolean checkIfRecordExistsInLeaderBoard(LeaderBoard leaderBoard) throws SQLException;
	
	//Update a record in LeaderBoard returns row affected
	public abstract Integer updateLeaderBoard(LeaderBoard leaderBoard) throws SQLException;
}
