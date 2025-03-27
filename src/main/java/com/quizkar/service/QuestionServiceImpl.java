package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.dao.QuestionDAO;
import com.quizkar.dao.QuestionDAOImpl;
import com.quizkar.entities.Question;

public class QuestionServiceImpl implements QuestionService {
	
	
	//Add Single Question in specific quiz id
	public Integer addQuestion(Question question) throws SQLException
	{
		QuestionDAO questionDAO = new QuestionDAOImpl();
		return questionDAO.addQuestion(question);
	}
	
}
