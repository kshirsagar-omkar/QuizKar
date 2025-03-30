package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Question;

public interface QuestionService {
			
		
	//Add Single Question in specific quiz id
	public abstract Integer addQuestion(Question question) throws SQLException;
	
	
	
	
	
	//Get Questions for specific quiz_id
	public abstract List<Question> getQuestions(Integer quizId) throws SQLException;
	
}
