package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.skillsharehub.model.User;
import com.skillsharehub.util.DBConnection;

public class UserDAO {

    private static final String INSERT_USER_SQL =
            "INSERT INTO users "
            + "(full_name, email, password, phone, gender, date_of_birth, city, bio, profile_image, created_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

    public boolean insertUser(User user) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_USER_SQL)) {

            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getGender());
            statement.setDate(6, user.getDate_of_birth());
            statement.setString(7, user.getCity());
            statement.setString(8, user.getBio());
            statement.setString(9, user.getProfileImage());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;
        }
    }
}