package com.quizkar.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
	
	
	

	
	
	
//	public static void main(String[] args) throws SQLException{
//	
//		QuizDAO qd = new QuizDAOImpl();
//		
//		
//		List<Quiz> qs = qd.getQuizes();
//		
//		if(qs != null) {
//			for(var q : qs) {
//				System.out.println( q.getQuizId() + " " + q.getTitle() + " " + q.getTimeLimit() + " " + q.getCreatedAt());
//			}
//		}
//		System.out.println("quiz");
//	}	
	
}
