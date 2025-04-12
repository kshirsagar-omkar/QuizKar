package com.quizkar.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.quizkar.entities.Users;
import com.quizkar.service.UsersService;
import com.quizkar.service.impl.UsersServiceImpl;
import com.quizkar.util.SessionUtil;

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
		
		//User can enter Username Or EmailId
		String identifier = request.getParameter("identifier");
		String password = request.getParameter("password");		
		
		try{
			
			Users user = new Users();
			user.setEmail(identifier);
			user.setUserName(identifier);
			user.setPassword(password);
			
			UsersService usersService = new UsersServiceImpl();
			
			// if user is present then it gets all user data excluding password
			//validateUser checks plain password against, hashed password  
			user = usersService.validateUser(user);
			
			if( user != null ) {
				//Create user session
				SessionUtil.setUser(request, user);
				
				//And redirect to their dash-board
				SessionUtil.redirectToDashboard(request, response);
			}
			else {
				//set an error message in request object
				//redirect to login page again
				this.handleError("Invalid Login Credientials!", request, response);
			}
		
		}
		catch(SQLException sqlEx) {
			// set an error message to request
			// handle the exception and redirect to login page
			this.handleError(sqlEx.getMessage(), request, response);
		}
		
	}
	
	private void handleError(String errorMessage, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("error", errorMessage);
		request.getRequestDispatcher("pages/auth/login.jsp").forward(request, response);
	}


}
