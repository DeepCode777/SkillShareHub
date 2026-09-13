package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;

@WebServlet("/pages/skill-details")
public class SkillDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SkillDAO skillDAO;

    @Override
    public void init() throws ServletException {
        skillDAO = new SkillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String skillIdParam = request.getParameter("skillId");
        if (skillIdParam == null || skillIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Skill ID is required.");
            return;
        }
        int skillId;
        try {
            skillId = Integer.parseInt(skillIdParam.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid skill ID.");
            return;
        }
        try {
            Skill skill = skillDAO.getSkillById(skillId);
            if (skill == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Skill not found.");
                return;
            }

            request.setAttribute("skill", skill);
            request.getRequestDispatcher("/pages/skillDetails.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load skill details.");
        }
    }
}