package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.dao.LearningRequestDAO;
import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.model.User;

@WebServlet("/pages/requests")
public class LearningRequestListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LearningRequestDAO learningRequestDAO;

    @Override
    public void init() throws ServletException {
        learningRequestDAO = new LearningRequestDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {

            int userId = loggedInUser.getUserId();

            // Get received requests
            List<LearningRequest> receivedRequests = learningRequestDAO.getReceivedRequestsByUserId(userId);

            // Get sent requests
            List<LearningRequest> sentRequests = learningRequestDAO.getSentRequestsByUserId(userId);
           
            // Send data to JSP
            request.setAttribute("receivedRequests", receivedRequests);

            request.setAttribute("sentRequests", sentRequests);

            // Forward to requests page
            request.getRequestDispatcher("/pages/requests.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load learning requests.");
        }
    }
}