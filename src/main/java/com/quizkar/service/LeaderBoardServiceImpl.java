package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dao.LeaderBoardDAO;
import com.quizkar.dao.LeaderBoardDAOImpl;
import com.quizkar.dto.GlobalLeaderBoardDTO;
import com.quizkar.entities.LeaderBoard;

public class LeaderBoardServiceImpl implements LeaderBoardService{

	//Get LeaderBoard details
	public List<GlobalLeaderBoardDTO> getLeaderBoard(String filter) throws SQLException{
		LeaderBoardDAO leaderBoardDAO = new LeaderBoardDAOImpl();
		
		return leaderBoardDAO.getLeaderBoard(filter);
	}
	
	//Add a record in LeaderBoard
	public Integer addLeaderBoard(LeaderBoard leaderBoard) throws SQLException{
		LeaderBoardDAO leaderBoardDAO = new LeaderBoardDAOImpl();
		
		return leaderBoardDAO.addLeaderBoard(leaderBoard);
	}
	
	
	
	//If record already exist it returns true else false
	public Boolean checkIfRecordExistsInLeaderBoard(LeaderBoard leaderBoard) throws SQLException{
		LeaderBoardDAO leaderBoardDAO = new LeaderBoardDAOImpl();
	
		return leaderBoardDAO.checkIfRecordExistsInLeaderBoard(leaderBoard);
	}
	
	
	//Update a record in LeaderBoard returns row affected
	public Integer updateLeaderBoard(LeaderBoard leaderBoard) throws SQLException{
		LeaderBoardDAO leaderBoardDAO = new LeaderBoardDAOImpl();
		
		return leaderBoardDAO.updateLeaderBoard(leaderBoard);
	}
	
}
