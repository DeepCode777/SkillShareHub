package com.skillsharehub.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/skillsharehub";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "deep";
	
	public static Connection getConnection() {
	
		Connection connection = null;
		
		try {
			connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
			System.out.println("Connection Succesfull");
		}catch (Exception e){
			System.out.println("Connection Failed");
			e.printStackTrace();
		}
		return connection;
	}
}
