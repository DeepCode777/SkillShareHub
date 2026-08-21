package com.skillsharehub.dao;

import java.sql.SQLException;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

public class UserDAOTest {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAO();

        // Use an email and password of an existing user
        String email = "test19@gmail.com";
        String password = "@gmail.ocom";

        try {

            User user = userDAO.loginUser(email, password);

            if (user != null) {

                System.out.println("Login successful.");
                System.out.println("User ID: " + user.getUserId());
                System.out.println("Full Name: " + user.getFullName());
                System.out.println("Email: " + user.getEmail());

            } else {

                System.out.println("Invalid email or password.");

            }

        } catch (SQLException e) {

            System.out.println("Database error occurred.");
            e.printStackTrace();

        }
    }
}