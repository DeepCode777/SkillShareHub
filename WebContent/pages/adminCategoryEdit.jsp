<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.Category" %>
<%
    Category category = (Category) request.getAttribute("category");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category - SkillShareHub Admin</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-category-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 640px;
            margin: 0 auto;
        }

        .category-edit-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
        }

        .icon-preview-box {
            display: flex;
            align-items: center;
            gap: 1.25rem;
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 1rem 1.25rem;
            margin-bottom: 1.25rem;
        }

        .current-icon-img {
            width: 54px;
            height: 54px;
            object-fit: contain;
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 4px;
        }

        .form-actions-footer {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 1rem;
            margin-top: 1.5rem;
            border-top: 1px solid var(--border);
            padding-top: 1.5rem;
        }

        @media (max-width: 640px) {
            .form-actions-footer {
                flex-direction: column-reverse;
                align-items: stretch;
            }
            .form-actions-footer .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="/includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container admin-category-wrapper">

            <!-- Page Title Header -->
            <div style="margin-bottom: 1.75rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Edit Category</h1>
                <p class="text-muted" style="margin-bottom: 0;">Update category title or replace its display icon</p>
            </div>

            <% if (category == null) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">⚠️</div>
                    <h2 class="empty-state-title">Category Not Found</h2>
                    <p class="empty-state-desc">The requested category could not be retrieved from the database.</p>
                    <a href="${pageContext.request.contextPath}/pages/admin/categories" class="btn btn-primary btn-sm">Return to Categories</a>
                </div>
            <% } else { %>
                <div class="card category-edit-card">
                    <form action="${pageContext.request.contextPath}/pages/admin/categories" method="post" enctype="multipart/form-data">
                        <!-- Hidden Identifiers -->
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">

                        <!-- Category Name -->
                        <div class="form-group">
                            <label class="form-label required">Category Name:</label>
                            <input type="text" 
                                   name="categoryName" 
                                   class="form-control" 
                                   value="<%= category.getCategoryName() %>" 
                                   required>
                        </div>

                        <!-- Current Icon Display -->
                        <div class="icon-preview-box">
                            <img src="${pageContext.request.contextPath}/images/categories/<%= category.getCategoryIcon() %>" 
                                 alt="<%= category.getCategoryName() %> icon" 
                                 class="current-icon-img"
                                 onerror="this.style.display='none'">
                            <div>
                                <strong style="display: block; font-size: 0.9rem; color: var(--text);">Current Icon</strong>
                                <span class="text-muted" style="font-size: 0.8rem;"><%= category.getCategoryIcon() != null ? category.getCategoryIcon() : "No icon specified" %></span>
                            </div>
                        </div>

                        <!-- Replace Icon -->
                        <div class="form-group">
                            <label class="form-label">New Category Icon (.png):</label>
                            <input type="file" 
                                   name="categoryIcon" 
                                   class="form-control" 
                                   accept=".png">
                            <span class="form-text">Leave blank to keep the current icon.</span>
                        </div>

                        <!-- Actions Bar -->
                        <div class="form-actions-footer">
                            <a href="${pageContext.request.contextPath}/pages/admin/categories" class="btn btn-outline">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Category</button>
                        </div>
                    </form>
                </div>
            <% } %>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>