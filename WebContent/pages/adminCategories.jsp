<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String addStatus = request.getParameter("add");
    String deleteStatus = request.getParameter("delete");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - SkillShareHub Admin</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-categories-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .admin-page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.75rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .category-management-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            align-items: start;
        }

        .category-icon-preview {
            width: 32px;
            height: 32px;
            object-fit: contain;
            border-radius: var(--radius-sm);
            vertical-align: middle;
            background-color: var(--surface-alt);
            padding: 2px;
        }

        .action-cell {
            white-space: nowrap;
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .action-cell form {
            margin: 0;
            display: inline;
        }

        .form-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
        }

        @media (max-width: 900px) {
            .category-management-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="/includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container admin-categories-wrapper">

            <!-- Page Header and Actions -->
            <div class="admin-page-header">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Manage Categories</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Organize skill disciplines, view existing categories, or introduce new subject areas</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn btn-outline btn-sm">&larr; Back to Admin Panel</a>
                </div>
            </div>

            <!-- Feedback Alerts Section -->
            <% if ("success".equals(addStatus)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Category added successfully.</span>
                </div>
            <% } else if ("failed".equals(addStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Failed to add category. Category name may already exist.</span>
                </div>
            <% } else if ("invalid".equals(addStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Please enter a category name and select an icon.</span>
                </div>
            <% } %>

            <% if ("success".equals(deleteStatus)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Category deleted successfully.</span>
                </div>
            <% } else if ("failed".equals(deleteStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Failed to delete category.</span>
                </div>
            <% } else if ("invalid".equals(deleteStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Invalid category ID.</span>
                </div>
            <% } %>

            <!-- Split Management Layout -->
            <div class="category-management-grid">

                <!-- Categories Table Column -->
                <div>
                    <div style="margin-bottom: 1rem;">
                        <h2 style="font-size: 1.3rem; margin-bottom: 0;">Existing Categories</h2>
                    </div>

                    <% if (categories != null && !categories.isEmpty()) { %>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th style="width: 80px; text-align: center;">Icon</th>
                                        <th>Category Name</th>
                                        <th style="text-align: center; width: 140px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Category category : categories) { %>
                                        <tr>
                                            <td style="text-align: center;">
                                                <img src="${pageContext.request.contextPath}/images/categories/<%= category.getCategoryIcon() %>" 
                                                     alt="<%= category.getCategoryName() %> icon" 
                                                     class="category-icon-preview"
                                                     onerror="this.style.display='none'">
                                            </td>
                                            <td>
                                                <strong><%= category.getCategoryName() %></strong>
                                            </td>
                                            <td style="text-align: center;">
                                                <div class="action-cell" style="justify-content: center;">
                                                    <!-- Edit Button Form -->
                                                    <form action="${pageContext.request.contextPath}/pages/admin/categories" method="get">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
                                                        <button type="submit" class="btn btn-outline btn-sm">Edit</button>
                                                    </form>

                                                    <!-- Delete Button Form -->
                                                    <form action="${pageContext.request.contextPath}/pages/admin/categories" method="post"
                                                          onsubmit="return confirm('Are you sure you want to delete this category? All skills in this category will also be deleted.');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
                                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-state-icon">📂</div>
                            <h3 class="empty-state-title">No Categories Found</h3>
                            <p class="empty-state-desc">No skill categories have been created yet. Add one using the form.</p>
                        </div>
                    <% } %>
                </div>

                <!-- Add Category Column -->
                <div>
                    <div class="card form-card">
                        <h2 style="font-size: 1.3rem; margin-bottom: 1.25rem; border-bottom: 1px solid var(--border); padding-bottom: 0.75rem;">Add Category</h2>

                        <form action="${pageContext.request.contextPath}/pages/admin/categories" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="add">

                            <div class="form-group">
                                <label class="form-label required">Category Name:</label>
                                <input type="text" 
                                       name="categoryName" 
                                       class="form-control" 
                                       placeholder="e.g. Mobile Development, Photography" 
                                       required>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">Category Icon (.png):</label>
                                <input type="file" 
                                       name="categoryIcon" 
                                       class="form-control" 
                                       accept=".png" 
                                       required>
                                <span class="form-text">Upload a clean PNG glyph or transparent icon.</span>
                            </div>

                            <button type="submit" class="btn btn-primary btn-block" style="margin-top: 0.5rem;">Add Category</button>
                        </form>
                    </div>
                </div>

            </div>

            <!-- Bottom Navigation Link -->
            <div style="margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn btn-outline">&larr; Back to Admin Panel</a>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>