package com.quizkar.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.dto.GlobalLeaderBoardDTO;
import com.quizkar.util.DBUtil;

public class LeaderBoardDAOImpl implements LeaderBoardDAO{

	public List<GlobalLeaderBoardDTO> getLeaderBoard(String filter) throws SQLException{		

		String query = "SELECT q.title, u.username, lb.score, lb.participation_date, q.time_limit, lb.time_taken, " +
                "ROW_NUMBER() OVER (PARTITION BY q.quiz_id ORDER BY lb.score DESC, lb.time_taken ASC) AS rank " +
                "FROM leaderboard lb " +
                "JOIN users u ON lb.user_id = u.user_id " +
                "JOIN quiz q ON lb.quiz_id = q.quiz_id " +
                "ORDER BY q.title, rank";
		
		if(filter != null) {
			query = "SELECT q.title, u.username, lb.score, lb.participation_date, q.time_limit, lb.time_taken, " +
		               "ROW_NUMBER() OVER (PARTITION BY q.quiz_id ORDER BY lb.score DESC, lb.time_taken ASC) AS rank " +
		               "FROM leaderboard lb " +
		               "JOIN users u ON lb.user_id = u.user_id " +
		               "JOIN quiz q ON lb.quiz_id = q.quiz_id " +
		               "WHERE q.title = '" + filter + "' " + // <- WHERE comes before ORDER BY
		               "ORDER BY q.title, rank";
		}
		
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
	
	
	
	
//	public static void main(String[] args) {
//	    try {
//	    	LeaderBoardDAO leaderboardService = new LeaderBoardDAOImpl(); // Replace with your actual class name
//	        List<GlobalLeaderBoardDTO> leaderboard = leaderboardService.getLeaderBoard("Java OOPs Quiz");
//
//	        if (leaderboard != null) {
//	            for (GlobalLeaderBoardDTO dto : leaderboard) {
//	                System.out.println("Quiz Title: " + dto.getQuizTitle());
//	                System.out.println("Username: " + dto.getUsername());
//	                System.out.println("Score: " + dto.getScore());
//	                System.out.println("Participation Date: " + dto.getParticipationDate());
//	                System.out.println("Time Limit: " + dto.getTimeLimit());
//	                System.out.println("Time Taken: " + dto.getTimeTaken());
//	                System.out.println("Rank: " + dto.getRank());
//	                System.out.println("----------------------------");
//	            }
//	        } else {
//	            System.out.println("No leaderboard data found.");
//	        }
//	    } catch (SQLException e) {
//	        e.printStackTrace();
//	    }
//	}


}
