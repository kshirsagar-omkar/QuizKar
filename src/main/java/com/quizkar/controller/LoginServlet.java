package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.quizkar.entities.Users;
import com.quizkar.service.UsersService;
import com.quizkar.service.UsersServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Send request to doPost
		request.getRequestDispatcher("pages/auth/login.jsp").forward(request, response);
	}
	
	
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String role = request.getParameter("role");
		//User can enter Username Or EmailId
		String identifier = request.getParameter("identifier");
		String password = request.getParameter("password");
		
		
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
				
		
		
		try{
			
			Users user = new Users();
			user.setRole(role);
			user.setEmail(identifier);
			user.setUserName(identifier);
			user.setPassword(password);
			
			UsersService usersService = new UsersServiceImpl();
			
			Integer userId = usersService.validateUser(user);
			
			if( userId != null ) {
				//create session object that stores User's Object all info excluding password
				//redirect to user's/admin's dash board
				out.println("success");
			}
			else {
				//set an error message in request object
				//redirect to login page again
				this.handleError("Invalid Login Credientials!", request, response);
//				out.println("failed");
			}
		
		}
		catch(SQLException sqlEx) {
			// set an error message to request
			// handle the exception and redirect to login page
			this.handleError(sqlEx.getMessage(), request, response);
//			out.println("failed");
		}
		
	}
	
	private void handleError(String errorMessage, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("error", errorMessage);
		request.getRequestDispatcher("pages/auth/login.jsp").forward(request, response);
	}

}
