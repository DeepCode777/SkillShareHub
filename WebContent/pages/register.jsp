<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null) {
        errorMessage = request.getParameter("error");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Skill Share Hub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="../css/assets/style2.css">
    <style>
        .register-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            width: 100%;
            max-width: 680px;
        }

        .register-card {
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

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            margin-bottom: 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        @media (max-width: 640px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            .register-card {
                padding: 1.75rem 1.25rem;
            }
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="../includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="register-wrapper">
            <div class="register-container">
                <div class="text-center" style="margin-bottom: 1.5rem;">
                    <h1 class="page-title" style="font-size: 1.85rem; margin-bottom: 0.25rem;">Create an Account</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Join the peer-to-peer skill-sharing community</p>
                </div>

                <div class="card register-card">
                    <!-- Backend Feedback Alert -->
                    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
                        <div class="alert alert-danger" role="alert">
                            <span>⚠ <%= errorMessage %></span>
                        </div>
                    <% } %>

                    <form id="registerForm" action="register" method="post" enctype="multipart/form-data">
                        <!-- Full Name & Email -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Full name:</label>
                                <input type="text" name="fullname" class="form-control" placeholder="Full name" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Email ID:</label>
                                <input type="email" name="email" class="form-control" placeholder="Email ID" required autocomplete="email">
                            </div>
                        </div>

                        <!-- Password & Phone -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Password:</label>
                                <input type="password" name="password" class="form-control" placeholder="Password" required autocomplete="new-password">
                            </div>

                            <div class="form-group">
                                <label class="form-label required">Phone:</label>
                                <input type="text" name="phone" class="form-control" placeholder="Phone" required autocomplete="tel">
                            </div>
                        </div>

                        <!-- Gender & Date of Birth -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Gender:</label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Male" required> Male
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Female" required> Female
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="Other" required> Other
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">Date of Birth:</label>
                                <input type="date" name="dob" class="form-control" required>
                            </div>
                        </div>

                        <!-- City -->
                        <div class="form-group">
                            <label class="form-label required">City:</label>
                            <input type="text" name="city" class="form-control" placeholder="City" required>
                        </div>

                        <!-- Bio -->
                        <div class="form-group">
                            <label class="form-label">Bio:</label>
                            <textarea name="bio" class="form-control" placeholder="Tell us about yourself"></textarea>
                        </div>

                        <!-- Profile Picture -->
                        <div class="form-group">
                            <label class="form-label">Profile Picture:</label>
                            <input type="file" name="profilePicture" class="form-control" accept="image/*">
                        </div>

                        <button type="submit" class="btn btn-primary btn-block" style="margin-top: 0.75rem;">Register</button>
                    </form>

                    <p class="login-link">
                        Already have an account?
                        <a href="login.jsp" class="font-medium">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="../includes/footer.jsp" %>

    <!-- Existing Registration Script -->
    <script src="../js/register.js"></script>
</body>
</html>
