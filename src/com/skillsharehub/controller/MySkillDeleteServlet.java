package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;
import com.skillsharehub.model.User;

@WebServlet("/pages/my-skills/delete")
public class MySkillDeleteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SkillDAO skillDAO;

    @Override
    public void init() throws ServletException {
        skillDAO = new SkillDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            String skillIdParameter = request.getParameter("skillId");
            if (skillIdParameter == null || skillIdParameter.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=invalid");
                return;
            }

            int skillId = Integer.parseInt(skillIdParameter);
            if (skillId <= 0) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=invalid");
                return;
            }

            Skill skill = skillDAO.getSkillById(skillId);
            if (skill == null) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=notfound");
                return;
            }

            // Ownership check
            if (skill.getUserId() != loggedInUser.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=unauthorized");
                return;
            }

            boolean deleted = skillDAO.deleteSkillByUser(skillId, loggedInUser.getUserId());
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=invalid");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=failed");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=failed");
        }
    }
}