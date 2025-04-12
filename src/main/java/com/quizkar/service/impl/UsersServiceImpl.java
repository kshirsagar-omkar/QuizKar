package com.quizkar.service.impl;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.dao.UsersDAO;
import com.quizkar.dao.impl.UsersDAOImpl;
import com.quizkar.entities.Users;
import com.quizkar.service.UsersService;

public class UsersServiceImpl implements UsersService {
	
	public Users validateUser(Users user) throws SQLException
	{
		UsersDAO usersDAO = new UsersDAOImpl();
		
		//Validate the user is present in database with correct credentials if yes returns user_id else null
		return usersDAO.validateUser(user);
	}
	
	
	//Update user in db Return affected rows password needed to update user details
	public Integer updateUser(Users user) throws SQLException{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.updateUser(user);
	}

	//Get user is used for showing user details on profile
	public Users getUser(Users user) throws SQLException
	{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.getUser(user);
	}
	
	//Insert user in db //Returns UserId of added users
	public  Integer addUser(Users user) throws SQLException
	{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.addUser(user);
	}
	
	
	
	//Delete user from db returns AffectedRow
	public Integer deleteUser(Integer userId) throws SQLException{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.deleteUser(userId);
	}
	
	
	//Return the total number of users registred in application
	public Integer getTotalUsers() throws SQLException{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.getTotalUsers();
	}
	
	
	//Update userRegistration count for every registration returns row affected
	public Integer updateTotalUser() throws SQLException{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.updateTotalUser();
	}
	
	
	//Gets the user by his user_id
	public Users getUserById(int userId) throws SQLException{
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.getUserById(userId);
	}


	@Override
	public List<Users> getAllUsers() throws SQLException {
		UsersDAO usersDAO = new UsersDAOImpl();
		return usersDAO.getAllUsers();
	}
}
