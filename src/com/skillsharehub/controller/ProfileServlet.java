package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

@WebServlet("/pages/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            int userId = loggedInUser.getUserId();
            User user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/pages/dashboard.jsp?profile=notfound");
                return;
            }

            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,"Unable to load profile.");
        }
    }
}