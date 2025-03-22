package com.quizkar.dao;

import java.sql.SQLException;

import com.quizkar.entities.Users;

public interface UsersDAO {
	
	//Insert user in db
	public abstract Integer addUser(Users user) throws SQLException;
	
	
	//Update user in db Returns RowAffected by update query
	public abstract Integer updateUser(Users user) throws SQLException;
}
