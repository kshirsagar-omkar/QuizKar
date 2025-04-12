package com.quizkar.service.impl;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dao.StudyPlanDAO;
import com.quizkar.dao.impl.StudyPlanDAOImpl;
import com.quizkar.entities.StudyPlan;
import com.quizkar.service.StudyPlanService;

public class StudyPlanServiceImpl implements StudyPlanService{

	
	
	// Get All Study Plans
	public List<StudyPlan> getStudyPlans() throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		return studyPlanDAO.getStudyPlans();
	}
	
	
	
	
	//Get Completed Study Plans Enrolled by Specific User
	public List<StudyPlan> getSpecificUserStudyPlansCompleted(Integer userId) throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.getSpecificUserStudyPlansCompleted(userId);

	}
	
	
	//Get NOT Completed Study Plans Enrolled by Specific User
	public List<StudyPlan> getSpecificUserStudyPlansNotCompleted(Integer userId) throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.getSpecificUserStudyPlansNotCompleted(userId);
	}
	
	
	//Add Study Plan
	public Integer addStudyPlan(StudyPlan studyPlan) throws SQLException{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.addStudyPlan(studyPlan);
	}
	
	
	
	
	
	// -- Get StudyPlan Created by admin
	public List<StudyPlan> getStudyPlanCreatedByAdmin(Integer userId) throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.getStudyPlanCreatedByAdmin(userId);
	}
	
	
	
	
	
	// -- Delete StudyPlan Created by admin RETURN RowAffected
	public Integer deleteStudyPlanCreatedByAdmin(Integer studyPlanId) throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.deleteStudyPlanCreatedByAdmin(studyPlanId);
	}
	
	
	
	// -- Update StudyPlan Created by admin RETURN RowAffected
	public Integer updateStudyPlanCreatedByAdmin(StudyPlan studyPlan) throws SQLException
	{
		StudyPlanDAO studyPlanDAO = new StudyPlanDAOImpl();
		
		return studyPlanDAO.updateStudyPlanCreatedByAdmin(studyPlan);
	}
	
	
	
}
