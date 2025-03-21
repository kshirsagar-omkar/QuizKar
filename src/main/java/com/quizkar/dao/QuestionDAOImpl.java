package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Question;
import com.quizkar.util.DBUtil;

public class QuestionDAOImpl implements QuestionDAO{

	public void addQuestions(List<Question> questions) throws SQLException
	{
		Connection connection = null;
		String query = "INSERT INTO question (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		try {
			connection = DBUtil.getConnection();
			connection.setAutoCommit(false);

			try(PreparedStatement ps = connection.prepareStatement(query))
			{
				for(Question question : questions) {
					
					ps.setInt(1, question.getQuizId());
					ps.setString(2, question.getQuestionText());
					ps.setString(3, question.getOptionA());
					ps.setString(4, question.getOptionB());
					ps.setString(5, question.getOptionC());
					ps.setString(6, question.getOptionD());
					ps.setString(7, question.getCorrectAnswer().toString());
					
					ps.addBatch();
				}
				
				ps.executeBatch();
				connection.commit();
				
			}
			catch(SQLException e) {
				
				if(connection != null) {
					connection.rollback();
				}
				throw e;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(connection != null) {
					connection.setAutoCommit(true);
					connection.close();
				}
			}
			catch(SQLException e) {
				e.printStackTrace();
				throw e;
			}
		}
	}
	
	
	
	
	
	
	
//	public static void main(String[] args) {
//
//	    Integer quizId = null;
//
//	    try {
//	        // STEP 1: Add Quiz
//	        QuizDAO quizDAO = new QuizDAOImpl();
//
//	        Quiz quiz = new Quiz();
//	        quiz.setTitle("Test Quiz");
//	        quiz.setCreatedBy(1); // Assuming user_id = 1 exists
//	        quiz.setTimeLimit(50);
//
//	        quizId = quizDAO.addQuiz(quiz); // This method should return generated quiz_id
//	        System.out.println("Inserted Quiz ID: " + quizId);
//	    } catch (SQLException e) {
//	        e.printStackTrace();
//	    }
//
//	    // STEP 2: Add Questions linked to quizId
//	    if (quizId != null) {
//	        try {
//	            QuestionDAO questionDAO = new QuestionDAOImpl();
//
//	            List<Question> questionList = new ArrayList<>();
//
//	            // Creating 5 custom questions
//	            Question q1 = new Question();
//	            q1.setQuizId(quizId);
//	            q1.setQuestionText("What is Java?");
//	            q1.setOptionA("A platform");
//	            q1.setOptionB("A programming language");
//	            q1.setOptionC("Both A and B");
//	            q1.setOptionD("None");
//	            q1.setCorrectAnswer('C');
//	            questionList.add(q1);
//
//	            Question q2 = new Question();
//	            q2.setQuizId(quizId);
//	            q2.setQuestionText("Which keyword is used to inherit a class in Java?");
//	            q2.setOptionA("extends");
//	            q2.setOptionB("implements");
//	            q2.setOptionC("inherits");
//	            q2.setOptionD("None");
//	            q2.setCorrectAnswer('A');
//	            questionList.add(q2);
//
//	            Question q3 = new Question();
//	            q3.setQuizId(quizId);
//	            q3.setQuestionText("Which company developed Java?");
//	            q3.setOptionA("Microsoft");
//	            q3.setOptionB("Sun Microsystems");
//	            q3.setOptionC("Apple");
//	            q3.setOptionD("Google");
//	            q3.setCorrectAnswer('B');
//	            questionList.add(q3);
//
//	            Question q4 = new Question();
//	            q4.setQuizId(quizId);
//	            q4.setQuestionText("Which method is the entry point in Java?");
//	            q4.setOptionA("start()");
//	            q4.setOptionB("main()");
//	            q4.setOptionC("run()");
//	            q4.setOptionD("init()");
//	            q4.setCorrectAnswer('B');
//	            questionList.add(q4);
//
//	            Question q5 = new Question();
//	            q5.setQuizId(quizId);
//	            q5.setQuestionText("Which of the following is not a Java feature?");
//	            q5.setOptionA("Object-oriented");
//	            q5.setOptionB("Portable");
//	            q5.setOptionC("Architecture Neutral");
//	            q5.setOptionD("Pointer Usage");
//	            q5.setCorrectAnswer('D');
//	            questionList.add(q5);
//
//	            // Add questions
//	            questionDAO.addQuestions(questionList);
//
//	            System.out.println("5 Questions inserted successfully!");
//
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	        }
//	    } else {
//	        System.out.println("Quiz not inserted, skipping question insertion.");
//	    }
//	}

}
