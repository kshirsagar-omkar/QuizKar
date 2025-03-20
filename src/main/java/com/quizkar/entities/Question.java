package com.quizkar.entities;

public class Question {
	//@Id
	private Integer questionId;
	
	//@Columns
	private Integer quizId; // Reference com.quizkar.entities -> Quiz.quizId
	private String questionText;
	private String optionA;
	private String optionB;
	private String optionC;
	private String optionD;
	private Character correctAnswer;
	
	
	
	
	
	public Integer getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}
	public Integer getQuizId() {
		return quizId;
	}
	public void setQuizId(Integer quizId) {
		this.quizId = quizId;
	}
	public String getQuestionText() {
		return questionText;
	}
	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}
	public String getOptionA() {
		return optionA;
	}
	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}
	public String getOptionB() {
		return optionB;
	}
	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}
	public String getOptionC() {
		return optionC;
	}
	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}
	public String getOptionD() {
		return optionD;
	}
	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}
	public Character getCorrectAnswer() {
		return correctAnswer;
	}
	public void setCorrectAnswer(Character correctAnswer) {
		this.correctAnswer = correctAnswer;
	}
	
	
	
}
