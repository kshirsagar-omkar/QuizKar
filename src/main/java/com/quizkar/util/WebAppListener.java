package com.quizkar.util;

import java.sql.DriverManager;
import java.util.Enumeration;

import com.quizkar.service.impl.EmailServiceImpl;

import java.sql.Driver;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class WebAppListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		//Close the connections, when the web app shut downs, to prevent memory leaks 
		DBUtil.closeConnections();
		
		//Close all email executors(threads)
		EmailServiceImpl.shutdownExecutor();
		
		//De-register the Drivers
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		Enumeration<Driver> drivers = DriverManager.getDrivers();
		
		while(drivers.hasMoreElements()) {
			Driver driver = drivers.nextElement();
			
			if(driver.getClass().getClassLoader() == cl) {
				try {
					DriverManager.deregisterDriver(driver);
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
