package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.quizkar.entities.Quiz;
import com.quizkar.service.QuizService;
import com.quizkar.service.impl.QuizServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminQuizServlet
 */
@WebServlet(name = "AdminQuizServlet", value = "/AdminQuizServlet")
public class AdminQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String actionStatus = "failed";
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
			
			String action = request.getParameter("action");
			
			if( action.equals("delete") ) {
				actionStatus = deleteQuiz(request, response);
			}
			else if( action.equals("edit") ) {
				actionStatus = editQuiz(request, response);
			}
			
			out.println(actionStatus);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			out.println(actionStatus);
		}
		finally {
			out.close();
		}
		
	}

	
	private String deleteQuiz(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NumberFormatException {
		QuizService quizService = new QuizServiceImpl();
		
		Integer quizId = Integer.parseInt( request.getParameter("quizId") );
		
		Integer rowsAffected = quizService.DeleteQuizCreatedByAdmin(quizId);
		
		if(rowsAffected > 0) {
			return "success";
		}
		return "failed";
	}
	
	
	
	private String editQuiz(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NumberFormatException {
		QuizService quizService = new QuizServiceImpl();
		
		Quiz quiz = new Quiz();
		
		
		quiz.setQuizId( Integer.parseInt( request.getParameter("quizId") ) );
		quiz.setTitle( request.getParameter("newTitle") );
		quiz.setTimeLimit( Integer.parseInt( request.getParameter("newTime") ) );
		
		
		
		Integer rowsAffected = quizService.updateQuizCreatedByAdmin(quiz);
		
		if(rowsAffected > 0) {
			return "success";
		}
		return "failed";
	}
	
}
