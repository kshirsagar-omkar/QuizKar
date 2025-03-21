package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.quizkar.entities.StudyPlan;
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
		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
	}
	
	
	
	
	
	
//	
//	public static void main(String[] args) {
//	    try {
//	    	UserStudyPlanEnrollmentDAO usped = new UserStudyPlanEnrollmentDAOImpl();
//	
//	    	UserStudyPlanEnrollment spuspe = new UserStudyPlanEnrollment();
//	    	spuspe.setUserId(2);
//	    	spuspe.setStudyPlanId(1);
//	    	
//	    	Integer Id = usped.enrollStudyPlan(spuspe);
//	
//	    	System.out.println(Id);
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}
}
