package com.quizkar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.quizkar.dao.StudyPlanDAO;
import com.quizkar.entities.StudyPlan;
import com.quizkar.util.DBUtil;

public class StudyPlanDAOImpl implements StudyPlanDAO{
		
	
	// Get All Study Plans
	public List<StudyPlan> getStudyPlans() throws SQLException
	{	
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT studyplan_id, name, link, created_at, created_by FROM study_plan";
		
		
		try (Connection connection = DBUtil.getConnection();
			 Statement  statement  = connection.createStatement();
			 ResultSet	resultSet  = statement.executeQuery(query) ) {
			
			while(resultSet.next()) {
				
				StudyPlan studyPlan = new StudyPlan();
				
				studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
				studyPlan.setName( resultSet.getString("name") );
				studyPlan.setLink( resultSet.getString("link") );
//				studyPlan.setEnrollStatus( resultSet.getString("enrollStatus") );
				
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
		
		final String query = "SELECT sp.studyplan_id, sp.name, sp.link, sp.status, sp.created_at, created_by FROM study_plan sp JOIN user_studyplan_enrollment use ON sp.studyplan_id = use.studyplan_id WHERE use.user_id = ?";
		
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
			
			preparedStatement.setInt(1, userId);
			
			try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
				
				while(resultSet.next()) {
					
					StudyPlan studyPlan = new StudyPlan();
					
					studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
					studyPlan.setName( resultSet.getString("name") );
					studyPlan.setLink( resultSet.getString("link") );
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
		String query = "INSERT INTO study_plan (name, link, created_by) VALUES (?, ?, ?) RETURNING studyplan_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setString(1, studyPlan.getName());
		    preparedStatement.setString(2, studyPlan.getLink());
		    preparedStatement.setInt(3, studyPlan.getCreatedBy());

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
	
	
	
	public List<StudyPlan> getSpecificUserStudyPlansCompleted(Integer userId) throws SQLException
	{
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT sp.studyplan_id, sp.name, sp.link, sp.status, sp.created_at, created_by FROM study_plan sp JOIN user_studyplan_enrollment use ON sp.studyplan_id = use.studyplan_id WHERE use.user_id = ? AND sp.status = 'complete'";
		
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
			
			preparedStatement.setInt(1, userId);
			
			try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
				
				while(resultSet.next()) {
					
					StudyPlan studyPlan = new StudyPlan();
					
					studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
					studyPlan.setName( resultSet.getString("name") );
					studyPlan.setLink( resultSet.getString("link") );
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
	
	public List<StudyPlan> getSpecificUserStudyPlansNotCompleted(Integer userId) throws SQLException
	{
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT sp.studyplan_id, sp.name, sp.link, sp.status, sp.created_at, created_by FROM study_plan sp JOIN user_studyplan_enrollment use ON sp.studyplan_id = use.studyplan_id WHERE use.user_id = ? AND sp.status = 'not_complete'";
		
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
			
			preparedStatement.setInt(1, userId);
			
			try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
				
				while(resultSet.next()) {
					
					StudyPlan studyPlan = new StudyPlan();
					
					studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
					studyPlan.setName( resultSet.getString("name") );
					studyPlan.setLink( resultSet.getString("link") );
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
	
	
	
	
	// -- Get StudyPlan Created by admin
	public List<StudyPlan> getStudyPlanCreatedByAdmin(Integer userId) throws SQLException{
		
		List<StudyPlan> studyPlans = new ArrayList<>();
		
		final String query = "SELECT studyplan_id, name, link, created_at, created_by FROM study_plan WHERE created_by = ?";
		
		try (Connection connection = DBUtil.getConnection();
			 PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
					
				preparedStatement.setInt(1, userId);
				
				try(ResultSet	resultSet  = preparedStatement.executeQuery() ) {
		
					while(resultSet.next()) {
						
						StudyPlan studyPlan = new StudyPlan();
						
						studyPlan.setStudyPlanId( resultSet.getInt("studyplan_id") );
						studyPlan.setName( resultSet.getString("name") );	
						studyPlan.setLink( resultSet.getString("link") );
						//2025-03-20 17:26:45.918626 -> 2025-03-20 17:26:45
						studyPlan.setCreatedAt( (resultSet.getString("created_at")).split("\\.")[0] );	
						studyPlan.setCreatedBy( resultSet.getInt("created_by") );
						
						studyPlans.add(studyPlan);	
						
					}
				}	
				return studyPlans.isEmpty() ? null : studyPlans;
			}
	}
	
	
	
	
	
	// -- Delete StudyPlan Created by admin RETURN RowAffected
	public Integer deleteStudyPlanCreatedByAdmin(Integer studyPlanId) throws SQLException{
		
		
		Integer affectedRow = 0;
		final String query = "DELETE FROM study_plan WHERE studyplan_id = ?";
		
		try (Connection connection = DBUtil.getConnection()){
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
					
				preparedStatement.setInt(1, studyPlanId);
				
				affectedRow = preparedStatement.executeUpdate();
				
				connection.commit();
			}
			catch(SQLException e) {
				if(connection != null) {
					connection.rollback();
				}
				throw e;
			}
			
		}
		return affectedRow;
	}
	
	

	
	public Integer updateStudyPlanCreatedByAdmin(StudyPlan studyPlan) throws SQLException
	{
		Integer affectedRow = 0;
		final String query = "UPDATE study_plan SET name = ?, link = ? WHERE studyplan_id = ? ";
		
		try (Connection connection = DBUtil.getConnection()){
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement  = connection.prepareStatement(query)) {
				
				preparedStatement.setString(1, studyPlan.getName());
				preparedStatement.setString(2, studyPlan.getLink());
				preparedStatement.setInt(3, studyPlan.getStudyPlanId());
				
				affectedRow = preparedStatement.executeUpdate();
				
				connection.commit();
			}
			catch(SQLException e) {
				if(connection != null) {
					connection.rollback();
				}
				throw e;
			}
			
		}
		return affectedRow;
	}
	
	
	
	
	
	public static void main(String[] args) {
	  try {
		  StudyPlanDAO dao = new StudyPlanDAOImpl();	  
	  	
		  StudyPlan studyPlan = new StudyPlan();
		  
		  studyPlan.setStudyPlanId(5);
		  studyPlan.setName("google");
		  studyPlan.setLink("www.google.com");
		  
		  
		  Integer retVal = dao.updateStudyPlanCreatedByAdmin(studyPlan);
		
		  System.out.println(retVal);

	  }
	  catch(SQLException e) {
	  	e.printStackTrace();
	  }
	}
	
	
	
	
	
//	public static void main(String[] args) {
//	    try {
//	    	StudyPlanDAO sd = new StudyPlanDAOImpl();
//	
//	    	List<StudyPlan> L = sd.getStudyPlanCreatedByAdmin(1);
//	    	if(L != null) {
//		    	for(var ob : L) {
//		    		display(ob);
//		    	}
//	    	}
//	    	else {
//	    		System.out.println("No StudyPlan Found!");
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
//	
}

