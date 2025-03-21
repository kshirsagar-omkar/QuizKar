package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dto.GlobalLeaderBoardDTO;
import com.quizkar.entities.LeaderBoard;

public interface LeaderBoardDAO {
	
	//Get LeaderBoard details
	public abstract List<GlobalLeaderBoardDTO> getLeaderBoard(String filter) throws SQLException;
	
	//Add a record in LeaderBoard
	public abstract Integer addLeaderBoard(LeaderBoard leaderBoard) throws SQLException;
}
