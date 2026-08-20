package com.skillsharehub.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/skillsharehub";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "deep";
	
	public static Connection getConnection() throws SQLException {
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Diver Loaded");
		}catch (Exception e) {
			System.out.println(e);
		}
		Connection connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
		
		System.out.println("Connection Succesfull");
			
		return connection;
	}
}
