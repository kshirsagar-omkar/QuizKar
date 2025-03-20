package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dto.GivenQuizesDTO;
import com.quizkar.entities.Quiz;

public interface QuizDAO {
	// -- Get ALL Quizzes 
	public abstract List<Quiz> getQuizes() throws SQLException;
	
	// -- Get Quizzes Given by Specific User 
	public abstract List<GivenQuizesDTO> getQuizesGivenBySpecificUser(Integer userId) throws SQLException;
}
