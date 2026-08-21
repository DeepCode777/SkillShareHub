package com.skillsharehub.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

@WebServlet("/pages/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        // Email Validation
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            out.println("Email is required.");
            return;
        }

        email = email.trim();

        String emailPattern =
                "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

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

        out.println("Login data received successfully.");
        
        UserDAO userDAO = new UserDAO();

        try {

            User user = userDAO.loginUser(email, password);

            
            if (user != null) {

                HttpSession session = request.getSession();

                session.setAttribute("loggedInUser", user);

                response.sendRedirect("dashboard.jsp");

            } else {

                out.println("Invalid email or password.");

            }

        } catch (SQLException e) {

            e.printStackTrace();

            out.println("Database error occurred.");
        }

    }
}