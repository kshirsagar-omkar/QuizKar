package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.entities.Question;

public interface QuestionService {
	
	
	//Add Single Question in specific quiz id
	public abstract Integer addQuestion(Question question) throws SQLException;
	
}
