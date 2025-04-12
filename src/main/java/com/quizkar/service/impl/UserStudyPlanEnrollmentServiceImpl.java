package com.quizkar.service.impl;

import java.sql.SQLException;

import com.quizkar.dao.UserStudyPlanEnrollmentDAO;
import com.quizkar.dao.impl.UserStudyPlanEnrollmentDAOImpl;
import com.quizkar.entities.UserStudyPlanEnrollment;
import com.quizkar.service.UserStudyPlanEnrollmentService;

public class UserStudyPlanEnrollmentServiceImpl implements UserStudyPlanEnrollmentService {

	//Returns the Enrollment Id after enrollment is done successful else null/Exception
	public Integer enrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException
	{
		UserStudyPlanEnrollmentDAO userStudyPlanEnrollmentDAO = new UserStudyPlanEnrollmentDAOImpl();
		
		return userStudyPlanEnrollmentDAO.enrollStudyPlan(userStudyPlanEnrollment);
		
	}
	
	
	//Returns the rowAffected
	public Integer unEnrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException
	{
		UserStudyPlanEnrollmentDAO userStudyPlanEnrollmentDAO = new UserStudyPlanEnrollmentDAOImpl();
		
		return userStudyPlanEnrollmentDAO.unEnrollStudyPlan(userStudyPlanEnrollment);

	}
	
	//Returns the rowAffected after enrollment STATUS is updated else null/exception				//Status must be complete/not_complete
	public Integer updateStatusOfStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment, String status) throws SQLException
	{
		UserStudyPlanEnrollmentDAO userStudyPlanEnrollmentDAO = new UserStudyPlanEnrollmentDAOImpl();
		
		return userStudyPlanEnrollmentDAO.updateStatusOfStudyPlan(userStudyPlanEnrollment, status);
	}
}
