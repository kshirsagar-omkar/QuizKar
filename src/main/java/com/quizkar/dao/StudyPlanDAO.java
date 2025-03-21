package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.StudyPlan;

public interface StudyPlanDAO {
	
	// Get All Study Plans
	public abstract List<StudyPlan> getStudyPlans() throws SQLException;
	
	// Get Study Plans Enrolled by Specific User
	public abstract List<StudyPlan> getSpecificUserStudyPlans(Integer userId) throws SQLException;
	
	
	
	//Add Study Plan
	public abstract Integer addStudyPlan(StudyPlan studyPlan) throws SQLException;
}
