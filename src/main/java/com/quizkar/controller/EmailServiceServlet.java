package com.quizkar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.concurrent.Future;

import javax.mail.MessagingException;

import com.quizkar.entities.OTPVerification;
import com.quizkar.service.EmailService;
import com.quizkar.service.UsersService;
import com.quizkar.service.impl.EmailServiceImpl;
import com.quizkar.service.impl.UsersServiceImpl;
import com.quizkar.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="EmailServiceServlet", value="/EmailServiceServlet")
public class EmailServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		String action = request.getParameter("action");            
        String userEmail = request.getParameter("email");
        String requestFrom = request.getParameter("requestFrom"); // "register" or "forgotPassword"
        String status = "failed";                                  
        
        OTPVerification otpVerification = new OTPVerification();
        otpVerification.setUserEmail(userEmail);

        try (PrintWriter out = response.getWriter()) {

            if ("sendOTP".equals(action)) {
                status = handleSendOTP(requestFrom, userEmail, otpVerification);
            } 
            else if ("validateOTP".equals(action)) {
                String inputOTP = request.getParameter("inputOTP");
                status = validateOTP(otpVerification, inputOTP);

                // If email is verified, store verified email in session for future validations
                if ("success".equals(status)) {
                    SessionUtil.setVerifiedEmail(request, userEmail);
                }
            }

            out.println(status); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Handles sending OTP logic based on where the request came from
    private String handleSendOTP(String requestFrom, String email, OTPVerification otp) throws MessagingException, SQLException {
        boolean userExists = isUserExistsWithEmail(email);

        if ("forgotPassword".equals(requestFrom)) {
            return userExists ? sendOTP(otp) : "no_account";
        }

        if ("register".equals(requestFrom)) {
            return !userExists ? sendOTP(otp) : "account_exists";
        }

        return "failed"; //default 
    }


	
    private static boolean isUserExistsWithEmail(String email) {
        try {
            UsersService usersService = new UsersServiceImpl();
            return usersService.getUserByEmail(email) != null;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	
	public static String sendOTP(OTPVerification otpVerification) throws MessagingException, SQLException{
		
		// Sending OTP in a separate thread so that the main thread doesn't do the heavy work directly.
		// We still wait for the result (using future.get()), but this way the app can handle many users better.
		// This makes it easier to send emails for multiple users at the same time without slowing down everything.

		
		EmailService emailService = new EmailServiceImpl();
		Future<Boolean> future = emailService.sendOTPViaMailAsync(otpVerification);

		try {
		    if (future.get()) {
		        return "success";
		    } else {
		        return "failed";
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		    return "failed";
		}

	}
	
	
	
	public static String validateOTP(OTPVerification otpVerification, String inputOTP) throws SQLException {
		
		EmailService emailService = new EmailServiceImpl();
		
    	if(emailService.validateOTPViaMail(otpVerification, inputOTP))
    		return "success";
    	else
    		return "failed";
	}
	
}
