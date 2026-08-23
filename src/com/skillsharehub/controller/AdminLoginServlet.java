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

import com.skillsharehub.dao.AdminDAO;
import com.skillsharehub.model.Admin;
import com.skillsharehub.util.PasswordUtil;

@WebServlet("/pages/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        // Username Validation
        String username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()) {
            out.println("Username is required.");
            return;
        }

        username = username.trim();

        // Password Validation
        String password = request.getParameter("password");

        if (password == null || password.isEmpty()) {
            out.println("Password is required.");
            return;
        }

        AdminDAO adminDAO = new AdminDAO();

        try {

            Admin admin = adminDAO.loginAdmin(username);

            if (admin != null && PasswordUtil.checkPassword(password, admin.getPassword())) {

                HttpSession session = request.getSession();

                session.setAttribute("loggedInAdmin", admin);

                response.sendRedirect("admin.jsp");

            } else {

                out.println("Invalid username or password.");
            }

        } catch (SQLException e) {

            e.printStackTrace();

            out.println("Database error occurred.");
        }
    }
}