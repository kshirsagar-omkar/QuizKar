package com.quizkar.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.quizkar.constants.Role;
import com.quizkar.entities.Quiz;
import com.quizkar.entities.StudyPlan;
import com.quizkar.entities.Users;
import com.quizkar.service.QuizService;
import com.quizkar.service.StudyPlanService;
import com.quizkar.service.UsersService;
import com.quizkar.service.impl.QuizServiceImpl;
import com.quizkar.service.impl.StudyPlanServiceImpl;
import com.quizkar.service.impl.UsersServiceImpl;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminDashboard
 */
@WebServlet(name ="admindashboard", value = "/admindashboard")
public class AdminDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.getRequestDispatcher("pages/admin/dashboard.jsp").forward(request, response);
		
		List<StudyPlan> studyPlans = null;
		List<Quiz> quizzes = null;
		Integer userCount = 0;
		
		try {			
			StudyPlanService studyPlanService = new StudyPlanServiceImpl();
			QuizService quizService = new QuizServiceImpl();
			UsersService usersService = new UsersServiceImpl();
			
			Users user = SessionUtil.getUser(request);
			
			//If user is null or user is not admin, then logout them 
			if(user == null || ! user.getRole().equals(Role.ADMIN)) {
				response.sendRedirect( request.getContextPath() + "/LogoutServlet");
				return;
			}
			
			if(user != null) {
				
				Integer userId = user.getUserId();
				
				//Get study plans created by admin
				studyPlans = studyPlanService.getStudyPlanCreatedByAdmin( userId );
				request.setAttribute("studyPlans", studyPlans);
				
				
				//get quizes created by admin
				quizzes = quizService.getQuizCreatedByAdmin(userId);
				request.setAttribute("quizzes", quizzes);
				
				userCount = usersService.getTotalUsers();
				request.setAttribute("userCount", userCount);
				
			}
			
			
			request.getRequestDispatcher("pages/admin/dashboard.jsp").forward(request, response);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
