package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Question;

public interface QuestionDAO {
	
	//Add Questions in specific quiz id
	public abstract void addQuestions(List<Question> questions) throws SQLException;
	
	//Get Questions for specific quiz_id
	public abstract List<Question> getQuestions(Integer quizId) throws SQLException;
	
	
	//Get Answers for specific quiz_id
	public abstract List<String> getAnswers(Integer quizId) throws SQLException;
}
