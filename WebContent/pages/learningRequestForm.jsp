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
    <title><%= skill != null ? "Request to Learn " + skill.getSkillName() : "Request to Learn" %> - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .request-form-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 740px;
            margin: 0 auto;
        }

        .skill-summary-box {
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 1.25rem 1.5rem;
            margin-bottom: 1.75rem;
        }

        .skill-summary-meta {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-top: 0.5rem;
            margin-bottom: 0.75rem;
        }

        .request-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
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
        <div class="container request-form-wrapper">

            <div style="margin-bottom: 1.5rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Request to Learn</h1>
                <p class="text-muted" style="margin-bottom: 0;">Connect with the skill provider and explain your learning goals</p>
            </div>

            <% if (skill == null) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">⚠️</div>
                    <h2 class="empty-state-title" style="font-size: 1.4rem;">Skill Unavailable</h2>
                    <p class="empty-state-desc">The skill you want to request cannot be retrieved or is no longer available.</p>
                    <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-primary btn-sm">Browse Available Skills</a>
                </div>
            <% } else { %>

                <div class="card request-card">
                    <!-- Target Skill Overview Box -->
                    <div class="skill-summary-box">
                        <span class="badge badge-category" style="margin-bottom: 0.5rem;"><%= skill.getCategoryName() != null ? skill.getCategoryName() : "General" %></span>
                        <h2 style="font-size: 1.35rem; margin-bottom: 0.25rem; word-break: break-word;"><%= skill.getSkillName() %></h2>

                        <div class="skill-summary-meta">
                            <span><strong>Provider:</strong> <%= skill.getUserName() != null ? skill.getUserName() : "Community Member" %></span>
                        </div>

                        <% if (skill.getSkillDetails() != null && !skill.getSkillDetails().trim().isEmpty()) { %>
                            <p style="font-size: 0.9rem; color: var(--text-muted); margin-bottom: 0; line-height: 1.5;">
                                <%= skill.getSkillDetails() %>
                            </p>
                        <% } %>
                    </div>

                    <!-- Submission Form -->
                    <form id="learningRequestForm" action="${pageContext.request.contextPath}/pages/learning-request" method="post">
                        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

                        <div class="form-group">
                            <label for="message" class="form-label required">Message to Provider:</label>
                            <textarea id="message" 
                                      name="message" 
                                      class="form-control" 
                                      rows="5" 
                                      placeholder="Introduce yourself, mention what you would like to learn, and suggest your preferred collaboration time..." 
                                      required></textarea>
                            <span class="form-text">A clear message helps the provider review and accept your request faster.</span>
                        </div>

                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-outline">Back to Skills</a>
                            <button type="submit" id="submitRequestBtn" class="btn btn-primary">Send Learning Request</button>
                        </div>
                    </form>
                </div>

                <script>
                    (function() {
                        var form = document.getElementById('learningRequestForm');
                        var submitBtn = document.getElementById('submitRequestBtn');
                        if (form && submitBtn) {
                            form.addEventListener('submit', function() {
                                submitBtn.disabled = true;
                                submitBtn.textContent = 'Sending Request...';
                            });
                        }
                    })();
                </script>

            <% } %>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>
