package com.quizkar.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import org.json.JSONObject;

import com.quizkar.entities.LeaderBoard;
import com.quizkar.entities.Users;
import com.quizkar.service.LeaderBoardService;
import com.quizkar.service.QuestionService;
import com.quizkar.service.impl.LeaderBoardServiceImpl;
import com.quizkar.service.impl.QuestionServiceImpl;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="UserSubmitQuiz", value="/UserSubmitQuiz")
public class UserSubmitQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Check if user is logged in 
		Users user = SessionUtil.getUser(request);
		if(user == null ) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
		
		response.sendRedirect("UserQuizzes");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Check if user is logged in 
		Users user = SessionUtil.getUser(request);
		if(user == null ) {
			response.sendRedirect( request.getContextPath() + "/LogoutServlet");
			return;
		}
		
		PrintWriter out = response.getWriter();
		String actionStatus = "failed";
		
		try {
			
			// Read JSON from request body
			StringBuilder jsonString= new StringBuilder();
			String line;
			BufferedReader reader = request.getReader();
			while( (line = reader.readLine()) != null ) {
				jsonString.append(line);
			}
			
			
			// Convert JSON string to object
			JSONObject jsonData = new JSONObject( jsonString.toString() );
		
			Integer userId = jsonData.getInt("userId");
			Integer quizId = jsonData.getInt("quizId");
			Integer timeTaken = jsonData.getInt("timeTaken");
			
			//Get answers in key pair value [questionId, answer (selected one) ]
			JSONObject answersJSON = jsonData.getJSONObject("answers");
			
			Integer score = 0;

			LeaderBoard leaderBoard = new LeaderBoard();
			
			leaderBoard.setUserId(userId);
			leaderBoard.setQuizId(quizId);
			leaderBoard.setTimeTaken(timeTaken);
			
			
			//Calculate score here
			QuestionService questionService = new QuestionServiceImpl();
			
			//get answers from db
			Map<Integer, String> answers = questionService.getAnswers(leaderBoard.getQuizId());
			
			for(String key : answersJSON.keySet()) {

				Integer questionId = Integer.parseInt(key);
				String selectedOption = answersJSON.getString(key);

				if( answers.get(questionId).equals(selectedOption) ) {
					++score;
				}
			}
			leaderBoard.setScore(score*5);
			
			//Check here if the user has already given a same quiz the insted of adding record Update the record
			LeaderBoardService leaderBoardService = new LeaderBoardServiceImpl();
			
			//returns true if record already present THERFORE Update the record
			if( leaderBoardService.checkIfRecordExistsInLeaderBoard(leaderBoard) ) {
				
				if(leaderBoardService.updateLeaderBoard(leaderBoard) > 0) {
					actionStatus = "success";
				}
				
			} else {
				if(leaderBoardService.addLeaderBoard(leaderBoard) != null) {
					actionStatus = "success";
				}
			}
	
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			out.println(actionStatus);
			out.close();
		}
		
	}
	

	
	
	
	
	
//	private void sendMsg(String msg, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setAttribute("msg", msg);
//		request.getRequestDispatcher("UserQuizzes").forward(request, response);
//	}

}
