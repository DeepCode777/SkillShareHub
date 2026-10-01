<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%
    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
    String addMessage = request.getParameter("add");
    String editMessage = request.getParameter("edit");
    String deleteMessage = request.getParameter("delete");
    /* String contextPath = request.getContextPath(); */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Skills - SkillShareHub Admin</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <%-- <link rel="stylesheet" href="<%= contextPath %>/css/assets/style2.css"> --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-skills-wrapper {
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

        .header-actions {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }

        .details-cell {
            max-width: 260px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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

        @media (max-width: 640px) {
            .admin-page-header {
                flex-direction: column;
                align-items: stretch;
            }
            .header-actions {
                flex-direction: column-reverse;
            }
            .header-actions .btn {
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
        <div class="container admin-skills-wrapper">

            <!-- Page Header and Main Actions -->
            <div class="admin-page-header">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Manage Skills</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Audit, update, or remove skill listings submitted by platform members</p>
                </div>
                <div class="header-actions">
                    <a href="<%= contextPath %>/pages/admin.jsp" class="btn btn-outline btn-sm">&larr; Back to Admin Panel</a>
                    <a href="${pageContext.request.contextPath}/pages/admin/skills?action=add" class="btn btn-primary btn-sm">+ Add Skill</a>
                </div>
            </div>

            <!-- Feedback Alerts Section -->
            <% if ("success".equals(addMessage)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Skill added successfully.</span>
                </div>
            <% } else if ("failed".equals(addMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Skill could not be added.</span>
                </div>
            <% } %>

            <% if ("success".equals(editMessage)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Skill updated successfully.</span>
                </div>
            <% } else if ("failed".equals(editMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Skill could not be updated.</span>
                </div>
            <% } else if ("notfound".equals(editMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Skill not found.</span>
                </div>
            <% } else if ("invalid".equals(editMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Invalid skill ID.</span>
                </div>
            <% } %>

            <% if ("success".equals(deleteMessage)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Skill deleted successfully.</span>
                </div>
            <% } else if ("failed".equals(deleteMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Skill could not be deleted.</span>
                </div>
            <% } %>

            <!-- Skills Data Table -->
            <% if (skills == null || skills.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🛠️</div>
                    <h2 class="empty-state-title">No Skills Available</h2>
                    <p class="empty-state-desc">There are currently no skills registered in the platform database.</p>
                    <a href="${pageContext.request.contextPath}/pages/admin/skills?action=add" class="btn btn-primary btn-sm">+ Add Skill</a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Skill Name</th>
                                <th>User Name</th>
                                <th>Category</th>
                                <th>Skill Details</th>
                                <th>Available Mode</th>
                                <th style="text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Skill skill : skills) { %>
                                <tr>
                                    <td><strong><%= skill.getSkillName() %></strong></td>
                                    <td><%= skill.getUserName() != null ? skill.getUserName() : "-" %></td>
                                    <td>
                                        <span class="badge badge-category"><%= skill.getCategoryName() != null ? skill.getCategoryName() : "General" %></span>
                                    </td>
                                    <td class="details-cell" title="<%= skill.getSkillDetails() != null ? skill.getSkillDetails() : "" %>">
                                        <%= (skill.getSkillDetails() != null && !skill.getSkillDetails().trim().isEmpty()) ? skill.getSkillDetails() : "-" %>
                                    </td>
                                    <td>
                                        <span class="badge <%= "Yes".equalsIgnoreCase(skill.getAvailableMode()) ? "badge-accepted" : "badge-level" %>">
                                            <%= skill.getAvailableMode() != null ? skill.getAvailableMode() : "N/A" %>
                                        </span>
                                    </td>
                                    <td style="text-align: center;">
                                        <div class="action-cell" style="justify-content: center;">
                                            <!-- Edit Action Form -->
                                            <form action="<%= request.getContextPath() %>/pages/admin/skills" method="get">
                                                <input type="hidden" name="action" value="edit">
                                                <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
                                                <button type="submit" class="btn btn-outline btn-sm">Edit</button>
                                            </form>

                                            <!-- Delete Action Form -->
                                            <form action="<%= request.getContextPath() %>/pages/admin/skills" method="post"
                                                  onsubmit="return confirm('Are you sure you want to delete this skill?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

            <!-- Bottom Navigation -->
            <div style="margin-top: 1.5rem;">
                <a href="<%= request.getContextPath() %>/pages/admin.jsp" class="btn btn-outline">&larr; Back to Admin Panel</a>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>