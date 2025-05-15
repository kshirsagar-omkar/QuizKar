package com.quizkar.util;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;


/**
 * An improved database utility class that uses HikariCP for managing connections.
 * <p>
 * This class helps our web application connect to the PostgreSQL database quickly and efficiently.
 * It uses a connection pool, which means it reuses connections instead of opening a new one each time.
 * This makes it faster and better for handling many users at the same time.
 * </p>
 * @version 1.1
 * @see com.zaxxer.hikari.HikariDataSource
 */
public class DBUtil {
	
	/**
	 * It's like connection Pool Manager 
	 */
	private static final HikariDataSource dataSource;
	
    // Fetch database credentials from environment variables
    private static final String DB_URL = System.getenv("DB_URL");
    private static final String DB_USER = System.getenv("DB_USER");
    private static final String DB_PASS = System.getenv("DB_PASS");
    private static final String DB_DRIVER = "org.postgresql.Driver";
    
    private static final int MAX_POOL_SIZE = 50;
    private static final int MINIMUM_IDLE_CONNECTIONS = 5;
    private static final int IDLE_TIMEOUT = 30000; // 30 seconds
    private static final int CONNECTION_TIMEOUT = 20000; // 20 seconds
    private static final int MAX_LIFETIME = 600000; // 10 minutes
    
    static {
        try {
            Class.forName(DB_DRIVER);
        
            HikariConfig config = new HikariConfig();
        	config.setJdbcUrl(DB_URL);
        	config.setUsername(DB_USER);
        	config.setPassword(DB_PASS);
        	
        	//50 Connections will be ready in the pool
        	//50 clients can get Connection at the same time
        	//51th Client need to wait for the connection
        	config.setMaximumPoolSize(MAX_POOL_SIZE);
        		
        	//When there no clients using Connection, at least 5 Connections will be ready in the pool
        	//Which will make first request faster
        	config.setMinimumIdle(MINIMUM_IDLE_CONNECTIONS);

        	//If a connection is idle for more than 30 seconds, then the pool will permanently remove it
        	config.setIdleTimeout(IDLE_TIMEOUT);
        	
        	//There will be a time out, if a thread waits for 20 seconds for Connection
        	config.setConnectionTimeout(CONNECTION_TIMEOUT);
        	
        	//Every Connection has maximum lifetime of 10 minutes, after this, the Connection will be destroyed and new one is created
        	config.setMaxLifetime(MAX_LIFETIME);
        	
        	//Creating Connection Pool, according to configurations
        	dataSource = new HikariDataSource(config);
        	
        	//Close all connections, before the JVM shuts down
        	Runtime.getRuntime().addShutdownHook( new Thread(() -> {
        		if(dataSource != null) {
        			dataSource.close();        			
        		}
        		}) );
        	
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
    
    public static void closeConnections() {
    	if(dataSource != null) {
    		dataSource.close();
    	}
    }

}