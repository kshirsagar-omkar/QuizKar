package com.quizkar.service.impl;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dao.QuizDAO;
import com.quizkar.dao.impl.QuizDAOImpl;
import com.quizkar.dto.GivenQuizesDTO;
import com.quizkar.entities.Quiz;
import com.quizkar.service.QuizService;

public class QuizServiceImpl implements QuizService{

	
	
	// -- Get ALL Quizzes 
	public List<Quiz> getQuizes() throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		return quizDAO .getQuizes();
	}
	
	
	// -- Get Quizzes Given by Specific User 
	public List<GivenQuizesDTO> getQuizesGivenBySpecificUser(Integer userId) throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		
		return quizDAO.getQuizesGivenBySpecificUser(userId);
	}
	
	
	// -- Add Quiz returns the inserted quiz id
	public Integer addQuiz(Quiz quiz) throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		
		return quizDAO.addQuiz(quiz);
	}
	
	
	
	
	// -- Get Quiz Created by admin
	public List<Quiz> getQuizCreatedByAdmin(Integer userId) throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		
		return quizDAO.getQuizCreatedByAdmin(userId);
		
	}
	
	
	
	// -- Delete Quiz Created by admin RETURN RowAffected
	public Integer DeleteQuizCreatedByAdmin(Integer quizId) throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		
		return quizDAO.DeleteQuizCreatedByAdmin(quizId);
	}
	
	
	
	// -- Update Quiz Created by admin RETURN RowAffected
	public Integer updateQuizCreatedByAdmin(Quiz quiz) throws SQLException
	{
		QuizDAO quizDAO = new QuizDAOImpl();
		
		return quizDAO.updateQuizCreatedByAdmin(quiz);

	}
}
