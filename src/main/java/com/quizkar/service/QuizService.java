package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Quiz;

public interface QuizService {

	
	
	
	
	
	
	
	// -- Add Quiz returns the inserted quiz id
	public abstract Integer addQuiz(Quiz quiz) throws SQLException;
	
	
	
	// -- Get Quiz Created by admin
	public abstract List<Quiz> getQuizCreatedByAdmin(Integer userId) throws SQLException;
	
	
	// -- Delete Quiz Created by admin RETURN RowAffected
	public abstract Integer DeleteQuizCreatedByAdmin(Integer quizId) throws SQLException;
	
	
	// -- Update Quiz Created by admin RETURN RowAffected
	public abstract Integer updateQuizCreatedByAdmin(Quiz quiz) throws SQLException;
}
