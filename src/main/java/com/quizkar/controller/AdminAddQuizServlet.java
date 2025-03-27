package com.quizkar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.quizkar.entities.Question;
import com.quizkar.entities.Quiz;
import com.quizkar.service.QuestionService;
import com.quizkar.service.QuestionServiceImpl;
import com.quizkar.service.QuizService;
import com.quizkar.service.QuizServiceImpl;

/**
 * Servlet implementation class AdminAddQuizServlet
 */

@WebServlet(name = "AdminAddQuizServlet", value = "/AdminAddQuizServlet")
public class AdminAddQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("pages/admin/addQuiz.jsp").forward(request, response);
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String actionStatus = "failed";
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
			//Read JSON data from request body
			StringBuilder jsonData = new StringBuilder();
			String line;
			BufferedReader reader = request.getReader();
			
			while( (line = reader.readLine()) != null ) {
				jsonData.append(line);
			}
			
			
			//Parse JSON using Gson
			Gson gson = new Gson();
			JsonObject jsonObject = gson.fromJson( jsonData.toString() , JsonObject.class);
			
			
			//Checks the action is add or not
			if( !(jsonObject.get("action").getAsString().equals("add")) ) {
				actionStatus = "failed";
			}
			else {
				String title = jsonObject.get("title").getAsString();
				Integer timeLimit = jsonObject.get("timeLimit").getAsInt();
				Integer createdById = jsonObject.get("createdById").getAsInt();
				JsonArray questionsArray = jsonObject.getAsJsonArray("questions");
				
				
				//Service Layers Objects
				QuizService quizService = new QuizServiceImpl();
				QuestionService questionService = new QuestionServiceImpl();
				
				//Save Quiz
				Quiz quiz = new Quiz();
				quiz.setTitle(title);
				quiz.setTimeLimit(timeLimit);
				quiz.setCreatedBy(createdById);
				
				Integer quizId = quizService.addQuiz(quiz);
				
				//Save Questions
				
				for( JsonElement questionElement : questionsArray ) {
					Question question = gson.fromJson(questionElement, Question.class);
					question.setQuizId(quizId);
					questionService.addQuestion(question);
				}
				
				actionStatus = "success";
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			actionStatus = "failed";
		}
		
		out.println(actionStatus);
		
		
	}

}
