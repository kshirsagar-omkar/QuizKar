package com.quizkar.controller;

import java.io.IOException;
import java.util.List;

import com.quizkar.entities.Quiz;
import com.quizkar.entities.Users;
import com.quizkar.service.QuizService;
import com.quizkar.service.impl.QuizServiceImpl;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "UserQuizzes", value = "/UserQuizzes")
public class UserQuizzes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//Check if user is logged in 
		Users user = SessionUtil.getUser(request);
		if(user == null ) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}

		try {
			QuizService quizService = new QuizServiceImpl();
			List<Quiz> quizzes = quizService.getQuizes();
			request.setAttribute("quizzes", quizzes);

		}
		catch(Exception e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("pages/user/quizzes.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}
