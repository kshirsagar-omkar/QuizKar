package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.quizkar.entities.UserStudyPlanEnrollment;
import com.quizkar.service.UserStudyPlanEnrollmentService;
import com.quizkar.service.UserStudyPlanEnrollmentServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="UserStudyPlanServlet", value="/UserStudyPlanServlet")
public class UserStudyPlanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("pages/user/studyPlans.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String actionStatus = "failed";
		
		try {
			
			String action = request.getParameter("action");
			
			if(action.equals("updateStudyPlanStatus")) {
				actionStatus = updateStudyPlanStatus(request, response);
			}		
			
			out.println(actionStatus);
		}
		catch(Exception e) {
			out.println(actionStatus);
			e.printStackTrace();
		}
		finally {
			out.close();
		}
		
	}

	
	private String updateStudyPlanStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		try {
			
			Integer userId = Integer.parseInt( request.getParameter("userId") );
			Integer studyPlanId = Integer.parseInt( request.getParameter("planId") );
			String status = request.getParameter("updatedStatus");
			
			UserStudyPlanEnrollment userStudyPlanEnrollment = new UserStudyPlanEnrollment();
			userStudyPlanEnrollment.setUserId(userId);
			userStudyPlanEnrollment.setStudyPlanId(studyPlanId);
			
			
			UserStudyPlanEnrollmentService userStudyPlanEnrollmentService = new UserStudyPlanEnrollmentServiceImpl();
			
			Integer rowAffected = userStudyPlanEnrollmentService.updateStatusOfStudyPlan(userStudyPlanEnrollment, status);
			
			if(rowAffected > 0) {
				return "success";
			}
			
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
		}
		return "failed";
	}
	
}
