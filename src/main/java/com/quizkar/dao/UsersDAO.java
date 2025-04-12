package com.quizkar.dao;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.entities.Users;

public interface UsersDAO {
	
	//Insert user in db
	public abstract Integer addUser(Users user) throws SQLException;
	
	
	//Update user in db Return affected rows password needed to update user details
	public abstract Integer updateUser(Users user) throws SQLException;

	//Validate the user is present in database with correct credentials if yes returns uers else null
	public abstract Users validateUser(Users user) throws SQLException;
	
	
	//Get user is used for showing user details on profile
	public abstract Users getUser(Users user) throws SQLException;
	
	
	//Delete user from db returns AffectedRow
	public abstract Integer deleteUser(Integer userId) throws SQLException;
	
	
	//Return the total number of users registred in application
	public abstract Integer getTotalUsers() throws SQLException;
	
	//Update userRegistration count for every registration returns row affected
	public abstract Integer updateTotalUser() throws SQLException;

	//Gets the user by his user_id
	public abstract Users getUserById(int userId) throws SQLException;

	//Gets all users
	public abstract List<Users> getAllUsers() throws SQLException;
}
