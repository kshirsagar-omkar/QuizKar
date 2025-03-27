package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.StudyPlan;

public interface StudyPlanService {
	
	
	
	
	
	
	
	
	//Add Study Plan return null/ or inserted plan id
	public abstract Integer addStudyPlan(StudyPlan studyPlan) throws SQLException;
	
	// -- Get StudyPlan Created by admin
	public abstract List<StudyPlan> getStudyPlanCreatedByAdmin(Integer userId) throws SQLException;
	
	// -- Delete StudyPlan Created by admin RETURN RowAffected
	public abstract Integer deleteStudyPlanCreatedByAdmin(Integer studyPlanId) throws SQLException;
	
	
	// -- Update StudyPlan Created by admin RETURN RowAffected
	public abstract Integer updateStudyPlanCreatedByAdmin(StudyPlan studyPlan) throws SQLException;
}
