package com.quizkar.service;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Users;

public interface UsersService {
	
	//Validate the user is present in database with correct credentials if yes returns user_id else null
	public abstract Users validateUser(Users user) throws SQLException;
	
	//Update user in db Return affected rows password needed to update user details
	public abstract Integer updateUser(Users user) throws SQLException;

	//Get user is used for showing user details on profile
	public abstract Users getUser(Users user) throws SQLException;
	
	
	//Insert user in db //Returns UserId of added users
	public abstract Integer addUser(Users user) throws SQLException;
	
	//Delete user from db returns AffectedRow
	public abstract Integer deleteUser(Integer userId) throws SQLException;
	
	
	//Return the total number of users registred in application
	public abstract Integer getTotalUsers() throws SQLException;
	
	
	//Update userRegistration count for every registration returns row affected
	public abstract Integer updateTotalUser() throws SQLException;
	
	//Gets the user by his user_id
	Users getUserById(int userId) throws SQLException;
	
	//Gets all users
	public abstract List<Users> getAllUsers() throws SQLException;
	
	//ReSet the password(update password) // returns row affected
	public abstract Integer updatePassword(Users user) throws SQLException;
}
