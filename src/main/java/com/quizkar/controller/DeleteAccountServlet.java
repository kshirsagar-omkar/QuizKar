package com.quizkar.controller;

import java.io.IOException;

import com.quizkar.service.UsersService;
import com.quizkar.service.impl.UsersServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="DeleteAccountServlet", value="/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.getRequestDispatcher("./pages/user/settings.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			Integer userId = Integer.parseInt( request.getParameter("userId") );
			
			UsersService usersService = new UsersServiceImpl();
			
			Integer rowAffected = usersService.deleteUser(userId);
			
			if(rowAffected > 0) {
				response.sendRedirect("LogoutServlet");
				return;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Unable to Delete Account!!");
			request.getRequestDispatcher("DeleteAccountServlet").forward(request, response);
		}
	}

}
