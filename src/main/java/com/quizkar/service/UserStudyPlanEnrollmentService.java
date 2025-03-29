package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.entities.UserStudyPlanEnrollment;

public interface UserStudyPlanEnrollmentService {

	//Returns the Enrollment Id after enrollment is done successful else null/Exception
	public abstract Integer enrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException;
	
	//Returns the rowAffected
	public abstract Integer unEnrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException;
	
	//Returns the rowAffected after enrollment STATUS is updated else null/exception				//Status must be complete/not_complete
	public abstract Integer updateStatusOfStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment, String status) throws SQLException;
}
