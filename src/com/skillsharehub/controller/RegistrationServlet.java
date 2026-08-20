package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

@MultipartConfig
@WebServlet("/pages/register")
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String city = request.getParameter("city");
        String bio = request.getParameter("bio");

        if(dob == null || dob.isEmpty() ) {
        	response.getWriter().print("Date Required");
        	return;
        }
        
        // Convert date
        Date dateOfBirth = Date.valueOf(dob);

        // Create User object
        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setGender(gender);
        user.setDate_of_birth(dateOfBirth);
        user.setCity(city);
        user.setBio(bio);
        
        // Profile image
        user.setProfileImage(null);

        // Create DAO
        UserDAO userDAO = new UserDAO();

        try {

            boolean result = userDAO.insertUser(user);

            if (result) {
                response.getWriter().println("Registration successful.");
            } else {
                response.getWriter().println("Registration failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error occurred.");
        }
    }
}