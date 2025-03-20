package com.quizkar.entities;

public class UserStudyPlanEnrollment {
	//@Id
	private Integer enrollmentId;
	
	//@Columns
	private Integer userId; 		//Reference com.quizkar.entities -> Users.userId
	private Integer studyPlanId; 	// Reference com.quizkar.entities -> StudyPlan.studyPlanId
	private String enrolledAt; 		//Date
	
	
	
	
	public Integer getEnrollmentId() {
		return enrollmentId;
	}
	public void setEnrollmentId(Integer enrollmentId) {
		this.enrollmentId = enrollmentId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getStudyPlanId() {
		return studyPlanId;
	}
	public void setStudyPlanId(Integer studyPlanId) {
		this.studyPlanId = studyPlanId;
	}
	public String getEnrolledAt() {
		return enrolledAt;
	}
	public void setEnrolledAt(String enrolledAt) {
		this.enrolledAt = enrolledAt;
	}
	
}
