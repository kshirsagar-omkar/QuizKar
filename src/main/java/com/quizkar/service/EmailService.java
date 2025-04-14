package com.quizkar.service;

import java.sql.SQLException;

import javax.mail.MessagingException;

import com.quizkar.entities.OTPVerification;

public interface EmailService {
	
	//Sends the mail
	public abstract void sendEmail(String recipient, String subject, String body) throws MessagingException;
	
	//Generate the otp and send to the user
	public abstract Boolean sendOTPViaMail(OTPVerification otpVerification) throws MessagingException, SQLException;
	
	
	public abstract Boolean validateOTPViaMail(OTPVerification otpVerification, String inputOTP) throws SQLException;
	
}
