package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.quizkar.constants.Role;
import com.quizkar.entities.StudyPlan;
import com.quizkar.entities.Users;
import com.quizkar.service.StudyPlanService;
import com.quizkar.service.impl.StudyPlanServiceImpl;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminStudyPlanServlet
 */
@WebServlet(name = "AdminStudyPlanServlet", value = "/AdminStudyPlanServlet")
public class AdminStudyPlanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		Users user = SessionUtil.getUser(request);

		//Check if user is admin, and he is logged in 
		if(user == null || ! user.getRole().equals(Role.ADMIN)) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
		
		request.getRequestDispatcher("pages/admin/addStudyPlan.jsp").forward(request, response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Users user = SessionUtil.getUser(request);

		//Check if user is admin, and he is logged in 
		if(user == null || ! user.getRole().equals(Role.ADMIN)) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String actionStatus = "failed";
		
		try {
			
			String action = request.getParameter("action");
			
			if(action.equals("delete")) {
				actionStatus = deleteStudyPlan(request, response);
			}
			
			else if(action.equals("edit")) {			
				actionStatus = editStudyPlan(request, response);
			}
			else if(action.equals("add")) {
				actionStatus = addStudyPlan(request, response);
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

	
	private String deleteStudyPlan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException
	{
		Integer studyPlanId = Integer.parseInt(request.getParameter("planId"));
		
		StudyPlanService studyPlanService = new StudyPlanServiceImpl();
		
		Integer rowsAffected = studyPlanService.deleteStudyPlanCreatedByAdmin(studyPlanId);
		
		if(rowsAffected > 0) {
			return "success";
		}
		
		return "failed";

	}
	
	
	private String editStudyPlan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NumberFormatException
	{
		StudyPlan studyPlan = new StudyPlan();
		
		studyPlan.setStudyPlanId( Integer.parseInt( request.getParameter("planId") ) );
		studyPlan.setName( request.getParameter("newName") );
		studyPlan.setLink( request.getParameter("newLink") );
		
		StudyPlanService studyPlanService = new StudyPlanServiceImpl();
		
		Integer rowsAffected = studyPlanService.updateStudyPlanCreatedByAdmin(studyPlan);
		
		if(rowsAffected > 0) {
			return "success";
		}
		
		return "failed";
	}
	
	
	
	private String addStudyPlan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NumberFormatException{
		StudyPlan studyPlan = new StudyPlan();
		
		studyPlan.setCreatedBy( Integer.parseInt(request.getParameter("createdById")) );
		studyPlan.setName( request.getParameter("studyPlanName") );
		studyPlan.setLink( request.getParameter("studyPlanLink") );
		
		StudyPlanService studyPlanService = new StudyPlanServiceImpl();
		
		Integer studyPlanId = studyPlanService.addStudyPlan(studyPlan);
		
		if(studyPlanId != null) {
			return "success";
		}
		
		return "failed";
	}
	
}
