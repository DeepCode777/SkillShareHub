package com.skillsharehub.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillsharehub.dao.AdminDAO;
import com.skillsharehub.model.Admin;
import com.skillsharehub.util.PasswordUtil;

@WebServlet("/pages/adminRegister")
public class AdminRegister extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		 // Full Name Validation
    	String fullName = request.getParameter("username");

    	if (fullName == null || fullName.trim().isEmpty()) {
    	    out.println("Full name is required.");
    	    return;
    	}

    	fullName = fullName.trim();

    	if (fullName.length() < 3) {
    	    out.println("Full name must contain at least 3 characters.");
    	    return;
    	}
    	
    	// Create AdminDAO object
    	AdminDAO adminDAO = new AdminDAO();
    	// Duplicate Admin Check
    	try {

    	    if (adminDAO.isAdminExists(fullName)) {
    	        out.println("Admin is already registered.");
    	        response.sendRedirect("adminRegister.jsp");
    	        return;
    	    }

    	} catch (SQLException e) {
    	    e.printStackTrace();
    	    out.println("Database error occurred while checking email.");
    	    return;
    	}
    	
    	// Password Validation
    	String password = request.getParameter("password");

    	if (password == null || password.isEmpty()) {
    	    out.println("Password is required.");
    	    return;
    	}

    	String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$";

    	if (!password.matches(passwordPattern)) {
    	    out.println("Password must contain at least 8 characters,"
    	            + " including uppercase, lowercase, number, special character.");
    	    return;
    	}
    	
    	String hashedPassword = PasswordUtil.hashPassword(password);
    	
    	// Create Admin
    	Admin admin = new Admin();
    	
    	admin.setUsername(fullName);
    	admin.setPassword(hashedPassword);
    	
    	// Insert
        try {
            boolean result = adminDAO.insertAdmin(admin);

            if (result) {
               response.sendRedirect("adminLogin.jsp");
            } else {
                response.sendRedirect("adminRegister.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Database error occurred.");
        }
	}
}
