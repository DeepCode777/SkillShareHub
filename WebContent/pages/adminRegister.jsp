<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null) {
        errorMessage = request.getParameter("error");
    } */
    
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Register - Skill Share Hub</title>
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
 <nav class="navbar" role="navigation" aria-label="Main Navigation">
  <div class="container nav-container">
    <!-- Brand Logo & Title -->
    <a href="<%= contextPath %>/" class="nav-brand" aria-label="SkillShareHub Home">
      <img src="<%= contextPath %>/images/logo.png" alt="SkillShareHub Logo" style="height: 42px; width: 42px; border-radius: 50%; object-fit: cover;">
      <span>SkillShare<span style="color: #7FFF00;">Hub</span></span>
    </a>

    <!-- Mobile Menu Toggle Button -->
    <button type="button" class="theme-toggle-btn mobile-menu-toggle" id="mobileMenuBtn" aria-label="Toggle navigation menu" style="display: none;">
      <span id="hamburgerIcon">☰</span>
    </button>

    <!-- Navigation Items -->
    <ul class="nav-links" id="navLinks">
        <!-- Admin Guest Navigation -->
        <li><a href="<%= contextPath %>/pages/login.jsp" class="nav-link">User Login</a></li>
        <li><a href="<%= contextPath %>/pages/adminLogin.jsp" class="nav-link">Admin Login</a></li>
        <li><a href="<%= contextPath %>/pages/adminRegister.jsp" class="btn btn-primary btn-sm">Register</a></li>


      <!-- Theme Switcher Button -->
      <li>
        <button type="button" class="theme-toggle-btn" id="themeToggleBtn" aria-label="Toggle visual theme" title="Switch Theme">
          <span id="themeIcon">🌓</span>
        </button>
      </li>
    </ul>
  </div>
</nav>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="admin-login-wrapper">
            <div class="admin-login-container">
                <div class="text-center" style="margin-bottom: 1.5rem;">
                    <span class="admin-badge-indicator">System Administration</span>
                    <h1 class="page-title" style="font-size: 1.85rem; margin-bottom: 0.25rem;">Admin Register</h1>
                    <p class="text-muted" style="margin-bottom: 0;">For Manage Skill Share Hub Tools</p>
                </div>

                <div class="card admin-card">

                    <form action="adminRegister" method="post">
                        <div class="form-group">
                            <label for="username" class="form-label required">Admin name:</label>
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
                        <!-- <div class="form-group">
                            <label class="form-label required">Enter Any Favorite Character : </label>
                            <input type="text" name="fullname" class="form-control" placeholder="Enter Any Favorite Character" required>
                        </div> -->

                        <button type="submit" class="btn btn-primary">Register</button>
                    </form>

                    <p class="back-to-client">
                        Not an administrator?
                        <a href="adminLogin.jsp" class="font-medium">User Login</a>
                    </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="../includes/adminFooter.jsp" %>

</body>
</html>