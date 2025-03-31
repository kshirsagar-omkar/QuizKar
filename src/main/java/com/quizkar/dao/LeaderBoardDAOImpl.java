package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.dto.GlobalLeaderBoardDTO;
import com.quizkar.entities.LeaderBoard;
import com.quizkar.util.DBUtil;

public class LeaderBoardDAOImpl implements LeaderBoardDAO{

	public List<GlobalLeaderBoardDTO> getLeaderBoard(String filter) throws SQLException{		

		String query = queryGenerator(filter);
		
		List<GlobalLeaderBoardDTO> globalLeaderBoardDTOs = new ArrayList<>();
		
		
		try (Connection connection = DBUtil.getConnection();
			 Statement  statement  = connection.createStatement();
			 ResultSet	resultSet  = statement.executeQuery(query) ) {
			
			while(resultSet.next()) {
				
				GlobalLeaderBoardDTO globalLeaderBoardDTO = new GlobalLeaderBoardDTO();
				
				// Set values from resultSet
	            globalLeaderBoardDTO.setQuizTitle(resultSet.getString("title"));
	            globalLeaderBoardDTO.setUsername(resultSet.getString("username"));
	            globalLeaderBoardDTO.setScore(resultSet.getInt("score"));
	            globalLeaderBoardDTO.setParticipationDate(resultSet.getString("participation_date").split("\\.")[0]);
	            globalLeaderBoardDTO.setTimeLimit(resultSet.getInt("time_limit"));
	            globalLeaderBoardDTO.setTimeTaken(resultSet.getInt("time_taken"));
	            globalLeaderBoardDTO.setRank(resultSet.getInt("rank"));
				
				
				globalLeaderBoardDTOs.add(globalLeaderBoardDTO);	
			}
		}	
		return globalLeaderBoardDTOs.isEmpty() ? null : globalLeaderBoardDTOs;
	}
	//Helper Method
	private String queryGenerator(String filter) {
		
		if(filter != null) {
			return "SELECT q.title, u.username, lb.score, lb.participation_date, q.time_limit, lb.time_taken, " +
		               "ROW_NUMBER() OVER (PARTITION BY q.quiz_id ORDER BY lb.score DESC, lb.time_taken ASC) AS rank " +
		               "FROM leaderboard lb " +
		               "JOIN users u ON lb.user_id = u.user_id " +
		               "JOIN quiz q ON lb.quiz_id = q.quiz_id " +
		               "WHERE q.title = '" + filter + "' " + // <- WHERE comes before ORDER BY
		               "ORDER BY q.title, rank";
		}
		
		return  "SELECT q.title, u.username, lb.score, lb.participation_date, q.time_limit, lb.time_taken, " +
                "ROW_NUMBER() OVER (PARTITION BY q.quiz_id ORDER BY lb.score DESC, lb.time_taken ASC) AS rank " +
                "FROM leaderboard lb " +
                "JOIN users u ON lb.user_id = u.user_id " +
                "JOIN quiz q ON lb.quiz_id = q.quiz_id " +
                "ORDER BY q.title, rank";

	}
	
	
	
	
	
	public Integer addLeaderBoard(LeaderBoard leaderBoard) throws SQLException
	{
		String query = "INSERT INTO leaderboard (quiz_id, user_id, score, time_taken) VALUES(?, ?, ?, ?) RETURNING leaderboard_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setInt(1, leaderBoard.getQuizId());
		    preparedStatement.setInt(2, leaderBoard.getUserId());
		    preparedStatement.setInt(3, leaderBoard.getScore());
		    preparedStatement.setInt(4, leaderBoard.getTimeTaken());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        generatedId = resultSet.getInt("leaderboard_id");
//		        System.out.println("Inserted  ID: " + generatedId);
		    }
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
	}
	
	
	
	//If record already exist it returns true else false
	public Boolean checkIfRecordExistsInLeaderBoard(LeaderBoard leaderBoard) throws SQLException{
		
		String query = "SELECT leaderboard_id FROM leaderboard WHERE quiz_id = ? AND  user_id = ?";
	
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
		    preparedStatement.setInt(1, leaderBoard.getQuizId());
		    preparedStatement.setInt(2, leaderBoard.getUserId());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        return true;
		    }
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return false;
		
	}
	
	
	
	 
	//Update a record in LeaderBoard returns row affected
	public Integer updateLeaderBoard(LeaderBoard leaderBoard) throws SQLException{
		String query = "UPDATE leaderboard SET score = ? , time_taken = ?, participation_date = CURRENT_TIMESTAMP WHERE quiz_id = ? AND user_id = ?";
		
		Integer rowsAffected = 0;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setInt(3, leaderBoard.getQuizId());
		    preparedStatement.setInt(4, leaderBoard.getUserId());
		    preparedStatement.setInt(1, leaderBoard.getScore());
		    preparedStatement.setInt(2, leaderBoard.getTimeTaken());

		    rowsAffected = preparedStatement.executeUpdate();
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return rowsAffected;
	}
	
	
	
	
//	public static void main(String[] args) {
//	    try {
//	    	LeaderBoardDAO dao = new LeaderBoardDAOImpl();
//	
//	    	LeaderBoard ob = new LeaderBoard();
//	    	ob.setQuizId(2);
//	    	ob.setUserId(3);
//	    	ob.setScore(50);
//	    	ob.setTimeTaken(10);
//	    	
//	    	Integer Id = dao.addLeaderBoard(ob);
//	
//	    	System.out.println(Id);
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}


}
