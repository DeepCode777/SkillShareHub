<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.Skill" %>
<%
    Skill skill = (Skill) request.getAttribute("skill");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= skill != null ? skill.getSkillName() + " - Skill Details" : "Skill Details" %> - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .skill-details-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 820px;
            margin: 0 auto;
        }

        .skill-detail-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 1.5rem;
        }

        .skill-badge-row {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 1rem;
        }

        .details-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 1.25rem;
            margin: 1.5rem 0;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 500;
            color: var(--text);
        }

        .details-body-text {
            color: var(--text);
            font-size: 0.975rem;
            line-height: 1.7;
            white-space: pre-line;
            word-break: break-word;
            margin-bottom: 0;
        }

        .skill-actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            border-top: 1px solid var(--border);
            padding-top: 1.5rem;
            margin-top: 2rem;
        }

        @media (max-width: 640px) {
            .skill-actions-bar {
                flex-direction: column-reverse;
                align-items: stretch;
            }
            .skill-actions-bar .btn,
            .skill-actions-bar form,
            .skill-actions-bar form .btn {
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
        <div class="container skill-details-wrapper">

            <% if (skill == null) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🔍</div>
                    <h1 class="empty-state-title" style="font-size: 1.5rem;">Skill Not Found</h1>
                    <p class="empty-state-desc">The requested skill could not be found or may have been deleted by the owner.</p>
                    <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-primary btn-sm">Browse Available Skills</a>
                </div>
            <% } else { %>

                <div class="card skill-detail-card">
                    <!-- Badges -->
                    <div class="skill-badge-row">
                        <span class="badge badge-category"><%= skill.getCategoryName() != null ? skill.getCategoryName() : "General" %></span>
                        <span class="badge <%= "Yes".equals(skill.getAvailableMode()) ? "badge-accepted" : "badge-rejected" %>">
                            Mode: <%= skill.getAvailableMode() != null ? skill.getAvailableMode() : "Not Specified" %>
                        </span>
                    </div>

                    <!-- Title -->
                    <h1 style="font-size: 2rem; margin-bottom: 0.5rem; word-break: break-word;"><%= skill.getSkillName() %></h1>

                    <!-- Key Metadata Matrix -->
                    <div class="details-info-grid">
                        <div class="info-item">
                            <span class="info-label">Category</span>
                            <span class="info-value"><%= skill.getCategoryName() %></span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">Skill Owner</span>
                            <span class="info-value"><%= skill.getUserName() != null ? skill.getUserName() : "Community Member" %></span>
                        </div>

                        <div class="info-item">
                            <span class="info-label">Available Mode</span>
                            <span class="info-value"><%= skill.getAvailableMode() %></span>
                        </div>
                    </div>

                    <!-- Skill Details Text -->
                    <div>
                        <h2 style="font-size: 1.15rem; margin-bottom: 0.5rem; color: var(--text);">About This Skill</h2>
                        <p class="details-body-text">
                            <%= skill.getSkillDetails() != null && !skill.getSkillDetails().trim().isEmpty()
                                ? skill.getSkillDetails()
                                : "No description has been provided for this skill." %>
                        </p>
                    </div>

                    <!-- Actions -->
                    <div class="skill-actions-bar">
                        <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-outline">&larr; Back to Skills</a>

                        <% if (skill.getAvailableMode() != null && skill.getAvailableMode().equals("Yes")) { %>
                            <form action="${pageContext.request.contextPath}/pages/learning-request" method="get" style="margin: 0;">
                                <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
                                <button type="submit" class="btn btn-primary">Request to Learn</button>
                            </form>
                        <% } %>
                    </div>
                </div>

            <% } %>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>