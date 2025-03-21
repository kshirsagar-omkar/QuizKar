package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Question;

public interface QuestionDAO {
	
	//Add Questions in specific quiz id
	public abstract void addQuestions(List<Question> questions) throws SQLException;
}
