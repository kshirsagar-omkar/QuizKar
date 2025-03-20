package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.dto.GivenQuizesDTO;
import com.quizkar.entities.LeaderBoard;
import com.quizkar.entities.Quiz;
import com.quizkar.util.DBUtil;

public class QuizDAOImpl implements QuizDAO{

	public List<Quiz> getQuizes() throws SQLException{
		
		List<Quiz> quizs = new ArrayList<>();
		
		final String query = "SELECT quiz_id, title, time_limit, created_at FROM quiz";
		
		
		try (Connection connection = DBUtil.getConnection();
			 Statement  statement  = connection.createStatement();
			 ResultSet	resultSet  = statement.executeQuery(query) ) {
			
			while(resultSet.next()) {
				
				Quiz quiz = new Quiz();
				
				quiz.setQuizId( resultSet.getInt("quiz_id") );
				quiz.setTitle( resultSet.getString("title") );
				quiz.setTimeLimit( resultSet.getInt("time_limit") );
				//2025-03-20 17:26:45.918626 -> 2025-03-20 17:26:45
				quiz.setCreatedAt( (resultSet.getString("created_at")).split("\\.")[0] );	
				
				quizs.add(quiz);	
			}
		}	
		return quizs.isEmpty() ? null : quizs;
	}
	
	
	
	public List<GivenQuizesDTO> getQuizesGivenBySpecificUser(Integer userId) throws SQLException{
		
		
		List<GivenQuizesDTO> quizLeaderBoardDTOs = new ArrayList<>();
		
		final String query = "SELECT q.quiz_id, q.title, q.time_limit, lb.score, lb.participation_date, lb.time_taken FROM quiz q JOIN leaderboard lb ON q.quiz_id = lb.quiz_id WHERE lb.user_id = ?";
		
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
				
				preparedStatement.setInt(1, userId);
				
				try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
					
					while(resultSet.next()) {					
						GivenQuizesDTO quizLeaderBoardDTO = new GivenQuizesDTO();
						
						// Set values to the object
						quizLeaderBoardDTO.setQuizId(resultSet.getInt("quiz_id"));
						quizLeaderBoardDTO.setQuizTitle(resultSet.getString("title"));
						quizLeaderBoardDTO.setQuizTimeLimit(resultSet.getInt("time_limit"));
						
						quizLeaderBoardDTO.setLeaderBoardScore(resultSet.getInt("score"));
						quizLeaderBoardDTO.setLeaderBoardParticipationDate(resultSet.getString("participation_date").split("\\.")[0]);
						quizLeaderBoardDTO.setLeaderBoardTimeTaken(resultSet.getInt("time_taken"));
						
						quizLeaderBoardDTOs.add(quizLeaderBoardDTO);
						
					}
				}	
			}	
		
		return quizLeaderBoardDTOs.isEmpty() ? null : quizLeaderBoardDTOs;
		
	}
	

	
//	public static void main(String[] args) throws SQLException {
//		
//		QuizDAO qd = new QuizDAOImpl();
//		
//		List<GivenQuizesDTO> l = qd.getQuizGivenBySpecificUser(2);
//		
//		if (l != null) {
//			for (var q : l) {
//				System.out.println(
//					q.getQuizId() + " " +
//					q.getQuizTitle() + " " +
//					q.getQuizTimeLimit() + " " +
//					q.getLeaderBoardScore() + " " +
//					q.getLeaderBoardParticipationDate() + " " +
//					q.getLeaderBoardTimeTaken()
//				);
//			}
//		} else {
//			System.out.println("No quizzes found for this user.");
//		}
//		
//		System.out.println("quiz");
//	}

	
}
