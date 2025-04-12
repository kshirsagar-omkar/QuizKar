package com.quizkar.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.quizkar.entities.Users;
import com.quizkar.service.UsersService;
import com.quizkar.service.impl.UsersServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "register", value = "/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("pages/auth/register.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		
		try {
			Users user = new Users();
			user.setRole(role);
			user.setEmail(email);
			user.setUserName(username);
			user.setPassword(password);
			
			UsersService usersService = new UsersServiceImpl();
			
			// Check is user already exists in database
			if(usersService.getUser(user) != null) {
				this.handleError("username or email already exists!", request, response);
				return;
			}
			
			//addUser(Users), internally makes the password, secured, it hashes the password 
			Integer userId = usersService.addUser(user);
			
			if( userId != null ) {
				//create session object that stores User's Object all info excluding password
				//redirect to login page
				
				//Update the user count in database
				try {
					usersService.updateTotalUser();
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				
				response.sendRedirect("login?registered=true");

			}
			else {
				// set an error message to request
				// handle the exception and redirect to register page
				this.handleError("Unable to register", request, response);
			}
		}
		catch(SQLException sqlEx){
			this.handleError(sqlEx.getMessage(), request, response);			
			// out.println("failed");
		}
		
	}

	
	private void handleError(String errorMessage, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("error", errorMessage);
		request.getRequestDispatcher("pages/auth/register.jsp").forward(request, response);
	}
	
}
