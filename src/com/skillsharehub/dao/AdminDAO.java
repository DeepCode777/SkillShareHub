package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.skillsharehub.model.Admin;
import com.skillsharehub.util.DBConnection;

public class AdminDAO {

    private static final String LOGIN_ADMIN_SQL =
            "SELECT admin_id, username, password FROM admin WHERE username = ?";

    private static final String INSERT_ADMIN_SQL =
    		"INSERT INTO admin (username, password) VALUES (?,?)";
    
    private static final String CHECK_ADMIN_SQL = "SELECT COUNT(*) FROM admin WHERE username = ?";
    
    // Login Admin
    public Admin loginAdmin(String username) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(LOGIN_ADMIN_SQL)) {

            statement.setString(1, username);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    Admin admin = new Admin();

                    admin.setAdminId(resultSet.getInt("admin_id"));
                    admin.setUsername(resultSet.getString("username"));
                    admin.setPassword(resultSet.getString("password"));

                    return admin;
                }
            }
        }

        return null;
    }
    
    // Check Admin Email Is Exist 
    public boolean isAdminExists(String username) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(CHECK_ADMIN_SQL)) {

            statement.setString(1, username);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    // Insert New Admin
    public boolean insertAdmin(Admin admin) throws SQLException {
    	
    	try (Connection connection = DBConnection.getConnection();
    			PreparedStatement statement = connection.prepareStatement(INSERT_ADMIN_SQL)) {
	
    	    statement.setString(1, admin.getUsername());
    	    statement.setString(2, admin.getPassword());
    				
    	    int rowsAffected = statement.executeUpdate();
    	    return rowsAffected == 1;
    	}
    }
}