<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Skill - SkillShareHub Admin</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-skill-form-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 760px;
            margin: 0 auto;
        }

        .admin-form-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        .form-actions-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 1rem;
            margin-top: 1.5rem;
            border-top: 1px solid var(--border);
            padding-top: 1.5rem;
        }

        @media (max-width: 640px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            .form-actions-bar {
                flex-direction: column-reverse;
                align-items: stretch;
            }
            .form-actions-bar .btn {
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
        <div class="container admin-skill-form-wrapper">

            <!-- Page Title & Subtitle -->
            <div style="margin-bottom: 1.75rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Add Skill</h1>
                <p class="text-muted" style="margin-bottom: 0;">Create a new skill catalog listing under a designated student account</p>
            </div>

            <!-- Form Card -->
            <div class="card admin-form-card">
                <form action="${pageContext.request.contextPath}/pages/admin/skills" method="post">
                    <input type="hidden" name="action" value="add">

                    <!-- Assign User & Skill Category -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Assign User:</label>
                            <select name="userId" class="form-control" required>
                                <option value="">-- Select User --</option>
                                <% if (users != null) {
                                    for (User user : users) { %>
                                        <option value="<%= user.getUserId() %>">
                                            <%= user.getFullName() %> (ID: #<%= user.getUserId() %>)
                                        </option>
                                <%  }
                                } %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Category:</label>
                            <select name="categoryId" class="form-control" required>
                                <option value="">-- Select Category --</option>
                                <% if (categories != null) {
                                    for (Category category : categories) { %>
                                        <option value="<%= category.getCategoryId() %>">
                                            <%= category.getCategoryName() %>
                                        </option>
                                <%  }
                                } %>
                            </select>
                        </div>
                    </div>

                    <!-- Skill Name & Available Mode -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Skill Name:</label>
                            <input type="text" 
                                   name="skillName" 
                                   class="form-control" 
                                   placeholder="e.g. Data Structures with Java" 
                                   required>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Available Mode:</label>
                            <select name="availableMode" class="form-control" required>
                                <option value="">-- Select Mode --</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                                <option value="Cancel">Cancel</option>
                            </select>
                        </div>
                    </div>

                    <!-- Skill Details -->
                    <div class="form-group">
                        <label class="form-label required">Skill Details:</label>
                        <textarea name="skillDetails" 
                                  class="form-control" 
                                  rows="5" 
                                  placeholder="Describe the topics covered, expectations, and any prerequisites..." 
                                  required></textarea>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions-bar">
                        <a href="${pageContext.request.contextPath}/pages/admin/skills" class="btn btn-outline">Cancel</a>
                        <button type="submit" class="btn btn-primary">Add Skill</button>
                    </div>
                </form>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="../includes/adminFooter.jsp" %>

</body>
</html>