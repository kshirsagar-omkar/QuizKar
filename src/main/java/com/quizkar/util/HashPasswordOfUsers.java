package com.quizkar.util;

import java.sql.SQLException;
import java.util.List;

import com.quizkar.service.UsersService;
import com.quizkar.service.impl.UsersServiceImpl;
import com.quizkar.entities.Users;

public class HashPasswordOfUsers {

	private static UsersService usersService = new UsersServiceImpl();
	
	public static void main(String[] args) throws SQLException {

		/*
		 * =============================================
		 * 
		 * BEFORE UPDATING, GO TO UsersDAOImpl 
		 * and uncomment, statement in while loop of getAllUsers() method
		 * 
		 * 
		 * ==============================================
		 * 
		 */
		
		List<Users> users = usersService.getAllUsers();
		
		for(Users user : users) {
			String plainPassword = user.getPassword();
			String securedPasword = PasswordUtils.generateSecurePassword(plainPassword);
			
			//Update password
			user.setPassword(securedPasword);
			
			if (usersService.updateUser(user) > 0 ) {
				System.out.println( user.getUserName() +  " 's password updated !");
			}
			else {
				System.out.println("Unable to update " +  user.getUserName() +  " 's password ");				
			}
			
		}
		
	}

}
