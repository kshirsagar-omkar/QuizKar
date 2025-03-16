package com.quizkar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	
//     Hardcoded Render database credentials
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/quizkar?sslmode=disable";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root@123";

    
    private static final String DB_DRIVER = "org.postgresql.Driver";
    
    static {
        try {
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
    
}