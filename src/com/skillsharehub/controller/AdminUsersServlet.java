package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;
import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;

@WebServlet("/pages/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();

        try {

            List<User> users = userDAO.getAllUsers();

            request.setAttribute("users", users);

            request.getRequestDispatcher("/pages/adminUsers.jsp").forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();
            // server error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load users.");
        }
    }
    
    // It Handle Delete User
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            String userIdParameter = request.getParameter("userId");

            if (userIdParameter == null || userIdParameter.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/users");
                return;
            }

            try {

                int userId = Integer.parseInt(userIdParameter);
                
                // By pass the request of delete ID = 0,-1,-2....
                if (userId <= 0) {
                    response.sendRedirect(request.getContextPath() + "/pages/admin/users");
                    return;
                }
                UserDAO userDAO = new UserDAO();

                boolean deleted = userDAO.deleteUser(userId);

                if (deleted) {

                    response.sendRedirect(request.getContextPath() + "/pages/admin/users?delete=success");

                } else {

                    response.sendRedirect(request.getContextPath() + "/pages/admin/users?delete=failed");
                }
            } catch (Exception e) {

                e.printStackTrace();

                response.sendRedirect(request.getContextPath() + "/pages/admin/users");
            }
        }
        
        // View Users By ID (Admin)
        if ("view".equals(action)) {

            String userIdParameter = request.getParameter("userId");

            if (userIdParameter == null || userIdParameter.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/users");
                return;
            }

            try {

                int userId = Integer.parseInt(userIdParameter);

                if (userId <= 0) {
                    response.sendRedirect(request.getContextPath() + "/pages/admin/users");
                    return;
                }

                UserDAO userDAO = new UserDAO();

                User user = userDAO.getUserById(userId);

                if (user != null) {
                	
                	SkillDAO skillDAO = new SkillDAO();
                	List<Skill> skills = skillDAO.getSkillsByUserId(userId);

                    request.setAttribute("user", user);
                    request.setAttribute("skills", skills);
                    
                    request.getRequestDispatcher("/pages/userDetails.jsp").forward(request, response);

                } else {

                    response.sendRedirect(
                            request.getContextPath() + "/pages/admin/users?view=notfound"
                    );
                }

            } catch (NumberFormatException | SQLException e) {

                e.printStackTrace();

                response.sendRedirect(
                        request.getContextPath() + "/pages/admin/users?view=error"
                );
            }
        }
    }
}