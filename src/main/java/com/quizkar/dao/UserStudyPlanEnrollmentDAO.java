package com.quizkar.dao;

import java.sql.SQLException;

import com.quizkar.entities.UserStudyPlanEnrollment;

public interface UserStudyPlanEnrollmentDAO {
	
	//Returns the Enrollment Id after enrollment is done successful else null/Exception
	public abstract Integer enrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException;
}
