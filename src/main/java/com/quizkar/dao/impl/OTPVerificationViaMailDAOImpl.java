package com.quizkar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import com.quizkar.dao.OTPVerificationDAO;
import com.quizkar.entities.OTPVerification;
import com.quizkar.util.DBUtil;

public class OTPVerificationViaMailDAOImpl implements OTPVerificationDAO{

	//Save or update the otp into database
	public void saveOrUpdateOTP(OTPVerification otpVerification) throws SQLException{
		
		String sql = "INSERT INTO otp_verification (email, otp, expiry_timestamp) " +
                "VALUES (?, ?, ?) " +
                "ON CONFLICT (email) DO UPDATE SET " +
                "otp = EXCLUDED.otp, " +
                "expiry_timestamp = EXCLUDED.expiry_timestamp";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, otpVerification.getUserEmail());
            ps.setString(2, otpVerification.getOtp());
            ps.setTimestamp(3, otpVerification.getExpiryTimestamp());

            ps.executeUpdate();

        }
	}
	
	
	
	public Boolean validateOTP(String email, String inputOTP) throws SQLException{
		
		String sql = "SELECT otp, expiry_timestamp FROM otp_verification WHERE email = ? ORDER BY expiry_timestamp DESC LIMIT 1";
		
		
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String savedOTP = rs.getString("otp");
                Timestamp expiryTimestamp = rs.getTimestamp("expiry_timestamp");

                // Get the current time in Asia/Kolkata time zone
                Timestamp now = Timestamp.from(ZonedDateTime.now(ZoneId.of("Asia/Kolkata")).toInstant());

                //Check if otp matches and still valid (not expired)
                if(savedOTP.equals(inputOTP) && now.before(expiryTimestamp)){
                    return true;
                }
            }
        }
        return false;
	}
}
