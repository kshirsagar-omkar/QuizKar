package com.quizkar.controller;

import java.io.IOException;
import java.util.List;

import com.quizkar.dto.GivenQuizesDTO;
import com.quizkar.entities.StudyPlan;
import com.quizkar.entities.Users;
import com.quizkar.service.QuizService;
import com.quizkar.service.QuizServiceImpl;
import com.quizkar.service.StudyPlanService;
import com.quizkar.service.StudyPlanServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UserDashboard", value = "/UserDashboard")
public class UserDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		List<StudyPlan> ongoingStudyPlans = null;
		List<StudyPlan> completedStudyPlans = null;
		List<GivenQuizesDTO> completedQuizzes = null;
		
		
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			response.sendRedirect("login");
	        return;
		}
		
		Users user = (Users) session.getAttribute("user");
		
		
		try {
			
			StudyPlanService studyPlanService = new StudyPlanServiceImpl();
			QuizService quizService = new QuizServiceImpl();
			
			
			//Get List Form database
			ongoingStudyPlans = studyPlanService.getSpecificUserStudyPlansNotCompleted( user.getUserId() );
			completedStudyPlans = studyPlanService.getSpecificUserStudyPlansCompleted( user.getUserId() );
			
			completedQuizzes = quizService.getQuizesGivenBySpecificUser( user.getUserId() );
			
			
			//Set List to request for accessing in dash board
			request.setAttribute("ongoingStudyPlans", ongoingStudyPlans);
			request.setAttribute("completedStudyPlans", completedStudyPlans);
			request.setAttribute("completedQuizzes", completedQuizzes);
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		request.getRequestDispatcher("pages/user/dashboard.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
