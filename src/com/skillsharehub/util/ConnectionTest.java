package com.skillsharehub.util;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionTest {
	public static void main(String[] args) throws SQLException {
		Connection connection = null;
		
		try {
			System.out.println("Startin database connection test...");
			
			connection = DBConnection.getConnection();
			
			if(connection != null) {
				System.out.println("Success");
			}else {
				System.out.println("Failed");
			}
		}finally {
			if(connection != null) {
				try {
					connection.close();
					System.out.println("Closeed Successfully");
				}catch(Exception e) {
					System.out.println(e);
				}
			}
		}
	}
}
