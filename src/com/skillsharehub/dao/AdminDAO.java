package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.skillsharehub.model.Admin;
import com.skillsharehub.util.DBConnection;

public class AdminDAO {

    private static final String LOGIN_ADMIN_SQL =
            "SELECT admin_id, username, password "
            + "FROM admin WHERE username = ?";

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
}