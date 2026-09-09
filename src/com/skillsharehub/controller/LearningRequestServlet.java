package com.skillsharehub.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;
import com.skillsharehub.model.User;
import com.skillsharehub.service.LearningRequestService;

@WebServlet("/pages/learning-request")
public class LearningRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private LearningRequestService learningRequestService;

    @Override
    public void init() throws ServletException {
        learningRequestService = new LearningRequestService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");

            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {

            // Get selected skill
            String skillIdParameter = request.getParameter("skillId");

            if (skillIdParameter == null || skillIdParameter.trim().isEmpty()) {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=invalid");

                return;
            }

            int skillId = Integer.parseInt(skillIdParameter);

            // Get request message
            String message = request.getParameter("message");

            // Create LearningRequest object
            LearningRequest learningRequest = new LearningRequest();

            learningRequest.setSenderUserId(loggedInUser.getUserId());

            learningRequest.setSkillId(skillId);

            learningRequest.setRequestMessage(message);

            // Service handles:
            // - Skill existence
            // - Self-request
            // - Duplicate Pending
            // - Receiver
            // - Pending status
            // - Database insertion
            String result = learningRequestService.createLearningRequest(learningRequest);

            // Handle result
            if ("SUCCESS".equals(result)) {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=success");

            } else if ("SELF_REQUEST".equals(result)) {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=self");

            } else if ("DUPLICATE_PENDING".equals(result)) {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=duplicate");

            } else if ("SKILL_NOT_FOUND".equals(result)) {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=notfound");
            } else {

                response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/requests.jsp?request=failed");
        }
    }
    
    // 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {

            // Get skill ID
            String skillIdParameter = request.getParameter("skillId");

            if (skillIdParameter == null || skillIdParameter.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/skills?request=invalid");
                return;
            }

            int skillId = Integer.parseInt(skillIdParameter);

            // Find selected skill
            SkillDAO skillDAO = new com.skillsharehub.dao.SkillDAO();

            Skill skill = skillDAO.getSkillById(skillId);

            // Skill not found
            if (skill == null) {
                response.sendRedirect(request.getContextPath() + "/pages/skills?request=notfound");
                return;
            }

            // Send skill to form
            request.setAttribute("skill", skill);

            // Open request form
            request.getRequestDispatcher("/pages/learningRequestForm.jsp").forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(request.getContextPath() + "/pages/skills?request=invalid");

        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/skills?request=failed");
        }
    }
}