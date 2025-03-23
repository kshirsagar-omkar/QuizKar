package com.quizkar.dao;

import java.sql.SQLException;

import com.quizkar.entities.Users;

public interface UsersDAO {
	
	//Insert user in db
	public abstract Integer addUser(Users user) throws SQLException;
	
	
	//Update user in db Return affected rows password needed to update user details
	public abstract Integer updateUser(Users user) throws SQLException;

	//Validate the user is present in database with correct credentials if yes returns user_id else null
	public abstract Integer validateUser(Users user) throws SQLException;
	
	
	//Get user is used for showing user details on profile
	public abstract Users getUser(String userName) throws SQLException;
	
	
	//Delete user from db returns AffectedRow
	public abstract Integer deleteUser(Integer userId) throws SQLException;
}
