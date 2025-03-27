package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.entities.UserStudyPlanEnrollment;

public interface UserStudyPlanEnrollmentService {

	
	
	
	
	//Returns the rowAffected after enrollment STATUS is updated else null/exception				//Status must be complete/not_complete
	public abstract Integer updateStatusOfStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment, String status) throws SQLException;
}
