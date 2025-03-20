package com.quizkar.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.entities.StudyPlan;
import com.quizkar.util.DBUtil;

public class StudyPalanDaoImpl implements StudyPlanDao{
		
	
	// Get All Study Plans
	public List<StudyPlan> getStudyPlans() throws SQLException
	{	
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT studyplan_id, name, created_at FROM study_plan";
		
		
		try (Connection connection = DBUtil.getConnection();
			 Statement  statement  = connection.createStatement();
			 ResultSet	resultSet  = statement.executeQuery(query) ) {
			
			while(resultSet.next()) {
				
				StudyPlan studyPlan = new StudyPlan();
				
				studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
				studyPlan.setName( resultSet.getString("name") );
				
				//2025-03-20 17:26:45.918626 -> 2025-03-20 17:26:45
				studyPlan.setCreatedAt( (resultSet.getString("created_at")).split("\\.")[0] );	
				
				studyPlans.add(studyPlan);	
			}
		}	
		return studyPlans.isEmpty() ? null : studyPlans;
	}
	
	
	
	
	
	
//	public static void main(String[] args) throws SQLException{
//		
//		StudyPlanDao spd = new StudyPalanDaoImpl();
//		
//		
//		List<StudyPlan> studyPlans = spd.getStudyPlans();
//		
//		if(studyPlans != null) {
//			for(var sp : studyPlans) {
//				System.out.println( sp.getStudyPlanId() + " " + sp.getName() + " " + sp.getCreatedAt());
//			}
//		}
//		System.out.println("Hello");
//	}
	
}

