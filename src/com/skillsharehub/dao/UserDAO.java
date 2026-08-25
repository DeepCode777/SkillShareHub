package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skillsharehub.model.User;
import com.skillsharehub.util.DBConnection;

public class UserDAO {

    private static final String INSERT_USER_SQL =
            "INSERT INTO users "
            + "(full_name, email, password, phone, gender, date_of_birth, city, bio, profile_image, created_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
    
    private static final String LOGIN_USER_SQL = "SELECT "
    		+ "user_id, full_name, email, password, phone, gender, date_of_birth, city, bio, profile_image, created_at "
            + "FROM users WHERE email = ?";
    
    private static final String CHECK_EMAIL_SQL = "SELECT COUNT(*) FROM users WHERE email = ?";
    
    private static final String GET_ALL_USERS_SQL =
            "SELECT user_id, full_name, email, phone, gender, date_of_birth, city, bio, profile_image, created_at "
            + "FROM users";
    
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE user_id = ?";
    
    // User Login
    public User loginUser(String email) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(LOGIN_USER_SQL)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    User user = new User();

                    user.setUserId(resultSet.getInt("user_id"));
                    user.setFullName(resultSet.getString("full_name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPassword(resultSet.getString("password"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setGender(resultSet.getString("gender"));
                    user.setDate_of_birth(resultSet.getDate("date_of_birth"));
                    user.setCity(resultSet.getString("city"));
                    user.setBio(resultSet.getString("bio"));
                    user.setProfileImage(resultSet.getString("profile_image"));
                    user.setCreatedAt(resultSet.getTimestamp("created_at"));

                    return user;
                }
            }
        }

        return null;
    }
    
    
    // Check Email Is Exist 
    public boolean isEmailExists(String email) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(CHECK_EMAIL_SQL)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        }

        return false;
    }
    
    // Get All Users
    public List<User> getAllUsers() throws SQLException {

        List<User> users = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(GET_ALL_USERS_SQL);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                User user = new User();

                user.setUserId(resultSet.getInt("user_id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setGender(resultSet.getString("gender"));
                user.setDate_of_birth(resultSet.getDate("date_of_birth"));
                user.setCity(resultSet.getString("city"));
                user.setBio(resultSet.getString("bio"));
                user.setProfileImage(resultSet.getString("profile_image"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));

                users.add(user);
            }
        }

        return users;
    }

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
    
    public boolean deleteUser(int userId) throws SQLException {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_USER_SQL)) {

            statement.setInt(1, userId);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;
        }
    }
}