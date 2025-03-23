package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.entities.StudyPlan;
import com.quizkar.util.DBUtil;

public class StudyPlanDAOImpl implements StudyPlanDAO{
		
	
	// Get All Study Plans
	public List<StudyPlan> getStudyPlans() throws SQLException
	{	
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT studyplan_id, name, created_at, created_by FROM study_plan";
		
		
		try (Connection connection = DBUtil.getConnection();
			 Statement  statement  = connection.createStatement();
			 ResultSet	resultSet  = statement.executeQuery(query) ) {
			
			while(resultSet.next()) {
				
				StudyPlan studyPlan = new StudyPlan();
				
				studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
				studyPlan.setName( resultSet.getString("name") );
				
				//2025-03-20 17:26:45.918626 -> 2025-03-20 17:26:45
				studyPlan.setCreatedAt( (resultSet.getString("created_at")).split("\\.")[0] );	
				studyPlan.setCreatedBy( resultSet.getInt("created_by") );
				
				studyPlans.add(studyPlan);	
			}
		}	
		return studyPlans.isEmpty() ? null : studyPlans;
	}
	
	
	
	
	
	// Get Study Plans Enrolled by Specific User
	public List<StudyPlan> getSpecificUserStudyPlans(Integer userId) throws SQLException
	{
		
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT sp.studyplan_id, sp.name, sp.status, sp.created_at, created_by FROM study_plan sp JOIN user_studyplan_enrollment use ON sp.studyplan_id = use.studyplan_id WHERE use.user_id = ?";
		
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
			
			preparedStatement.setInt(1, userId);
			
			try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
				
				while(resultSet.next()) {
					
					StudyPlan studyPlan = new StudyPlan();
					
					studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
					studyPlan.setName( resultSet.getString("name") );
					studyPlan.setStatus( resultSet.getString("status") );					
					//2025-03-20 17:26:45.918626 -> 2025-03-20 17:26:45
					studyPlan.setCreatedAt( (resultSet.getString("created_at")).split("\\.")[0] );	
					studyPlan.setCreatedBy( resultSet.getInt("created_by") );
					
					studyPlans.add(studyPlan);	
				}
			}	
		}	
		return studyPlans.isEmpty() ? null : studyPlans;
	}
	
	
	
	
	
	
	
	public Integer addStudyPlan(StudyPlan studyPlan) throws SQLException
	{
		String query = "INSERT INTO study_plan (name, created_by) VALUES (?, ?) RETURNING studyplan_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setString(1, studyPlan.getName());
		    preparedStatement.setInt(2, studyPlan.getCreatedBy());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        generatedId = resultSet.getInt("studyplan_id");
//		        System.out.println("Inserted User ID: " + generatedId);
		    }
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
	}
	
	
	
	
	
//	public static void main(String[] args) {
//	    try {
//	    	StudyPlanDAO sd = new StudyPlanDAOImpl();
//	
//	    	List<StudyPlan> l = sd.getSpecificUserStudyPlans(2);
//	    	
//	    	for(var sp : l) {
//	    		display(sp);
//	    	}
//	
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}
//	
//	
//	
//	private static void display(StudyPlan sp)
//	{
//		System.out.println( sp.getStudyPlanId() );
//		System.out.println( sp.getName() );
//		System.out.println( sp.getStatus() );
//		System.out.println( sp.getCreatedAt() );
//		System.out.println( sp.getCreatedBy() + "\n");
//	}
	
}

