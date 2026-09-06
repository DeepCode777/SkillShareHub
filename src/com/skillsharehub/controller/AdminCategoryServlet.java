package com.skillsharehub.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.model.Category;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        String action = request.getParameter("action");

        // Edit Category - Open Edit Page
        if ("edit".equals(action)) {

            String categoryIdParameter = request.getParameter("categoryId");

            try {

                int categoryId = Integer.parseInt(categoryIdParameter);

                Category category =
                        categoryDAO.getCategoryById(categoryId);

                if (category == null) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/categories?edit=notfound");

                    return;
                }

                request.setAttribute("category", category);

                RequestDispatcher dispatcher =
                        request.getRequestDispatcher(
                                "/pages/adminCategoryEdit.jsp");

                dispatcher.forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?edit=invalid");

                return;
            }
        }

        // View All Categories
        List<Category> categories =
                categoryDAO.getAllCategories();

        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher(
                        "/pages/adminCategories.jsp");

        dispatcher.forward(request, response);
    }

    // Add Category
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            String categoryName =
                    request.getParameter("categoryName");

            Part iconPart =
                    request.getPart("categoryIcon");

            if (categoryName == null
                    || categoryName.trim().isEmpty()
                    || iconPart == null
                    || iconPart.getSize() == 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=invalid");

                return;
            }

            String fileName =
                    iconPart.getSubmittedFileName();

            if (fileName == null
                    || !fileName.toLowerCase().endsWith(".png")) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=invalid");

                return;
            }

            String uploadPath =
                    getServletContext()
                    .getRealPath("/images/categories");

            File uploadDirectory =
                    new File(uploadPath);

            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdirs();
            }

            String savedFileName =
                    System.currentTimeMillis()
                    + "_" + new File(fileName).getName();

            String filePath =
                    uploadPath
                    + File.separator
                    + savedFileName;

            iconPart.write(filePath);

            Category category =
                    new Category();

            category.setCategoryName(
                    categoryName.trim());

            category.setCategoryIcon(
                    savedFileName);

            boolean added =
                    categoryDAO.addCategory(category);

            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=success");

            } else {

                // Remove uploaded file if database insert failed
                File uploadedFile =
                        new File(filePath);

                if (uploadedFile.exists()) {
                    uploadedFile.delete();
                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?add=failed");
            }

            return;
        }
        
        // Update Category
        if ("update".equals(action)) {

            String categoryIdParameter =
                    request.getParameter("categoryId");

            String categoryName =
                    request.getParameter("categoryName");

            Part iconPart =
                    request.getPart("categoryIcon");

            try {

                int categoryId =
                        Integer.parseInt(categoryIdParameter);

                if (categoryName == null
                        || categoryName.trim().isEmpty()) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/categories?edit=invalid");

                    return;
                }

                Category existingCategory =
                        categoryDAO.getCategoryById(categoryId);

                if (existingCategory == null) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/categories?edit=notfound");

                    return;
                }

                String iconFileName =
                        existingCategory.getCategoryIcon();

                /*
                 * If a new icon is selected,
                 * validate and upload it.
                 */
                if (iconPart != null
                        && iconPart.getSize() > 0) {

                    String originalFileName =
                            iconPart.getSubmittedFileName();

                    if (originalFileName == null
                            || !originalFileName
                                    .toLowerCase()
                                    .endsWith(".png")) {

                        response.sendRedirect(
                                request.getContextPath()
                                + "/pages/admin/categories?edit=invalid");

                        return;
                    }

                    String uploadPath =
                            getServletContext()
                            .getRealPath("/images/categories");

                    File uploadDirectory =
                            new File(uploadPath);

                    if (!uploadDirectory.exists()) {
                        uploadDirectory.mkdirs();
                    }

                    String newIconFileName =
                            System.currentTimeMillis()
                            + "_" + new File(originalFileName).getName();

                    String newFilePath =
                            uploadPath
                            + File.separator
                            + newIconFileName;

                    iconPart.write(newFilePath);

                    iconFileName = newIconFileName;
                }

                Category category =
                        new Category();

                category.setCategoryId(categoryId);
                category.setCategoryName(categoryName.trim());
                category.setCategoryIcon(iconFileName);

                boolean updated =
                        categoryDAO.updateCategory(category);

                if (updated) {

                    /*
                     * Delete old icon only when
                     * a new icon was uploaded.
                     */
                    if (iconPart != null
                            && iconPart.getSize() > 0
                            && existingCategory.getCategoryIcon() != null) {

                        String oldIconPath =
                                getServletContext()
                                .getRealPath(
                                        "/images/categories/"
                                        + existingCategory.getCategoryIcon());

                        File oldIconFile =
                                new File(oldIconPath);

                        if (oldIconFile.exists()) {
                            oldIconFile.delete();
                        }
                    }

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/categories?edit=success");

                } else {

                    /*
                     * If database update failed and a new
                     * icon was uploaded, remove the new icon.
                     */
                    if (iconPart != null
                            && iconPart.getSize() > 0
                            && !iconFileName.equals(
                                    existingCategory.getCategoryIcon())) {

                        String newIconPath =
                                getServletContext()
                                .getRealPath(
                                        "/images/categories/"
                                        + iconFileName);

                        File newIconFile =
                                new File(newIconPath);

                        if (newIconFile.exists()) {
                            newIconFile.delete();
                        }
                    }

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/categories?edit=failed");
                }

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/admin/categories?edit=invalid");
            }
        }

//        // Unknown POST action
//        response.sendRedirect(request.getContextPath() + "/pages/admin/categories");
    }
}