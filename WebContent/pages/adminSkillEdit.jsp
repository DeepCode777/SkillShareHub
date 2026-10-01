<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%
    Skill skill = (Skill) request.getAttribute("skill");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Skill - SkillShareHub Admin</title>
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

            <div style="margin-bottom: 1.75rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Edit Skill</h1>
                <p class="text-muted" style="margin-bottom: 0;">Update details, category taxonomy, or delivery state for this listing</p>
            </div>

            <% if (skill == null) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">⚠️</div>
                    <h2 class="empty-state-title">Skill Not Found</h2>
                    <p class="empty-state-desc">The requested skill record could not be found or loaded.</p>
                    <a href="<%= contextPath %>/pages/admin/skills" class="btn btn-primary btn-sm">Return to Skills</a>
                </div>
            <% } else { %>
                <div class="card admin-form-card">
                    <form action="<%= contextPath %>/pages/admin/skills" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

                        <!-- User (Read Only) & Category -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">User / Provider (Read-only):</label>
                                <input type="text" 
                                       class="form-control" 
                                       value="<%= skill.getUserName() != null ? skill.getUserName() : "Unknown User" %>" 
                                       readonly 
                                       style="background-color: var(--surface-alt); cursor: not-allowed;">
                            </div>

                            <div class="form-group">
                                <label class="form-label required">Category:</label>
                                <select name="categoryId" class="form-control" required>
                                    <% if (categories != null) {
                                        for (Category category : categories) { %>
                                            <option value="<%= category.getCategoryId() %>"
                                                <%= category.getCategoryId() == skill.getCategoryId() ? "selected" : "" %>>
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
                                       value="<%= skill.getSkillName() %>" 
                                       required>
                        </div>

                            <div class="form-group">
                                <label class="form-label required">Available Mode:</label>
                                <select name="availableMode" class="form-control" required>
                                    <option value="Yes" <%= "Yes".equals(skill.getAvailableMode()) || "Yes".equals(skill.getAvailableMode()) ? "selected" : "" %>>Yes</option>
                                    <option value="No " <%= "No".equals(skill.getAvailableMode()) || "No ".equals(skill.getAvailableMode()) ? "selected" : "" %>>No</option>
                                    <option value="Cancel" <%= "Cancel".equals(skill.getAvailableMode()) ? "selected" : "" %>>Cancel</option>
                                </select>
                            </div>
                        </div>

                        <!-- Skill Details -->
                        <div class="form-group">
                            <label class="form-label required">Skill Details:</label>
                            <textarea name="skillDetails" 
                                      class="form-control" 
                                      rows="5" 
                                      required><%= skill.getSkillDetails() %></textarea>
                        </div>

                        <!-- Actions -->
                        <div class="form-actions-bar">
                            <a href="<%= contextPath %>/pages/admin/skills" class="btn btn-outline">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Skill</button>
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