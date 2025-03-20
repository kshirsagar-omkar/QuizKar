package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dto.GlobalLeaderBoardDTO;

public interface LeaderBoardDAO {
	
	//Get LeaderBoard details
	public abstract List<GlobalLeaderBoardDTO> getLeaderBoard(String filter) throws SQLException;
}
