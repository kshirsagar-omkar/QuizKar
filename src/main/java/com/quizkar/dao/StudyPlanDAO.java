package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.StudyPlan;

public interface StudyPlanDAO {
	
	// Get All Study Plans
	public abstract List<StudyPlan> getStudyPlans() throws SQLException;
	
	// Get Study Plans Enrolled by Specific User
	public abstract List<StudyPlan> getSpecificUserStudyPlans(Integer userId) throws SQLException;
	
	//Get Completed Study Plans Enrolled by Specific User
	public abstract List<StudyPlan> getSpecificUserStudyPlansCompleted(Integer userId) throws SQLException;
	
	//Get NOT Completed Study Plans Enrolled by Specific User
	public abstract List<StudyPlan> getSpecificUserStudyPlansNotCompleted(Integer userId) throws SQLException;
	
	//Add Study Plan
	public abstract Integer addStudyPlan(StudyPlan studyPlan) throws SQLException;
	
	
	// -- Get StudyPlan Created by admin
	public abstract List<StudyPlan> getStudyPlanCreatedByAdmin(Integer userId) throws SQLException;
	
	// -- Delete StudyPlan Created by admin RETURN RowAffected
	public abstract Integer deleteStudyPlanCreatedByAdmin(Integer studyPlanId) throws SQLException;
	
	// -- Update StudyPlan Created by admin RETURN RowAffected
	public abstract Integer updateStudyPlanCreatedByAdmin(StudyPlan studyPlan) throws SQLException;
}
