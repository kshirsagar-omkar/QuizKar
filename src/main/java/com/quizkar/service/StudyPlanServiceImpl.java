package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dao.StudyPlanDAO;
import com.quizkar.dao.StudyPlanDAOImpl;
import com.quizkar.entities.StudyPlan;

public class StudyPlanServiceImpl implements StudyPlanService{

	
	
	
	
	
	
	
	
	
	
	
	
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
