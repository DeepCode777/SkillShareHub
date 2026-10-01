<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null) {
        errorMessage = request.getParameter("error");
    } */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Skill Share Hub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="../css/assets/style2.css">
    <style>
        .admin-login-wrapper {
            min-height: calc(100vh - var(--nav-height) - 150px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 1rem;
        }

        .admin-login-container {
            width: 100%;
            max-width: 420px;
        }

        .admin-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2.25rem 2rem;
            box-shadow: var(--shadow-sm);
        }

        .admin-badge-indicator {
            display: inline-block;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--primary);
            background-color: var(--primary-light);
            border: 1px solid rgba(37, 99, 235, 0.2);
            padding: 0.25rem 0.65rem;
            border-radius: var(--radius-full);
            margin-bottom: 0.75rem;
        }

        .admin-card .btn-primary {
            width: 100%;
            margin-top: 0.5rem;
        }

        .back-to-client {
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
        <div class="admin-login-wrapper">
            <div class="admin-login-container">
                <div class="text-center" style="margin-bottom: 1.5rem;">
                    <span class="admin-badge-indicator">System Administration</span>
                    <h1 class="page-title" style="font-size: 1.85rem; margin-bottom: 0.25rem;">Admin Login</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Access management and moderation tools</p>
                </div>

                <div class="card admin-card">
                    <!-- Backend Feedback Alert -->
                    <%-- <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
                        <div class="alert alert-danger" role="alert">
                            <span>⚠ <%= errorMessage %></span>
                        </div> 
                    <% } %>--%>

                    <form action="adminLogin" method="post">
                        <div class="form-group">
                            <label for="username" class="form-label required">User name:</label>
                            <input type="text" 
                                   id="username" 
                                   name="username" 
                                   class="form-control" 
                                   placeholder="Enter admin username" 
                                   required 
                                   autocomplete="username">
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label required">Password:</label>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   class="form-control" 
                                   placeholder="Enter admin password" 
                                   required 
                                   autocomplete="current-password">
                        </div>

                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>

                    <p class="back-to-client">
                        Not an administrator?
                        <a href="login.jsp" class="font-medium">User Login</a>
                    </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="../includes/footer.jsp" %>

</body>
</html>