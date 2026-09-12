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

import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Category;
import com.skillsharehub.model.Skill;
import com.skillsharehub.model.User;

@WebServlet("/pages/my-skills/edit")
public class MySkillEditServlet extends HttpServlet {

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

            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("skill", skill);
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/pages/mySkillEdit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=invalid");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load skill.");
        }
    }
    
    //
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
            String categoryIdParameter = request.getParameter("categoryId");
            String skillName = request.getParameter("skillName");
            String skillDetails = request.getParameter("skillDetails");
            String availableMode = request.getParameter("availableMode");

            if (skillIdParameter == null || skillIdParameter.trim().isEmpty()
                    || categoryIdParameter == null || categoryIdParameter.trim().isEmpty()
                    || skillName == null || skillName.trim().isEmpty()
                    || skillDetails == null || skillDetails.trim().isEmpty()
                    || availableMode == null || availableMode.trim().isEmpty()) {

                response.sendRedirect(request.getContextPath() + "/pages/my-skills/edit?skillId=" + skillIdParameter + "&error=invalid");
                return;
            }

            int skillId = Integer.parseInt(skillIdParameter);
            int categoryId = Integer.parseInt(categoryIdParameter);

            if (skillId <= 0 || categoryId <= 0) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=invalid");
                return;
            }

            // Verify that the skill belongs to the logged-in user.
            Skill existingSkill = skillDAO.getSkillById(skillId);

            if (existingSkill == null) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=notfound");
                return;
            }

            if (existingSkill.getUserId() != loggedInUser.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=unauthorized");
                return;
            }

            Skill skill = new Skill();

            skill.setSkillId(skillId);
            skill.setUserId(loggedInUser.getUserId());
            skill.setCategoryId(categoryId);
            skill.setSkillName(skillName.trim());
            skill.setSkillDetails(skillDetails.trim());
            skill.setAvailableMode(availableMode.trim());

            boolean updated = skillDAO.updateSkillByUser(skill, loggedInUser.getUserId());

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills?skill=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/my-skills/edit?skillId=" + skillId + "&error=failed");
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