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
import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.Category;
import com.skillsharehub.model.User;


@WebServlet("/pages/admin/skills")
public class AdminSkillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SkillDAO skillDAO;
    private UserDAO userDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        skillDAO = new SkillDAO();
        userDAO = new UserDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String action = request.getParameter("action");
			if ("add".equals(action)) {

		        List<User> users = userDAO.getAllUsers();
		        List<Category> categories = categoryDAO.getAllCategories();

		        request.setAttribute("users", users);
		        request.setAttribute("categories", categories);

		        request.getRequestDispatcher("/pages/adminSkillAdd.jsp").forward(request, response);

		        return;
		    }
			
			List<Skill> skills = skillDAO.getAllSkills();
			
			request.setAttribute("skills", skills);

	        request.getRequestDispatcher("/pages/adminSkills.jsp").forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {

            int userId = Integer.parseInt(request.getParameter("userId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            String skillName = request.getParameter("skillName");
            String skillDetails = request.getParameter("skillDetails");
            String availableMode = request.getParameter("availableMode");

            Skill skill = new Skill();

            skill.setUserId(userId);
            skill.setCategoryId(categoryId);
            skill.setSkillName(skillName);
            skill.setSkillDetails(skillDetails);
            skill.setAvailableMode(availableMode);

            boolean result = skillDAO.addSkill(skill);

            if (result) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/skills?add=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/admin/skills?add=failed");
            }
            return;
        }
    }
}