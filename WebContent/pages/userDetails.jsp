<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.LearningRequest" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%
    User user = (User) request.getAttribute("user");
    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
    List<LearningRequest> receivedRequests = (List<LearningRequest>) request.getAttribute("receivedRequests");
    List<LearningRequest> sentRequests = (List<LearningRequest>) request.getAttribute("sentRequests");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .user-details-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 1000px;
            margin: 0 auto;
        }

        .section-box {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.75rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
            padding-bottom: 0.75rem;
            margin-bottom: 1.25rem;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
            margin-bottom: 1rem;
        }

        .profile-field {
            display: flex;
            flex-direction: column;
        }

        .field-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .field-value {
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text);
            word-break: break-word;
        }

        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.25rem;
        }

        .inner-card {
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .inner-card h3 {
            font-size: 1.15rem;
            margin-bottom: 0.5rem;
        }

        .navigation-bar-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 2rem;
        }

        @media (max-width: 640px) {
            .items-grid {
                grid-template-columns: 1fr;
            }
            .navigation-bar-bottom {
                flex-direction: column;
                align-items: stretch;
            }
            .navigation-bar-bottom .btn {
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
        <div class="container user-details-wrapper">

            <!-- Top Header & Navigation -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.75rem; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">User Details</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Komprehensibo nga impormasion ti profile ken aktibidad ti agar-aramat</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/admin/users" class="btn btn-outline btn-sm">&larr; Back to Users</a>
                </div>
            </div>

            <!-- 1. Profile Information Section -->
            <% if (user != null) { %>
                <div class="section-box">
                    <div class="section-header">
                        <h2 style="font-size: 1.3rem; margin-bottom: 0;">Account Information</h2>
                        <span class="badge badge-category">ID: #<%= user.getUserId() %></span>
                    </div>

                    <div class="profile-grid">
                        <div class="profile-field">
                            <span class="field-label">Full Name</span>
                            <span class="field-value"><%= user.getFullName() %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Email</span>
                            <span class="field-value"><%= user.getEmail() %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Phone</span>
                            <span class="field-value"><%= user.getPhone() != null ? user.getPhone() : "Not Provided" %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Gender</span>
                            <span class="field-value"><%= user.getGender() != null ? user.getGender() : "Not Set" %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Date of Birth</span>
                            <span class="field-value"><%= user.getDate_of_birth() != null ? user.getDate_of_birth() : "Not Set" %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">City</span>
                            <span class="field-value"><%= user.getCity() != null ? user.getCity() : "Not Set" %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Profile Image</span>
                            <span class="field-value"><%= user.getProfileImage() != null ? user.getProfileImage() : "None" %></span>
                        </div>

                        <div class="profile-field">
                            <span class="field-label">Created At</span>
                            <span class="field-value"><%= user.getCreatedAt() != null ? user.getCreatedAt() : "N/A" %></span>
                        </div>
                    </div>

                    <div style="border-top: 1px solid var(--border); padding-top: 1rem; margin-top: 0.5rem;">
                        <span class="field-label">Bio</span>
                        <p class="field-value" style="margin-top: 0.25rem; margin-bottom: 0; color: var(--text-muted); line-height: 1.6;">
                            <%= (user.getBio() != null && !user.getBio().trim().isEmpty()) ? user.getBio() : "No bio provided." %>
                        </p>
                    </div>
                </div>
            <% } else { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Awan ti masarakan a datos ti user.</span>
                </div>
            <% } %>

            <!-- 2. Skills Section -->
            <div class="section-box">
                <div class="section-header">
                    <h2 style="font-size: 1.3rem; margin-bottom: 0;">Skills Offered</h2>
                </div>

                <% if (skills != null && !skills.isEmpty()) { %>
                    <div class="items-grid">
                        <% for (Skill skill : skills) { %>
                            <div class="inner-card">
                                <div>
                                    <h3><%= skill.getSkillName() %></h3>
                                    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 0.75rem;">
                                        <span class="badge badge-category"><%= skill.getCategoryName() %></span>
                                        <span class="badge badge-level">Mode: <%= skill.getAvailableMode() %></span>
                                    </div>
                                    <p style="font-size: 0.875rem; color: var(--text-muted); margin-bottom: 0; line-height: 1.5;">
                                        <%= skill.getSkillDetails() %>
                                    </p>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-state" style="padding: 2rem 1rem; margin: 0;">
                        <p class="empty-state-desc" style="margin-bottom: 0;">Awan ti skills a nasarakan para iti daytoy nga agar-aramat.</p>
                    </div>
                <% } %>
            </div>

            <!-- 3. Received Requests Section -->
            <div class="section-box">
                <div class="section-header">
                    <h2 style="font-size: 1.3rem; margin-bottom: 0;">Learning Requests Received</h2>
                </div>

                <% if (receivedRequests != null && !receivedRequests.isEmpty()) { %>
                    <div class="items-grid">
                        <% for (LearningRequest requestData : receivedRequests) { %>
                            <div class="inner-card">
                                <div>
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                                        <span class="badge badge-pending"><%= requestData.getRequestStatus() %></span>
                                        <small class="text-muted"><%= requestData.getRequestDate() %></small>
                                    </div>
                                    <p style="font-size: 0.9rem; margin-bottom: 0.25rem;">
                                        <strong>From:</strong> <%= requestData.getSenderName() %>
                                    </p>
                                    <p style="font-size: 0.9rem; margin-bottom: 0.5rem;">
                                        <strong>Skill:</strong> <%= requestData.getSkillName() != null ? requestData.getSkillName() : "Skill no longer available" %>
                                    </p>
                                    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0; line-height: 1.5;">
                                        <%= requestData.getRequestMessage() %>
                                    </p>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-state" style="padding: 2rem 1rem; margin: 0;">
                        <p class="empty-state-desc" style="margin-bottom: 0;">Awan ti naawat a learning requests.</p>
                    </div>
                <% } %>
            </div>

            <!-- 4. Sent Requests Section -->
            <div class="section-box">
                <div class="section-header">
                    <h2 style="font-size: 1.3rem; margin-bottom: 0;">Learning Requests Sent</h2>
                </div>

                <% if (sentRequests != null && !sentRequests.isEmpty()) { %>
                    <div class="items-grid">
                        <% for (LearningRequest requestData : sentRequests) { %>
                            <div class="inner-card">
                                <div>
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                                        <span class="badge badge-level"><%= requestData.getRequestStatus() %></span>
                                        <small class="text-muted"><%= requestData.getRequestDate() %></small>
                                    </div>
                                    <p style="font-size: 0.9rem; margin-bottom: 0.25rem;">
                                        <strong>To:</strong> <%= requestData.getReceiverName() %>
                                    </p>
                                    <p style="font-size: 0.9rem; margin-bottom: 0.5rem;">
                                        <strong>Skill:</strong> <%= requestData.getSkillName() != null ? requestData.getSkillName() : "Skill no longer available" %>
                                    </p>
                                    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0; line-height: 1.5;">
                                        <%= requestData.getRequestMessage() %>
                                    </p>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-state" style="padding: 2rem 1rem; margin: 0;">
                        <p class="empty-state-desc" style="margin-bottom: 0;">Awan ti naipatulod a learning requests.</p>
                    </div>
                <% } %>
            </div>

            <!-- Bottom Navigation Bar -->
            <div class="navigation-bar-bottom">
                <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn btn-outline">&larr; Back to Admin Panel</a>
                <a href="${pageContext.request.contextPath}/pages/admin/users" class="btn btn-primary">Back to Users</a>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>