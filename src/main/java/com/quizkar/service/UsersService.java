package com.quizkar.service;

import java.sql.SQLException;

import com.quizkar.entities.Users;

public interface UsersService {
	
	//Validate the user is present in database with correct credentials if yes returns user_id else null
	public abstract Integer validateUser(Users user) throws SQLException;
	
	

	//Get user is used for showing user details on profile
	public abstract Users getUser(Users user) throws SQLException;
	
	
	//Insert user in db //Returns UserId of added users
	public abstract Integer addUser(Users user) throws SQLException;
}
