package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.dao.UserStudyPlanEnrollmentDAO;
import com.quizkar.dao.UserStudyPlanEnrollmentDAOImpl;
import com.quizkar.entities.UserStudyPlanEnrollment;

public class UserStudyPlanEnrollmentServiceImpl implements UserStudyPlanEnrollmentService {

	
	
	
	
	//Returns the rowAffected after enrollment STATUS is updated else null/exception				//Status must be complete/not_complete
	public Integer updateStatusOfStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment, String status) throws SQLException
	{
		UserStudyPlanEnrollmentDAO userStudyPlanEnrollmentDAO = new UserStudyPlanEnrollmentDAOImpl();
		
		return userStudyPlanEnrollmentDAO.updateStatusOfStudyPlan(userStudyPlanEnrollment, status);
	}
}
