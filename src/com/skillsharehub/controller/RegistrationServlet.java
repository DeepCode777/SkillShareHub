package com.skillsharehub.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

@MultipartConfig
@WebServlet("/pages/register")
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	PrintWriter out = response.getWriter();
    	
        // Full Name Validation
    	String fullName = request.getParameter("fullname");

    	if (fullName == null || fullName.trim().isEmpty()) {
    	    out.println("Full name is required.");
    	    return;
    	}

    	fullName = fullName.trim();

    	if (fullName.length() < 3) {
    	    out.println("Full name must contain at least 3 characters.");
    	    return;
    	}
        
    	// Email Validation
    	String email = request.getParameter("email");

    	if (email == null || email.trim().isEmpty()) {
    	    out.println("Email is required.");
    	    return;
    	}

    	email = email.trim();

    	String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

    	if (!email.matches(emailPattern)) {
    	    out.println("Please enter a valid email address.");
    	    return;
    	}
        
    	// Password Validation
    	String password = request.getParameter("password");

    	if (password == null || password.isEmpty()) {
    	    out.println("Password is required.");
    	    return;
    	}

    	String passwordPattern =
    	        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$";

    	if (!password.matches(passwordPattern)) {
    	    out.println("Password must contain at least 8 characters,"
    	            + " including uppercase, lowercase, number, special character.");
    	    return;
    	}
        
    	
    	// Phone Validation
    	String phone = request.getParameter("phone");

    	if (phone == null || phone.trim().isEmpty()) {
    	    out.println("Phone number is required.");
    	    return;
    	}

    	phone = phone.trim();

    	String phonePattern = "^[0-9]{10}$";

    	if (!phone.matches(phonePattern)) {
    	    out.println("Phone number must contain exactly 10 digits.");
    	    return;
    	}
    	
    	
    	// Gender Validation
    	String gender = request.getParameter("gender");

    	if (gender == null || gender.trim().isEmpty()) {
    	    out.println("Please select your gender.");
    	    return;
    	}

    	if (!gender.equals("Male") &&
    	    !gender.equals("Female") &&
    	    !gender.equals("Other")) {

    	    out.println("Invalid gender selected.");
    	    return;
    	}
    	
    	
    	// Date Of Birth Validation
    	String dob = request.getParameter("dob");

    	if (dob == null || dob.trim().isEmpty()) {
    	    out.println("Date of birth is required.");
    	    return;
    	}

    	Date dateOfBirth;

    	try {
    	    dateOfBirth = Date.valueOf(dob);
    	} catch (IllegalArgumentException e) {
    	    out.println("Invalid date of birth.");
    	    return;
    	}

    	Date today = new Date(System.currentTimeMillis());

    	if (dateOfBirth.after(today)) {
    	    out.println("Date of birth cannot be a future date.");
    	    return;
    	}
    	
    	
    	// City Validation
    	String city = request.getParameter("city");

    	if (city == null || city.trim().isEmpty()) {
    	    out.println("City is required.");
    	    return;
    	}

    	city = city.trim();

    	if (city.length() < 2) {
    	    out.println("City name must contain at least 2 characters.");
    	    return;
    	}

    	String cityPattern = "^[A-Za-z ]+$";

    	if (!city.matches(cityPattern)) {
    	    out.println("City name can contain only letters and spaces.");
    	    return;
    	}
    	
    	
    	// bio Validation
    	String bio = request.getParameter("bio");

    	if (bio != null) {
    	    bio = bio.trim();

    	    if (bio.length() > 500) {
    	        out.println("Bio must not exceed 500 characters.");
    	        return;
    	    }
    	}
    	
    	
    	// Image Validation
    	Part profilePicture = request.getPart("profilePicture");
    	if (profilePicture != null && profilePicture.getSize() > 0) {

    	    String contentType = profilePicture.getContentType();

    	    if (!"image/jpeg".equals(contentType) &&
    	        !"image/png".equals(contentType)) {

    	        out.println("Only JPG, JPEG, and PNG images are allowed.");
    	        return;
    	    }

    	    long maxSize = 2 * 1024 * 1024; // 2 MB

    	    if (profilePicture.getSize() > maxSize) {
    	        out.println("Profile image must not exceed 2 MB.");
    	        return;
    	    }
    	}
        

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
               out.println("Registration successful.");
            } else {
                out.println("Registration failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Database error occurred.");
        }
    }
}