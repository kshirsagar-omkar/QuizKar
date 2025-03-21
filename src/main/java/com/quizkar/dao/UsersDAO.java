package com.quizkar.dao;

import java.sql.SQLException;

import com.quizkar.entities.Users;

public interface UsersDAO {
	
	//Insert user in db
	public abstract Integer addUser(Users user) throws SQLException;
	
}
