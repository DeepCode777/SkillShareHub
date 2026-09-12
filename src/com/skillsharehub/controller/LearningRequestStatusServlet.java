package com.skillsharehub.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.model.User;
import com.skillsharehub.service.LearningRequestService;

@WebServlet("/pages/learning-request-status")
public class LearningRequestStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LearningRequestService learningRequestService;

    @Override
    public void init() throws ServletException {
        learningRequestService = new LearningRequestService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Check login
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            // Get request ID
            String requestIdParameter = request.getParameter("requestId");

            if (requestIdParameter == null || requestIdParameter.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=invalid");
                return;
            }

            int requestId = Integer.parseInt(requestIdParameter);

            if (requestId <= 0) {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=invalid");
                return;
            }

            // Get action
            String action = request.getParameter("action");

            if (action == null || action.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=invalid");
                return;
            }
            
            action = action.trim().toLowerCase();

            // Logged-in user's ID
            int userId = loggedInUser.getUserId();
            String result;

            // ACCEPT
            if ("accept".equals(action)) {
                result = learningRequestService.updateRequestStatus(requestId,userId,"Accepted");
            }

            // REJECT
            else if ("reject".equals(action)) {
                result = learningRequestService.updateRequestStatus(requestId,userId,"Rejected");
            }

            // CANCEL
            else if ("cancel".equals(action)) {
                result = learningRequestService.cancelLearningRequest(requestId, userId);
            }

            // COMPLETE

            else if ("complete".equals(action)) {
                result = learningRequestService.completeLearningRequest(requestId,userId);
            }

            // INVALID ACTION

            else {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=invalid");
                return;
            }

            // RESULT HANDLING
            if ("SUCCESS".equals(result)) {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/requests?request=failed");}

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/requests?request=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/requests?request=failed");
        }
    }
}