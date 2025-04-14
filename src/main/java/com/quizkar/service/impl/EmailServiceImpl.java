package com.quizkar.service.impl;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Properties;
import java.util.Scanner;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.quizkar.dao.OTPVerificationDAO;
import com.quizkar.dao.impl.OTPVerificationViaMailDAOImpl;
import com.quizkar.entities.OTPVerification;
import com.quizkar.service.EmailService;
import com.quizkar.util.OTPGenerator;


public class EmailServiceImpl implements EmailService{

	
	// Sender Email Configuration
    public static final String HOST = "smtp.gmail.com";
    public static final String PORT = "587";
    private static final String EMAIL_SERVICE_SENDER_NAME = "QuizKar";
    
    public static final String EMAIL_SERVICE_SENDER_EMAIL =  System.getenv("EMAIL_SERVICE_SENDER_EMAIL"); 				
    public static final String EMAIL_SERVICE_SENDER_PASSWORD = System.getenv("EMAIL_SERVICE_SENDER_PASSWORD");     		 //your app password

    
    //Sends the mail
    public void sendEmail(String recipient, String subject, String body) throws MessagingException{
        // Configure properties for javamail
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", HOST);
        properties.put("mail.smtp.port", PORT);


        //Create a session with authentication
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_SERVICE_SENDER_EMAIL, EMAIL_SERVICE_SENDER_PASSWORD);
            }
        });


        try {
            // Compose the mail
            Message message = new MimeMessage(session);
            // Set the "From" address with a display name
            message.setFrom(new InternetAddress(EMAIL_SERVICE_SENDER_EMAIL, EMAIL_SERVICE_SENDER_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
//            message.setText(body);
            // Make Body much better
            message.setContent(body, "text/html");
            
            
            // Send the email
            Transport.send(message);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            // Handle encoding exception
        }
    }
    
    
    
    
    //Generate the OTP and send to the user
    public Boolean sendOTPViaMail(OTPVerification otpVerification) throws SQLException, MessagingException{
    	
    	//1. Generate the OTP
        Integer otpLength = 6;
        String otp = OTPGenerator.generateOTP(otpLength); 
    	
        
        
        //2. Set the otp expiry (e.g., 5 Minutes from now)
        ZonedDateTime kolkataTime = ZonedDateTime.now(ZoneId.of("Asia/Kolkata"));
        Timestamp expiryTimestamp = Timestamp.from(kolkataTime.plusMinutes(5).toInstant());
        
        
        //3. Set values to otpVerification
        otpVerification.setOtp(otp);
        otpVerification.setExpiryTimestamp(expiryTimestamp);
        
        
        //4. Save the otp to database
        OTPVerificationDAO otpVerificationDAO = new OTPVerificationViaMailDAOImpl();
        otpVerificationDAO.saveOrUpdateOTP(otpVerification);
        
        
        //5. Send the otp via mail
        String subject = "Your One-Time-Password (OTP) for QuizKar";
        //String body = "Your OTP is: " + otp + "\nNote: It is valid for the next 5 minutes.";
        
        String body = this.getBodyForOTP(otp);
        
        

        try{
            this.sendEmail(otpVerification.getUserEmail(), subject, body);
//            System.out.println("OTP sent to " + otpVerification.getUserEmail());
            return true;
        }
        catch(Exception e){
//            System.out.println("Failed to send OTP email.");
//            e.printStackTrace();
        	throw e;
        }
    }
    
    
    
    
    
    public Boolean validateOTPViaMail(OTPVerification otpVerification, String inputOTP) throws SQLException{
    	
    	OTPVerificationDAO otpVerificationDAO = new OTPVerificationViaMailDAOImpl();

        
        if(otpVerificationDAO.validateOTP(otpVerification.getUserEmail(), inputOTP)){
//            System.out.println("OTP is Valid!");
        	return true;
        }
        else {
//            System.out.println("Invalid OTP or OTP has expired.");
        	return false;
        }
    
    }
    
    
    
    
    
    
    
    public static void main(String[] args) throws SQLException, MessagingException{
    	
    	
    	//Part A:
    	
    	//1. Set Sender Details 
    	OTPVerification otpVerification = new OTPVerification();
    	otpVerification.setUserEmail("omkarkshirsagar2005@gmail.com");
    	
    	
    	//2. Send Mail
    	EmailService emailService = new EmailServiceImpl();
    	emailService.sendOTPViaMail(otpVerification);
    	

    	
    	//Part B:
    	
    	//3. Accept OTP from the user via terminal
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter The OTP: ");
        String inputOTP = sc.nextLine().trim();

        
        
        OTPVerificationDAO otpVerificationDAO = new OTPVerificationViaMailDAOImpl();

        
        if(otpVerificationDAO.validateOTP(otpVerification.getUserEmail(), inputOTP)){
            System.out.println("OTP is Valid!");
        }
        else {
            System.out.println("Invalid OTP or OTP has expired.");
        }

        sc.close();
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private String getBodyForOTP(String otp) {
    	return "<!DOCTYPE html>"
    			+ "<html>"
    			+ "<head>"
    			+ "    <style>"
    			+ "        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');"
    			+ "        body { font-family: 'Poppins', Arial, sans-serif; background-color: #f7f9fc; margin: 0; padding: 0; }"
    			+ "        .container { max-width: 600px; margin: 20px auto; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }"
    			+ "        .header { background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%); padding: 30px; text-align: center; }"
    			+ "        .logo { color: white; font-size: 28px; font-weight: 700; }"
    			+ "        .content { padding: 30px; }"
    			+ "        .otp-display { background: #f0f4ff; border-radius: 8px; padding: 20px; text-align: center; margin: 25px 0; }"
    			+ "        .otp-code { font-size: 32px; letter-spacing: 5px; color: #2a52d1; font-weight: 700; }"
    			+ "        .footer { background: #f5f7fa; padding: 20px; text-align: center; font-size: 12px; color: #666; }"
    			+ "        .btn-primary { background: #6e48aa; color: white; text-decoration: none; padding: 12px 25px; border-radius: 6px; display: inline-block; font-weight: 500; margin-top: 15px; }"
    			+ "        .divider { height: 1px; background: #eee; margin: 25px 0; }"
    			+ "    </style>"
    			+ "</head>"
    			+ "<body>"
    			+ "    <div class='container'>"
    			+ "        <div class='header'>"
    			+ "            <div class='logo'>QuizKar</div>"
    			+ "        </div>"
    			+ "        <div class='content'>"
    			+ "            <h2 style='color: #333; margin-top: 0;'>Your One-Time Password</h2>"
    			+ "            <p style='color: #555; line-height: 1.6;'>For security reasons, please use the following verification code to access your QuizKar account:</p>"
    			+ "            "
    			+ "            <div class='otp-display'>"
    			+ "                <div style='color: #666; font-size: 14px; margin-bottom: 8px;'>Your OTP Code</div>"
    			+ "                <div class='otp-code'>" + otp + "</div>"
    			+ "                <div style='color: #888; font-size: 12px; margin-top: 8px;'>Valid for 5 minutes</div>"
    			+ "            </div>"
    			+ "            "
    			+ "            <p style='color: #777; font-size: 13px;'>If you didn't request this code, please ignore this email or contact our support team immediately.</p>"
    			+ "            "
    			+ "            <div class='divider'></div>"
    			+ "            "
    			+ "            <p style='color: #555; font-size: 14px;'>Need help? <a href='mailto:quizkar.mail@gmail.com' style='color: #6e48aa;'>Contact our support team</a></p>"
    			+ "        </div>"
    			+ "        <div class='footer'>"
    			+ "            © 2025 QuizKar. All rights reserved.<br>"
    			+ "            <div style='margin-top: 8px;'>"
    			+ "                <a href='https://quizkar.onrender.com/' style='color: #666; text-decoration: none; margin: 0 5px;'>Home</a> | "
    			+ "                <a href='https://quizkar.onrender.com/' style='color: #666; text-decoration: none; margin: 0 5px;'>Privacy</a> | "
    			+ "                <a href='https://quizkar.onrender.com/' style='color: #666; text-decoration: none; margin: 0 5px;'>Terms</a>"
    			+ "            </div>"
    			+ "        </div>"
    			+ "    </div>"
    			+ "</body>"
    			+ "</html>";
    }
	
}
