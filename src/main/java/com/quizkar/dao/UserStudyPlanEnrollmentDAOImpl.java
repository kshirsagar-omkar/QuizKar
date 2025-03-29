package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.quizkar.entities.UserStudyPlanEnrollment;
import com.quizkar.util.DBUtil;

public class UserStudyPlanEnrollmentDAOImpl implements UserStudyPlanEnrollmentDAO{
	
	public Integer enrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException
	{
		String query = "INSERT INTO user_studyplan_enrollment (user_id, studyplan_id) VALUES (?, ?) RETURNING enrollment_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setInt(1, userStudyPlanEnrollment.getUserId());
		    preparedStatement.setInt(2, userStudyPlanEnrollment.getStudyPlanId());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        generatedId = resultSet.getInt("enrollment_id");
//		        System.out.println("Inserted ID: " + generatedId);
		    }
		}
		catch (SQLException e) {
//		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
	}
	

	
	public Integer unEnrollStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment) throws SQLException
	{
		
		String query = "DELETE FROM user_studyplan_enrollment WHERE studyplan_id = ? AND user_id = ?";
		Integer affectedRows = 0;
		
		try(Connection connection  = DBUtil.getConnection()) {
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement = connection.prepareStatement(query)){
				
				preparedStatement.setInt(2, userStudyPlanEnrollment.getUserId());
			    preparedStatement.setInt(1, userStudyPlanEnrollment.getStudyPlanId());
				
				affectedRows = preparedStatement.executeUpdate();
				connection.commit();
			}
			catch(SQLException e) {
				e.printStackTrace();
				if(connection != null) {
					try {
						connection.rollback();
					}
					catch(SQLException rollBackEX) {
						rollBackEX.printStackTrace();
					}
				}
				throw e;
			}
		}
		return affectedRows;
	}
	
	
	
	public Integer updateStatusOfStudyPlan(UserStudyPlanEnrollment userStudyPlanEnrollment, String status) throws SQLException
	{
		
		String query = "UPDATE study_plan sp SET status = ? FROM user_studyplan_enrollment use WHERE sp.studyplan_id = use.studyplan_id AND use.user_id = ? AND sp.studyplan_id = ?";
		Integer affectedRows = 0;
		
		try(Connection connection  = DBUtil.getConnection()) {
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement = connection.prepareStatement(query)){
				
				preparedStatement.setString(1, status);
				preparedStatement.setInt(2, userStudyPlanEnrollment.getUserId());
			    preparedStatement.setInt(3, userStudyPlanEnrollment.getStudyPlanId());
				
				affectedRows = preparedStatement.executeUpdate();
				connection.commit();
			}
			catch(SQLException e) {
				e.printStackTrace();
				if(connection != null) {
					try {
						connection.rollback();
					}
					catch(SQLException rollBackEX) {
						rollBackEX.printStackTrace();
					}
				}
				throw e;
			}
		}
		return affectedRows;
	}
	
	
	
	
	
	
//	public static void main(String[] args) {
//	    try {
//	    	UserStudyPlanEnrollmentDAO dao = new UserStudyPlanEnrollmentDAOImpl();
//	
//	    	UserStudyPlanEnrollment ob = new UserStudyPlanEnrollment();
//	    	ob.setUserId(3);
//	    	ob.setStudyPlanId(1);
//	    	
//	    	Integer retVal = dao.updateStatusOfStudyPlan(ob, "complete");
//	
//	    	System.out.println(retVal);
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}
}
