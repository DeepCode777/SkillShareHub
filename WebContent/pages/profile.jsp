<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.User" %>
<%
    User profileUser = (User) request.getAttribute("profileUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="../css/assets/style2.css">
    <style>
        .profile-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 820px;
            margin: 0 auto;
        }

        .profile-header-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .avatar-container {
            flex-shrink: 0;
        }

        .avatar-img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-light);
            box-shadow: var(--shadow-sm);
        }

        .avatar-placeholder {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            background-color: var(--surface-alt);
            border: 2px dashed var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
        }

        .profile-title-area h1 {
            font-size: 1.85rem;
            margin-bottom: 0.35rem;
        }

        .profile-badges {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-top: 0.5rem;
        }

        .profile-details-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 0.825rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-size: 1rem;
            color: var(--text);
            font-weight: 500;
            word-break: break-word;
        }

        .bio-section {
            border-top: 1px solid var(--border);
            padding-top: 1.5rem;
        }

        .profile-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        @media (max-width: 640px) {
            .profile-header-card {
                flex-direction: column;
                text-align: center;
                padding: 1.75rem 1.25rem;
                gap: 1.25rem;
            }
            .profile-badges {
                justify-content: center;
            }
            .profile-actions {
                flex-direction: column;
                align-items: stretch;
            }
            .profile-actions .btn {
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
        <div class="container profile-wrapper">

            <% if (profileUser == null) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Unable to load profile. Please sign in or try again later.</span>
                </div>
                <div class="empty-state">
                    <div class="empty-state-icon">👤</div>
                    <div class="empty-state-title">Profile Unavailable</div>
                    <p class="empty-state-desc">The requested user profile could not be retrieved.</p>
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-primary btn-sm">Back to Home</a>
                </div>
            <% } else { %>

                <!-- Profile Top Header Card -->
                <div class="profile-header-card">
                    <div class="avatar-container">
                        <% if (profileUser.getProfileImage() != null && !profileUser.getProfileImage().trim().isEmpty()) { %>
                            <img src="${pageContext.request.contextPath}/images/profile/<%= profileUser.getProfileImage() %>" 
                                 alt="<%= profileUser.getFullName() %> Avatar" 
                                 class="avatar-img"
                                 onerror="this.onerror=null; this.src='https://via.placeholder.com/110?text=User';">
                        <% } else { %>
                            <div class="avatar-placeholder">No Image</div>
                        <% } %>
                    </div>

                    <div class="profile-title-area">
                        <h1><%= profileUser.getFullName() %></h1>
                        <p class="text-muted" style="margin-bottom: 0;"><%= profileUser.getEmail() %></p>
                        <div class="profile-badges">
                            <span class="badge badge-category"><%= (profileUser.getCity() != null && !profileUser.getCity().isEmpty()) ? profileUser.getCity() : "City Not Set" %></span>
                            <span class="badge badge-level"><%= (profileUser.getGender() != null) ? profileUser.getGender() : "Gender Not Set" %></span>
                        </div>
                    </div>
                </div>

                <!-- Complete Information Card -->
                <div class="profile-details-card">
                    <h2 style="font-size: 1.35rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--border); padding-bottom: 0.75rem;">Account Information</h2>
                    
                    <div class="details-grid">
                        <div class="detail-item">
                            <span class="detail-label">Full Name</span>
                            <span class="detail-value"><%= profileUser.getFullName() %></span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">Email Address</span>
                            <span class="detail-value"><%= profileUser.getEmail() %></span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">Phone Number</span>
                            <span class="detail-value"><%= (profileUser.getPhone() != null && !profileUser.getPhone().isEmpty()) ? profileUser.getPhone() : "Not Provided" %></span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">Gender</span>
                            <span class="detail-value"><%= (profileUser.getGender() != null) ? profileUser.getGender() : "Not Specified" %></span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">Date of Birth</span>
                            <span class="detail-value"><%= (profileUser.getDate_of_birth() != null) ? profileUser.getDate_of_birth() : "Not Provided" %></span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">City</span>
                            <span class="detail-value"><%= (profileUser.getCity() != null && !profileUser.getCity().isEmpty()) ? profileUser.getCity() : "Not Provided" %></span>
                        </div>
                    </div>

                    <div class="bio-section">
                        <span class="detail-label">About / Bio</span>
                        <p class="detail-value" style="margin-top: 0.5rem; margin-bottom: 0; line-height: 1.7; color: var(--text-muted);">
                            <%= (profileUser.getBio() != null && !profileUser.getBio().trim().isEmpty()) ? profileUser.getBio() : "No bio provided yet." %>
                        </p>
                    </div>
                </div>

                <!-- Bottom Navigation Actions -->
                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline">&larr; Back to Home</a>
                    <a href="${pageContext.request.contextPath}/pages/profile/edit" class="btn btn-primary">Edit Profile</a>
                </div>

            <% } %>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>