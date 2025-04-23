package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.quizkar.entities.Users;
import com.quizkar.service.UsersService;
import com.quizkar.service.impl.UsersServiceImpl;
import com.quizkar.util.PasswordUtils;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="UserEditProfile", value="/UserEditProfile")
public class UserEditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.getRequestDispatcher("pages/user/editProfile.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String actionStatus = "failed";
		PrintWriter out = response.getWriter();
		
		
		try {
			String action = request.getParameter("action");
				
			if(action.equals("verify")) {
				actionStatus = verifyUser(request, response);
			}
			else if(action.equals("edit")) {
				actionStatus = editUser(request, response);
			}
			else if(action.equals("updatePassword")) {
				actionStatus = updatePasswordUser(request, response);
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
	
	
	private String verifyUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			UsersService usersService = new UsersServiceImpl();	
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			Users user = new Users();
			user.setUserName( username );
			user.setPassword(password);
			
			if( usersService.validateUser(user) != null ) {
				return "success";
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "failed";
		
	}
	
	
	
	private String editUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			UsersService usersService = new UsersServiceImpl();	
			
			Integer userId = Integer.parseInt( request.getParameter("userId") );
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			//Hash the password, before the Updating
			String securedPassword = PasswordUtils.generateSecurePassword(password);
			
			Users user = new Users();
			user.setUserId(userId);
			user.setUserName( username );
			user.setEmail(email);
			user.setPassword(securedPassword);
			
			Integer rowsAffected = usersService.updateUser(user);
			
			if( rowsAffected > 0 ) {
				Users u = SessionUtil.getUser(request);
				u.setUserName( username );
				u.setEmail(email);
				u.setPassword(securedPassword);
				SessionUtil.updateUser(request, u);
				
				return "success";

			}
		}
		catch(Exception e) {
			
			if(e.getMessage().endsWith("already exists.")) {
				return "alreadyTaken";
			}
			
			e.printStackTrace();
			return "failed";
		}
		return "failed";
		
	}
	
	
	
	
	private String updatePasswordUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		try {
			UsersService usersService = new UsersServiceImpl();	
			
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String requestFrom = request.getParameter("requestFrom"); // "forgotPassword" 
			boolean isEmailValid = true;
			
			//If the request is from the forgotPassword, then validate the email
			if(requestFrom != null && requestFrom.equals("forgotPassword")) {
				String verifiedEmail = SessionUtil.getVerifiedEmail(request);
				
				if(verifiedEmail == null || ! verifiedEmail.equals(email)) {
					isEmailValid = false;
				}
			}
			
			if(isEmailValid) {
				//Hash the password, before the Updating
				String securedPassword = PasswordUtils.generateSecurePassword(password);
				
				Users user = new Users();
				user.setEmail(email);
				user.setPassword(securedPassword);
				
				Integer rowsAffected = usersService.updatePassword(user);
				
				if( rowsAffected > 0 ) {
					//Clear verified email from session
					SessionUtil.removeVerifiedEmail(request);
					return "success";
				}				
			}
			else {
				//Clear verified email from session
				SessionUtil.removeVerifiedEmail(request);
				//For proper error message
				return "invalidEmail";
			}
			
			//Can remove verified email before if(isEmailVerifeid), but didn't do it in case of 'failed' 
		}
		catch(SQLException e) {
			e.printStackTrace();
			return "failed";
		}
		
		return "failed";
	}

	

}
