package com.quizkar.util;

import java.security.SecureRandom;

public class OTPGenerator {
	
	private static final String DIGITS ;
    private static final Integer DIGITS_LENGTH;
    private static final SecureRandom random;

    static {
        DIGITS = "0123456789";
        DIGITS_LENGTH = 10;
        random = new SecureRandom();
    }

    //Generate a numeric OTP of specified length
    public static String generateOTP(Integer length){
        StringBuilder otp = new StringBuilder();
        for(int i=0; i<length; ++i){
            otp.append( DIGITS.charAt( random.nextInt( DIGITS_LENGTH ) ) );
        }
        return otp.toString();
    }
}
