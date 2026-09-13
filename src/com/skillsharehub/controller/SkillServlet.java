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
import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.model.Category;

@WebServlet("/pages/skills")
public class SkillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SkillDAO skillDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        skillDAO = new SkillDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            String skillName = request.getParameter("skillName");
            String categoryParam = request.getParameter("categoryId");
            String availableMode = request.getParameter("availableMode");

            int categoryId = 0;

            if (categoryParam != null && !categoryParam.trim().isEmpty()) {

                try {
                    categoryId = Integer.parseInt(categoryParam.trim());
                    if (categoryId < 0) {
                        categoryId = 0;
                    }
                } catch (NumberFormatException e) {
                    categoryId = 0;
                }
            }

            List<Skill> skills;
            boolean hasSearchFilter = (skillName != null && !skillName.trim().isEmpty())
                                        || categoryId != 0
                                        || (availableMode != null && !availableMode.trim().isEmpty());
            if (hasSearchFilter) {
                skills = skillDAO.searchSkills( skillName, categoryId, availableMode);
            } else {
                skills = skillDAO.getAllSkills();
            }

            request.setAttribute("skills", skills);

            // Keep search values available for the JSP later
            request.setAttribute("searchSkillName", skillName);
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("categories", categories);
            request.setAttribute("searchCategoryId", categoryId);
            request.setAttribute("searchAvailableMode", availableMode);

            request.getRequestDispatcher("/pages/skills.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load skills.");
        }
    }
}