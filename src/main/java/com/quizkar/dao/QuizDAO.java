package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Quiz;

public interface QuizDAO {
	// -- Get ALL Quizzes 
	public abstract List<Quiz> getQuizes() throws SQLException;
	
	// -- Get Quizzes Given by Specific User 
//	public abstract List<Quiz> getSpecificUserQuizes(Integer userId) throws SQLException;
}
