package com.quizkar.dao;

import java.sql.SQLException;
import java.sql.Timestamp;

import com.quizkar.entities.OTPVerification;

public interface OTPVerificationDAO {
	
	//Save or update the otp into database
//	public abstract void saveOrUpdateOTP(Integer userId, String otp, Timestamp expiryTimestamp) throws SQLException;
	public abstract void saveOrUpdateOTP(OTPVerification otpVerification) throws SQLException;
	
	
	public abstract Boolean validateOTP(String email, String inputOTP) throws SQLException;
}
