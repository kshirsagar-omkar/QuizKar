package com.quizkar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.quizkar.entities.Users;
import com.quizkar.util.DBUtil;

public class UsersDAOImpl implements UsersDAO{

	//Returns UserId of added users
	public Integer addUser(Users user) throws SQLException
	{
																		// (RETURNING user_id) This part is used here because we want an user_id generated by postgresql
		String query = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?) RETURNING user_id";
		Integer generatedId = null;
		
		try (Connection connection = DBUtil.getConnection();
		     PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			
//			connection.setAutoCommit(false);
			
		    preparedStatement.setString(1, user.getUserName());
		    preparedStatement.setString(2, user.getEmail());
		    preparedStatement.setString(3, user.getPassword());
		    preparedStatement.setString(4, user.getRole());

		    ResultSet resultSet = preparedStatement.executeQuery();

		    
		    if (resultSet.next()) {
		        generatedId = resultSet.getInt("user_id");
//		        System.out.println("Inserted User ID: " + generatedId);
		    }
		}
		catch (SQLException e) {
		    e.printStackTrace();
		    throw e; 
		}
		return generatedId;
		
	}

	
	
	
	
	
	public Integer updateUser(Users user) throws SQLException
	{
		
//		Connection connection = null;
		String query = "UPDATE users SET username = ?, email = ?, password = ? WHERE user_id = ?";
		Integer affectedRows = 0;
		
		try(Connection connection  = DBUtil.getConnection()) {
			
			connection.setAutoCommit(false);
			
			try( PreparedStatement preparedStatement = connection.prepareStatement(query)){
				preparedStatement.setString(1, user.getUserName());
				preparedStatement.setString(2, user.getEmail());
				preparedStatement.setString(3, user.getPassword());
				preparedStatement.setInt(4, user.getUserId());
				
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
//	    	UsersDAO ud = new UsersDAOImpl();
//	
//	    	Users u = new Users();
//	    	u.setUserId(2);
//	    	u.setUserName("zzz");
//	    	u.setEmail("zzz@gmail.com");
//	    	u.setPassword("###");
//	    	u.setRole("admin");
//	    	
//	    	Integer userId = ud.updateUser(u);
//	
//	    	System.out.println(userId);
//	    }
//	    catch(SQLException e) {
//	    	e.printStackTrace();
//	    }
//	}
	

}
