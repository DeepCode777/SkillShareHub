<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%@ page import="com.skillsharehub.model.User" %>
<%
    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    String searchSkillName = (String) request.getAttribute("searchSkillName");
    Integer searchCategoryId = (Integer) request.getAttribute("searchCategoryId");
    Object searchAvailableMode = request.getAttribute("searchAvailableMode");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Skills - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .skills-page-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
        }

        .filter-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
        }

        .filter-form-row {
            display: grid;
            grid-template-columns: 2fr 1.5fr 1fr auto;
            gap: 1rem;
            align-items: flex-end;
        }

        .skills-catalog-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .catalog-skill-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: var(--transition);
        }

        .catalog-skill-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--primary);
        }

        .catalog-skill-card h2 {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            word-break: break-word;
        }

        .skill-meta-tags {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 0.85rem;
        }

        .skill-owner-text {
            font-size: 0.875rem;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
        }

        .skill-desc-preview {
            color: var(--text);
            font-size: 0.925rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            flex-grow: 1;
            white-space: pre-line;
            word-break: break-word;
        }

        .card-button-group {
            border-top: 1px solid var(--border);
            padding-top: 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        @media (max-width: 900px) {
            .filter-form-row {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 640px) {
            .filter-form-row {
                grid-template-columns: 1fr;
            }
            .skills-catalog-grid {
                grid-template-columns: 1fr;
            }
            .card-button-group {
                flex-direction: column;
                align-items: stretch;
            }
            .card-button-group .btn, 
            .card-button-group form, 
            .card-button-group form .btn {
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
        <div class="container skills-page-wrapper">

            <!-- Page Header -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.75rem; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Available Skills</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Browse learning opportunities offered by peer community members</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline btn-sm">&larr; Back to Home</a>
                </div>
            </div>

            <!-- Search & Filter Controls -->
            <div class="card filter-card">
                <form action="${pageContext.request.contextPath}/pages/skills" method="get">
                    <div class="filter-form-row">
                        <!-- Skill Name Filter -->
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="skillName" class="form-label">Skill Name:</label>
                            <input type="text" 
                                   id="skillName" 
                                   name="skillName" 
                                   class="form-control" 
                                   placeholder="Search by topic or skill..." 
                                   value="<%= searchSkillName != null ? searchSkillName : "" %>">
                        </div>

                        <!-- Category Filter -->
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="categoryId" class="form-label">Category:</label>
                            <select id="categoryId" name="categoryId" class="form-control">
                                <option value="0" <%= (searchCategoryId != null && searchCategoryId == 0) ? "selected" : "" %>>All Categories</option>
                                <%
                                    if (categories != null) {
                                        for (Category category : categories) {
                                %>
                                    <option value="<%= category.getCategoryId() %>"
                                        <%= (searchCategoryId != null && searchCategoryId == category.getCategoryId()) ? "selected" : "" %>>
                                        <%= category.getCategoryName() %>
                                    </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <!-- Available Mode Filter -->
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="availableMode" class="form-label">Available Mode:</label>
                            <select id="availableMode" name="availableMode" class="form-control">
                                <option value="" <%= (searchAvailableMode == null || searchAvailableMode.toString().isEmpty()) ? "selected" : "" %>>All Modes</option>
                                <option value="Yes" <%= "Yes".equals(searchAvailableMode) ? "selected" : "" %>>Yes</option>
                                <option value="No" <%= "No".equals(searchAvailableMode) ? "selected" : "" %>>No</option>
                                <option value="Cancel" <%= "Cancel".equals(searchAvailableMode) ? "selected" : "" %>>Cancel</option>
                            </select>
                        </div>

                        <!-- Filter Actions -->
                        <div style="display: flex; gap: 0.5rem;">
                            <button type="submit" class="btn btn-primary">Search</button>
                            <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-outline">Clear</a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Skills Display Grid -->
            <% if (skills == null || skills.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🔍</div>
                    <div class="empty-state-title">No Skills Available</div>
                    <p class="empty-state-desc">No skills matched your search criteria. Try adjusting your filter or check back later.</p>
                    <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-outline btn-sm">Reset Filters</a>
                </div>
            <% } else { %>
                <div class="skills-catalog-grid">
                    <% for (Skill skill : skills) { %>
                        <div class="catalog-skill-card">
                            <div>
                                <h2><%= skill.getSkillName() %></h2>

                                <div class="skill-meta-tags">
                                    <span class="badge badge-category"><%= skill.getCategoryName() != null ? skill.getCategoryName() : "General" %></span>
                                    <span class="badge badge-level">Mode: <%= skill.getAvailableMode() != null ? skill.getAvailableMode() : "Flexible" %></span>
                                </div>

                                <p class="skill-owner-text">
                                    <strong>Shared by:</strong> <%= skill.getUserName() != null ? skill.getUserName() : "Community Member" %>
                                </p>

                                <p class="skill-desc-preview">
                                    <%= skill.getSkillDetails() != null && !skill.getSkillDetails().trim().isEmpty() 
                                        ? skill.getSkillDetails() 
                                        : "No detailed description provided." %>
                                </p>
                            </div>

                            <div class="card-button-group">
                                <a href="${pageContext.request.contextPath}/pages/skill-details?skillId=<%= skill.getSkillId() %>" 
                                   class="btn btn-outline btn-sm">View Details</a>

                                <% if (skill.getAvailableMode() != null
                                        && skill.getAvailableMode().equals("Yes")
                                        && loggedInUser != null
                                        && skill.getUserId() != loggedInUser.getUserId()) { %>
                                    <form action="${pageContext.request.contextPath}/pages/learning-request" method="get" style="margin: 0;">
                                        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
                                        <button type="submit" class="btn btn-primary btn-sm">Request to Learn</button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>
