<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>
<%
    String viewStatus = request.getParameter("view");
    String deleteStatus = request.getParameter("delete");
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - SkillShareHub Admin</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-users-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 1300px;
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

        .bio-cell {
            max-width: 180px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .action-cell {
            white-space: nowrap;
            display: flex;
            gap: 0.4rem;
            align-items: center;
        }

        .action-cell form {
            margin: 0;
            display: inline;
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="/includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container admin-users-wrapper">

            <!-- Header and Navigation -->
            <div class="admin-page-header">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Manage Users</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Audit registered member accounts, inspect profiles, and manage access</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn btn-outline btn-sm">&larr; Back to Admin Panel</a>
                </div>
            </div>

            <!-- Feedback Alerts -->
            <% if ("notfound".equals(viewStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ User not found.</span>
                </div>
            <% } else if ("error".equals(viewStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Unable to load user details.</span>
                </div>
            <% } %>

            <% if ("success".equals(deleteStatus)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ User deleted successfully.</span>
                </div>
            <% } else if ("failed".equals(deleteStatus)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Failed to delete user.</span>
                </div>
            <% } %>

            <!-- Users Data Table -->
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Date of Birth</th>
                            <th>City</th>
                            <th>Bio</th>
                            <th>Profile Image</th>
                            <th>Created At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users != null && !users.isEmpty()) { %>
                            <% for (User userItem : users) { %>
                                <tr>
                                    <td><strong>#<%= userItem.getUserId() %></strong></td>
                                    <td><%= userItem.getFullName() != null ? userItem.getFullName() : "-" %></td>
                                    <td><%= userItem.getEmail() != null ? userItem.getEmail() : "-" %></td>
                                    <td><%= userItem.getPhone() != null ? userItem.getPhone() : "-" %></td>
                                    <td>
                                        <span class="badge badge-category"><%= userItem.getGender() != null ? userItem.getGender() : "N/A" %></span>
                                    </td>
                                    <td><%= userItem.getDate_of_birth() != null ? userItem.getDate_of_birth() : "-" %></td>
                                    <td><%= userItem.getCity() != null ? userItem.getCity() : "-" %></td>
                                    <td class="bio-cell" title="<%= userItem.getBio() != null ? userItem.getBio() : "" %>">
                                        <%= (userItem.getBio() != null && !userItem.getBio().trim().isEmpty()) ? userItem.getBio() : "-" %>
                                    </td>
                                    <td>
                                        <%= (userItem.getProfileImage() != null && !userItem.getProfileImage().trim().isEmpty()) ? userItem.getProfileImage() : "None" %>
                                    </td>
                                    <td><%= userItem.getCreatedAt() != null ? userItem.getCreatedAt() : "-" %></td>
                                    <td>
                                        <div class="action-cell">
                                            <!-- View Form -->
                                            <form method="post" action="${pageContext.request.contextPath}/pages/admin/users">
                                                <input type="hidden" name="action" value="view">
                                                <input type="hidden" name="userId" value="<%= userItem.getUserId() %>">
                                                <button type="submit" class="btn btn-outline btn-sm">View</button>
                                            </form>

                                            <!-- Delete Form -->
                                            <form method="post" action="${pageContext.request.contextPath}/pages/admin/users">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="<%= userItem.getUserId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are You sure want to delete this user?');">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="11" class="text-center" style="padding: 2.5rem 1rem;">
                                    <p class="text-muted" style="margin-bottom: 0;">No users found in the system.</p>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Bottom Return Link -->
            <div style="margin-top: 1.5rem;">
                <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn btn-outline">&larr; Back to Admin Panel</a>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>