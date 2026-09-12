package com.skillsharehub.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Category;
import com.skillsharehub.model.Skill;
import com.skillsharehub.model.User;

@WebServlet("/pages/my-skills/add")
public class MySkillsAddServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/pages/mySkillAdd.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load categories.");
        }
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
            String categoryIdParameter = request.getParameter("categoryId");
            String skillName = request.getParameter("skillName");
            String skillDetails = request.getParameter("skillDetails");
            String availableMode = request.getParameter("availableMode");

            if (categoryIdParameter == null || categoryIdParameter.trim().isEmpty()
                    || skillName == null || skillName.trim().isEmpty()
                    || skillDetails == null || skillDetails.trim().isEmpty()
                    || availableMode == null || availableMode.trim().isEmpty()) {

                response.sendRedirect(request.getContextPath() + "/pages/my-skills/add?error=invalid");

                return;
            }

            int categoryId = Integer.parseInt(categoryIdParameter);

            if (categoryId <= 0) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills/add?error=invalid");
                return;
            }

            Skill skill = new Skill();

            // User ID comes from authenticated session.
            skill.setUserId(loggedInUser.getUserId());

            skill.setCategoryId(categoryId);
            skill.setSkillName(skillName.trim());
            skill.setSkillDetails(skillDetails.trim());
            skill.setAvailableMode(availableMode.trim());

            boolean added = skillDAO.addSkill(skill);

            if (added) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills/add?error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/my-skills/add?error=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/my-skills/add?error=failed");
        }
    }
}