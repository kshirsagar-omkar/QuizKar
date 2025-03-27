package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.dto.GivenQuizesDTO;
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
	
	
	
	
	public Integer addQuiz(Quiz quiz) throws SQLException
	{
		String query = "INSERT INTO quiz (title, created_by, time_limit) VALUES (?, ?, ?) RETURNING quiz_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setString(1, quiz.getTitle());
		    preparedStatement.setInt(2, quiz.getCreatedBy());
		    preparedStatement.setInt(3, quiz.getTimeLimit());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        generatedId = resultSet.getInt("quiz_id");
//		        System.out.println("Inserted User ID: " + generatedId);
		    }
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
	}
	
	
	
	
	
	
	
	public List<Quiz> getQuizCreatedByAdmin(Integer userId) throws SQLException
	{
		List<Quiz> quizs = new ArrayList<>();
		
		final String query = "SELECT quiz_id, title, time_limit, created_at FROM quiz WHERE created_by = ?";
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
					
				preparedStatement.setInt(1, userId);
				
				try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
		
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
	}
	
	
	
	
	public Integer DeleteQuizCreatedByAdmin(Integer quizId) throws SQLException
	{
		
		Integer affectedRow = 0;
		final String query = "DELETE FROM quiz WHERE quiz_id = ?";
		
		try (Connection connection = DBUtil.getConnection()){
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
					
				preparedStatement.setInt(1, quizId);
				
				affectedRow = preparedStatement.executeUpdate();
				
				connection.commit();
			}
			catch(SQLException e) {
				if(connection != null) {
					connection.rollback();
				}
				throw e;
			}
			
		}
		return affectedRow;
	}
	
	
	//return row Affected
	public Integer updateQuizCreatedByAdmin(Quiz quiz) throws SQLException
	{
		String query = "UPDATE quiz SET title = ?, time_limit = ? where quiz_id = ?";
		Integer rowAffected = 0;
		
		try (Connection connection = DBUtil.getConnection()){
		
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
				
				
	//			connection.setAutoCommit(false);
				
			    preparedStatement.setString(1, quiz.getTitle());
			    preparedStatement.setInt(2, quiz.getTimeLimit());
			    preparedStatement.setInt(3, quiz.getQuizId());
	
			    rowAffected = preparedStatement.executeUpdate();
			    
			    connection.commit();
			}
			catch (SQLException e) {
			    e.printStackTrace();
			    if(connection != null) {
					connection.rollback();
				}
			    throw e;
			}
			return rowAffected;
		}
	}
	
	
	
	
	
	
	
	
//	public static void main(String[] args) {
//    try {
//    	QuizDAO dao = new QuizDAOImpl();
//
//    	Quiz ob = new Quiz();
//    	ob.setTitle("aaaaaaa");
//    	ob.setCreatedBy(1);
//    	ob.setTimeLimit(50);
//    	
//    	Integer retVal = dao.addQuiz(ob);
//
//    	System.out.println(retVal);
//
//    	
//    	
//    }
//    catch(SQLException e) {
//    	e.printStackTrace();
//    }
//}
	
	
	
	
	
	
	
	
	

//	public static void main(String[] args) {
//	    try {
//	    	QuizDAO dao = new QuizDAOImpl();
//	
////	    	Quiz ob = new Quiz();
////	    	ob.setTitle("aaaaaaa");
////	    	ob.setCreatedBy(1);
////	    	ob.setTimeLimit(50);
////	    	
////	    	Integer Id = dao.addQuiz(ob);
////	
////	    	System.out.println(Id);
//	    	
//	    	
//	    	List<Quiz> L = dao.getQuizCreatedByAdmin(1);
//	    	if(L != null) {
//		    	for(var ob : L) {
//		    		display(ob);
//		    	}
//	    	}
//	    	else {
//	    		System.out.println("No Quiz Found!");
//	    	}
//	    	
//	    	
//	    	
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}
//	
//	
//	private static void display(Quiz ob) {
//		System.out.println(ob.getQuizId());
//		System.out.println(ob.getTitle());
//		System.out.println(ob.getTimeLimit());
//		System.out.println(ob.getCreatedAt() + "\n");
//	}
	
}
