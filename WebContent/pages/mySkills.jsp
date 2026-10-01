<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%
    List<Skill> mySkills = (List<Skill>) request.getAttribute("mySkills");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Skills - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .my-skills-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
        }

        .skills-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .my-skill-card {
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

        .my-skill-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--primary);
        }

        .my-skill-card h3 {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            word-break: break-word;
        }

        .skill-tags {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 1rem;
        }

        .skill-details-text {
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            flex-grow: 1;
            white-space: pre-line;
            word-break: break-word;
        }

        .card-actions {
            border-top: 1px solid var(--border);
            padding-top: 1rem;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 0.75rem;
        }

        @media (max-width: 640px) {
            .skills-header {
                flex-direction: column;
                align-items: stretch;
            }
            .skills-header .btn {
                width: 100%;
            }
            .skills-grid {
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
        <div class="container my-skills-wrapper">

            <!-- Page Header -->
            <div class="skills-header">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">My Skills</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Manage the expertise and topics you share with peers</p>
                </div>
                <div style="display: flex; gap: 0.75rem;">
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline btn-sm">&larr; Back to Home</a>
                    <a href="${pageContext.request.contextPath}/pages/my-skills/add" class="btn btn-primary btn-sm">+ Add Skill</a>
                </div>
            </div>

            <!-- Skills List Grid -->
            <% if (mySkills == null || mySkills.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">💡</div>
                    <div class="empty-state-title">No Skills Added Yet</div>
                    <p class="empty-state-desc">You haven't listed any skills yet. Share what you know to start receiving peer learning requests.</p>
                    <a href="${pageContext.request.contextPath}/pages/my-skills/add" class="btn btn-primary btn-sm">+ Add Your First Skill</a>
                </div>
            <% } else { %>
                <div class="skills-grid">
                    <% for (Skill skill : mySkills) { %>
                        <div class="my-skill-card">
                            <div>
                                <h3><%= skill.getSkillName() %></h3>
                                
                                <div class="skill-tags">
                                    <span class="badge badge-category"><%= skill.getCategoryName() != null ? skill.getCategoryName() : "General" %></span>
                                    <span class="badge badge-level"><%= skill.getAvailableMode() != null ? skill.getAvailableMode() : "Flexible" %></span>
                                </div>

                                <p class="skill-details-text">
                                    <%= skill.getSkillDetails() != null && !skill.getSkillDetails().trim().isEmpty() 
                                        ? skill.getSkillDetails() 
                                        : "No detailed description provided." %>
                                </p>
                            </div>

                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/pages/my-skills/edit?skillId=<%= skill.getSkillId() %>" 
                                   class="btn btn-outline btn-sm">Edit</a>
                                
                                <form action="${pageContext.request.contextPath}/pages/my-skills/delete" 
                                      method="post" 
                                      style="display:inline; margin: 0;"
                                      onsubmit="return confirm('Are you sure you want to delete this skill?');">
                                    <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
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

