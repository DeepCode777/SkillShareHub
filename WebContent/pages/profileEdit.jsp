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
    <title>Edit Profile - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .edit-profile-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 820px;
            margin: 0 auto;
        }

        .edit-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.5rem 2rem;
            box-shadow: var(--shadow-sm);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        .radio-group {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            min-height: 44px;
        }

        .radio-label {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            font-size: 0.95rem;
            color: var(--text);
            cursor: pointer;
        }

        .radio-label input[type="radio"] {
            cursor: pointer;
            accent-color: var(--primary);
            width: 16px;
            height: 16px;
        }

        .avatar-edit-box {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            padding: 1.25rem;
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            margin-bottom: 1.5rem;
        }

        .current-avatar-preview {
            width: 84px;
            height: 84px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--border);
            flex-shrink: 0;
        }

        .avatar-placeholder {
            width: 84px;
            height: 84px;
            border-radius: 50%;
            background-color: var(--surface);
            border: 2px dashed var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 0.75rem;
            font-weight: 600;
            text-align: center;
            flex-shrink: 0;
        }

        .form-actions-footer {
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
            .avatar-edit-box {
                flex-direction: column;
                align-items: flex-start;
            }
            .form-actions-footer {
                flex-direction: column-reverse;
                align-items: stretch;
            }
            .form-actions-footer .btn {
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
        <div class="container edit-profile-wrapper">

            <div style="margin-bottom: 1.5rem;">
                <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Edit Profile</h1>
                <p class="text-muted" style="margin-bottom: 0;">Update your personal information, contact details, and bio</p>
            </div>

            <% if (profileUser == null) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Unable to load profile. Please try signing in again.</span>
                </div>
                <div class="empty-state">
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-primary btn-sm">Return to Dashboard</a>
                </div>
            <% } else { %>

                <div class="card edit-card">
                    <form action="${pageContext.request.contextPath}/pages/profile/edit" method="post" enctype="multipart/form-data">
                        
                        <!-- Current Profile Picture Section -->
                        <div class="avatar-edit-box">
                            <% if (profileUser.getProfileImage() != null && !profileUser.getProfileImage().trim().isEmpty()) { %>
                                <img src="${pageContext.request.contextPath}/images/profile/<%= profileUser.getProfileImage() %>" 
                                     alt="Profile Image" 
                                     class="current-avatar-preview"
                                     onerror="this.onerror=null; this.src='https://via.placeholder.com/84?text=User';">
                            <% } else { %>
                                <div class="avatar-placeholder">No Image</div>
                            <% } %>

                            <div style="flex-grow: 1;">
                                <label class="form-label">Change Profile Image:</label>
                                <input type="file" name="profilePicture" class="form-control" accept=".jpg,.jpeg,.png">
                                <span class="form-text">Supported formats: JPG, JPEG, PNG.</span>
                            </div>
                        </div>

                        <!-- Full Name & Readonly Email -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Full Name:</label>
                                <input type="text" 
                                       name="fullName" 
                                       class="form-control" 
                                       value="<%= profileUser.getFullName() %>" 
                                       required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Email Address (Read-only):</label>
                                <input type="email" 
                                       class="form-control" 
                                       value="<%= profileUser.getEmail() %>" 
                                       readonly 
                                       style="background-color: var(--surface-alt); cursor: not-allowed;">
                            </div>
                        </div>

                        <!-- Phone & Date of Birth -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Phone:</label>
                                <input type="text" 
                                       name="phone" 
                                       class="form-control" 
                                       value="<%= profileUser.getPhone() != null ? profileUser.getPhone() : "" %>" 
                                       required>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">Date of Birth:</label>
                                <input type="date" 
                                       name="dob" 
                                       class="form-control" 
                                       value="<%= profileUser.getDate_of_birth() != null ? profileUser.getDate_of_birth() : "" %>" 
                                       required>
                            </div>
                        </div>

                        <!-- Gender & City -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Gender:</label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Male" <%= "Male".equals(profileUser.getGender()) ? "checked" : "" %>> Male
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Female" <%= "Female".equals(profileUser.getGender()) ? "checked" : "" %>> Female
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Other" <%= "Other".equals(profileUser.getGender()) ? "checked" : "" %>> Other
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">City:</label>
                                <input type="text" 
                                       name="city" 
                                       class="form-control" 
                                       value="<%= profileUser.getCity() != null ? profileUser.getCity() : "" %>" 
                                       required>
                            </div>
                        </div>

                        <!-- Bio Textarea -->
                        <div class="form-group">
                            <label class="form-label">Bio:</label>
                            <textarea name="bio" class="form-control" rows="5" placeholder="Share a few lines about your expertise and learning interests..."><%= profileUser.getBio() != null ? profileUser.getBio() : "" %></textarea>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions-footer">
                            <a href="${pageContext.request.contextPath}/pages/profile" class="btn btn-outline">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
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