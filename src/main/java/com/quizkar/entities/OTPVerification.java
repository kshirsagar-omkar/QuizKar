package com.quizkar.entities;

import java.sql.Timestamp;

public class OTPVerification {
	private String userEmail;
	private String otp;
	private Timestamp expiryTimestamp;
	
	
	
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public Timestamp getExpiryTimestamp() {
		return expiryTimestamp;
	}
	public void setExpiryTimestamp(Timestamp expiryTimestamp) {
		this.expiryTimestamp = expiryTimestamp;
	}
}
