package com.quizkar.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.quizkar.dao.QuestionDAO;
import com.quizkar.dao.impl.QuestionDAOImpl;
import com.quizkar.entities.Question;
import com.quizkar.service.QuestionService;

public class QuestionServiceImpl implements QuestionService {	
	
	//Add Single Question in specific quiz id
	public Integer addQuestion(Question question) throws SQLException
	{
		QuestionDAO questionDAO = new QuestionDAOImpl();
		return questionDAO.addQuestion(question);
	}
	
	
	
	
	//Get Questions for specific quiz_id
	public List<Question> getQuestions(Integer quizId) throws SQLException
	{
		QuestionDAO questionDAO = new QuestionDAOImpl();
		return questionDAO.getQuestions(quizId);
	}
	
	
	
	//Get Answers for specific quiz_id Returns[ questionId, correctAnswer ]
	public Map<Integer,String> getAnswers(Integer quizId) throws SQLException{
		QuestionDAO questionDAO = new QuestionDAOImpl();
		return questionDAO.getAnswers(quizId);
	}
	
}
