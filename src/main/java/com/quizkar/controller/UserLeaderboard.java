package com.quizkar.controller;

import java.io.IOException;
import java.util.List;

import com.quizkar.dto.GlobalLeaderBoardDTO;
import com.quizkar.service.LeaderBoardService;
import com.quizkar.service.LeaderBoardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserLeaderboard
 */
@WebServlet(name="UserLeaderboard", value="/UserLeaderboard")
public class UserLeaderboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String filter = null;
			String btnValue = request.getParameter("btn");
			
			if(btnValue != null && !btnValue.isEmpty()) {
				if( btnValue.equals("search") ) {
					filter = request.getParameter("filter");
				}
				else if( btnValue.equals("refresh") ) {
					response.sendRedirect("UserLeaderboard");
				}
			}
			
			LeaderBoardService leaderBoardService = new LeaderBoardServiceImpl();
			
			List<GlobalLeaderBoardDTO> leaderboard = leaderBoardService.getLeaderBoard(filter);
			
			request.setAttribute("leaderboard", leaderboard);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("./pages/user/leaderboard.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
