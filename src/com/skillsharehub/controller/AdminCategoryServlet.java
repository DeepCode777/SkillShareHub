package com.skillsharehub.controller;

import java.io.IOException;
import java.util.List;
import java.io.File;

import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.model.Category;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet("/pages/admin/categories")
@MultipartConfig
public class AdminCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/adminCategories.jsp");
        dispatcher.forward(request, response);
    }
    
    // Add Category
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            String categoryName = request.getParameter("categoryName");
            Part iconPart = request.getPart("categoryIcon");

            if (categoryName == null
                    || categoryName.trim().isEmpty()
                    || iconPart == null
                    || iconPart.getSize() == 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=invalid");

                return;
            }

            String fileName = iconPart.getSubmittedFileName();

            if (fileName == null
                    || !fileName.toLowerCase().endsWith(".png")) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=invalid");

                return;
            }

            String uploadPath = getServletContext()
                    .getRealPath("/images/categories");

            File uploadDirectory = new File(uploadPath);

            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdirs();
            }

            String savedFileName = System.currentTimeMillis()
                    + "_" + new File(fileName).getName();

            String filePath = uploadPath + File.separator + savedFileName;

            iconPart.write(filePath);

            Category category = new Category();

            category.setCategoryName(categoryName.trim());
            category.setCategoryIcon(savedFileName);

            boolean added = categoryDAO.addCategory(category);

            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=success");

            } else {

                // Remove uploaded file if database insert failed
                File uploadedFile = new File(filePath);

                if (uploadedFile.exists()) {
                    uploadedFile.delete();
                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=failed");
            }
        }
    }
}