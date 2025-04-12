package com.quizkar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	
//     Hardcoded Render database credentials
//    private static final String DB_URL = "jdbc:postgresql://localhost:5432/quizkar?sslmode=disable";
//    private static final String DB_USER = "root";
//    private static final String DB_PASS = "root@123";

    
    private static final String DB_URL = "jdbc:postgresql://ep-small-glade-a1aqhfjk-pooler.ap-southeast-1.aws.neon.tech:5432/quizkar?sslmode=require";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "npg_YKH3dG4SInNx";

    //private static final String DB_URL = "jdbc:postgresql://localhost/quizkar_db";
    //private static final String DB_USER = "dnyaneshwar";
    //private static final String DB_PASS = "root@3121";
    
    
//    private static final String DATABASE_URL[] = System.getenv("DATABASE_URL").split(",");
//    
//    private static final String DB_URL = DATABASE_URL[0];
//    private static final String DB_USER = DATABASE_URL[1];
//    private static final String DB_PASS = DATABASE_URL[2];
//    
    
    
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