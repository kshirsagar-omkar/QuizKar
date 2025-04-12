package com.quizkar.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.quizkar.entities.Question;
import com.quizkar.entities.Quiz;
import com.quizkar.service.QuestionService;
import com.quizkar.service.impl.QuestionServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="UserStartQuiz", value="/UserStartQuiz")
public class UserStartQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.sendRedirect("UserQuizzes");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			Integer quizId = Integer.parseInt( request.getParameter("quizId") );
			String title = request.getParameter("quizTitle");
			Integer timeLimit = Integer.parseInt(request.getParameter("quizTimeLimit"));

			Quiz quiz = new Quiz();
			quiz.setQuizId(quizId);
			quiz.setTitle(title);
			quiz.setTimeLimit(timeLimit);

			QuestionService questionService = new QuestionServiceImpl();
			List<Question> questions = questionService.getQuestions(quiz.getQuizId());
			Collections.shuffle(questions);

			request.setAttribute("questions", questions);
			request.setAttribute("quiz", quiz);

		}
		catch(Exception e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("pages/user/quizQuestions.jsp").forward(request, response);

	}

}
