package com.quizkar.service;

import java.sql.SQLException;
import java.util.concurrent.Future;

import javax.mail.MessagingException;

import com.quizkar.entities.OTPVerification;

public interface EmailService {
	
	//Sends the mail
	public abstract void sendEmail(String recipient, String subject, String body) throws MessagingException;
	
	//Generate the otp and send to the user
	public abstract Boolean sendOTPViaMail(OTPVerification otpVerification) throws MessagingException, SQLException;
	
	//Validate OTP
	public abstract Boolean validateOTPViaMail(OTPVerification otpVerification, String inputOTP) throws SQLException;
	
	//Send OTP via mail, with a thread executor
	public abstract Future<Boolean> sendOTPViaMailAsync(OTPVerification otpVerification);
}
