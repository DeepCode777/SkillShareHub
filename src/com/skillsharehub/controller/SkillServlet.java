package com.skillsharehub.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;

@WebServlet("/pages/skills")
public class SkillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SkillDAO skillDAO;

    @Override
    public void init() throws ServletException {
        skillDAO = new SkillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        try {

            List<Skill> skills = skillDAO.getAllSkills();
            // LR Column ID
            System.out.println("Skills loaded : " + skills.size());
            
            request.setAttribute("skills", skills);
            request.getRequestDispatcher("/pages/skills.jsp").forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load skills.");
        }
    }
}