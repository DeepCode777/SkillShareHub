<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null) {
        errorMessage = request.getParameter("error");
    }
    String registered = request.getParameter("registered");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Skill Share Hub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="../css/assets/style2.css">
    <style>
        .login-wrapper {
            min-height: calc(100vh - var(--nav-height) - 150px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 1rem;
        }
        .login-container {
            width: 100%;
            max-width: 440px;
        }
        .login-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
        }
        .login-card .btn-primary {
            width: 100%;
            margin-top: 0.5rem;
        }
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            margin-bottom: 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="../includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container page login-wrapper">
            <div class="login-container">
                <h1 class="page-title text-center" style="font-size: 1.85rem; margin-bottom: 1.5rem;">Login</h1>

                <div class="card login-card">
                    <!-- Backend Feedback Alerts -->
                    <% if (registered != null) { %>
                        <div class="alert alert-success" role="alert">
                            <span>Registration successful! Please login.</span>
                        </div>
                    <% } %>

                    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
                        <div class="alert alert-danger" role="alert">
                            <span><%= errorMessage %></span>
                        </div>
                    <% } %>

                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="email" class="form-label required">Email ID:</label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="form-control" 
                                   placeholder="Email ID" 
                                   required 
                                   autocomplete="email">
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label required">Password:</label>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   class="form-control" 
                                   placeholder="Password" 
                                   required 
                                   autocomplete="current-password">
                        </div>

                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>

                    <p class="register-link">
                        Don't have an account?
                        <a href="register.jsp" class="font-medium">Create New Account</a>
                    </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="../includes/footer.jsp" %>

    <script src="../js/login.js"></script>
</body>
</html>
