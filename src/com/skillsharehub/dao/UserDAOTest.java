package com.skillsharehub.dao;

import java.sql.Date;

import com.skillsharehub.model.User;

public class UserDAOTest {

    public static void main(String[] args) {

        // Create User object
        User user = new User();

        // Set user data
        user.setFullName("Deep Test");
        user.setEmail("deeptest@example.com");
        user.setPassword("test123");
        user.setPhone("9876543210");
        user.setGender("Male");
        user.setDate_of_birth(Date.valueOf("2005-01-15"));
        user.setCity("Ahmedabad");
        user.setBio("UserDAO testing");
        user.setProfileImage(null);

        // Create UserDAO object
        UserDAO userDAO = new UserDAO();

        try {

            boolean result = userDAO.insertUser(user);

            if (result) {
                System.out.println("User inserted successfully.");
            } else {
                System.out.println("User insertion failed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}