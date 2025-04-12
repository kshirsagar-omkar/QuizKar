package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;


@WebServlet(name="UserEditProfile", value="/UserEditProfile")
public class UserEditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Check if user is logged in 
		Users user = SessionUtil.getUser(request);
		if(user == null ) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
				
		request.getRequestDispatcher("pages/user/editProfile.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Check if user is logged in 
		Users user = SessionUtil.getUser(request);
		if(user == null ) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
		
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
	
	

}
