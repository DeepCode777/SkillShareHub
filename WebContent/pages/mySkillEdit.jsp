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
    <title>Edit My Skill - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .skill-form-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 720px;
            margin: 0 auto;
        }

        .skill-form-card {
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

        .form-actions {
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
            .form-actions {
                flex-direction: column-reverse;
                align-items: stretch;
            }
            .form-actions .btn {
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
        <div class="container skill-form-wrapper">

            <div style="margin-bottom: 1.5rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Edit My Skill</h1>
                <p class="text-muted" style="margin-bottom: 0;">Update your skill listing details, category, or availability status</p>
            </div>

            <% if (skill == null) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Skill not found. It may have been removed or you do not have permission to edit it.</span>
                </div>
                <div class="empty-state">
                    <div class="empty-state-icon">🔍</div>
                    <div class="empty-state-title">Skill Unavailable</div>
                    <p class="empty-state-desc">The requested skill record could not be located in the database.</p>
                    <a href="${pageContext.request.contextPath}/pages/my-skills" class="btn btn-primary btn-sm">Back to My Skills</a>
                </div>
            <% } else { %>

                <div class="card skill-form-card">
                    <form action="${pageContext.request.contextPath}/pages/my-skills/edit" method="post">
                        <!-- Authoritative Hidden Skill ID -->
                        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

                        <!-- Skill Name -->
                        <div class="form-group">
                            <label for="skillName" class="form-label required">Skill Name:</label>
                            <input type="text" 
                                   id="skillName" 
                                   name="skillName" 
                                   class="form-control" 
                                   value="<%= skill.getSkillName() %>" 
                                   required>
                        </div>

                        <!-- Category & Available Mode Row -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="categoryId" class="form-label required">Category:</label>
                                <select id="categoryId" name="categoryId" class="form-control" required>
                                    <option value="">-- Select Category --</option>
                                    <%
                                        if (categories != null) {
                                            for (Category category : categories) {
                                    %>
                                        <option value="<%= category.getCategoryId() %>" 
                                                <%= category.getCategoryId() == skill.getCategoryId() ? "selected" : "" %>>
                                            <%= category.getCategoryName() %>
                                        </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="availableMode" class="form-label required">Available Mode:</label>
                                <select id="availableMode" name="availableMode" class="form-control" required>
                                    <option value="Yes" <%= "Yes".equals(skill.getAvailableMode()) ? "selected" : "" %>>Yes</option>
                                    <option value="No" <%= "No".equals(skill.getAvailableMode()) ? "selected" : "" %>>No</option>
                                    <option value="Cancel" <%= "Cancel".equals(skill.getAvailableMode()) ? "selected" : "" %>>Cancel</option>
                                </select>
                            </div>
                        </div>

                        <!-- Skill Details -->
                        <div class="form-group">
                            <label for="skillDetails" class="form-label required">Skill Details:</label>
                            <textarea id="skillDetails" 
                                      name="skillDetails" 
                                      class="form-control" 
                                      rows="5" 
                                      required><%= skill.getSkillDetails() %></textarea>
                        </div>

                        <!-- Actions -->
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/pages/my-skills" class="btn btn-outline">Back to My Skills</a>
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