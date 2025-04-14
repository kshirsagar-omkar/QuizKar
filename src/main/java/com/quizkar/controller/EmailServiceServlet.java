package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.mail.MessagingException;

import com.quizkar.entities.OTPVerification;
import com.quizkar.service.EmailService;
import com.quizkar.service.impl.EmailServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="EmailServiceServlet", value="/EmailServiceServlet")
public class EmailServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String action = request.getParameter("action"); // it can be sendOTP or validateOTP
		String userEmail = request.getParameter("email"); //it is the user email to which OTP will send or get
		String status = "failed";
		
		PrintWriter out = response.getWriter();
		
		
		//Create a object of OTPVerification and set userEamil to it
		OTPVerification otpVerification = new OTPVerification();
		otpVerification.setUserEmail(userEmail);
		
		try {
			if(action.equals("sendOTP")) {
				status = sendOTP(otpVerification);
			}
			else if(action.equals("validateOTP")) {
				//Get OTP entered by user and check it into database
				String inputOTP = request.getParameter("inputOTP");
				status = validateOTP(otpVerification, inputOTP);
			}
		}
		catch(Exception e) {
			e.printStackTrace(); 
		}
		finally {
			out.println(status);
			out.close();
		}
		
	}

	
	
	
	public static String sendOTP(OTPVerification otpVerification) throws MessagingException, SQLException{
		
		EmailService emailService = new EmailServiceImpl();
		
    	if(emailService.sendOTPViaMail(otpVerification))
    		return "success";
    	else
    		return "failed";
	}
	
	
	
	public static String validateOTP(OTPVerification otpVerification, String inputOTP) throws SQLException {
		
		EmailService emailService = new EmailServiceImpl();
		
    	if(emailService.validateOTPViaMail(otpVerification, inputOTP))
    		return "success";
    	else
    		return "failed";
	}
	
}
