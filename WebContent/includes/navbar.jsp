<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.User" %>
<%@ page import="com.skillsharehub.model.Admin" %>
<%
    User currentUser = (User) session.getAttribute("loggedInUser");
    Admin currentAdmin = (Admin) session.getAttribute("loggedInAdmin");
    String contextPath = request.getContextPath();
%>

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
      <% if (currentAdmin != null) { %>
        <!-- Admin Navigation -->
        <li><a href="<%= contextPath %>/pages/admin.jsp" class="nav-link">Admin Panel</a></li>
        <li><a href="<%= contextPath %>/pages/admin/users" class="nav-link">Users</a></li>
        <li><a href="<%= contextPath %>/pages/admin/categories" class="nav-link">Categories</a></li>
        <li><a href="<%= contextPath %>/pages/admin/skills" class="nav-link">Skills</a></li>
        <li><a href="<%= contextPath %>/pages/logout" class="btn btn-primary btn-sm">Logout</a></li>

      <% } else if (currentUser != null) { %>
        <!-- Authenticated User Navigation -->
        <li><a href="<%= contextPath %>/pages/dashboard.jsp" class="nav-link">Dashboard</a></li>
        <li><a href="<%= contextPath %>/pages/skills" class="nav-link">Explore Skills</a></li>
        <li><a href="<%= contextPath %>/pages/my-skills" class="nav-link">My Skills</a></li>
        <li><a href="<%= contextPath %>/pages/requests" class="nav-link">Requests</a></li>
        <li><a href="<%= contextPath %>/pages/profile" class="nav-link">Profile</a></li>
        <li><a href="<%= contextPath %>/pages/logout"  class="btn btn-primary btn-sm">Logout</a></li>

      <% } else { %>
        <!-- Guest Navigation -->
        <li><a href="<%= contextPath %>/pages/login.jsp" class="nav-link">Explore Skills</a></li>
        <li><a href="<%= contextPath %>/pages/login.jsp" class="nav-link">Login</a></li>
        <li><a href="<%= contextPath %>/pages/register.jsp" class="btn btn-primary btn-sm">Join Free</a></li>
      <% } %>

      <!-- Theme Switcher Button -->
      <li>
        <button type="button" class="theme-toggle-btn" id="themeToggleBtn" aria-label="Toggle visual theme" title="Switch Theme">
          <span id="themeIcon">🌓</span>
        </button>
      </li>
    </ul>
  </div>
</nav>

<style>
  @media (max-width: 768px) {
    .mobile-menu-toggle {
      display: inline-flex !important;
    }
    .nav-links {
      display: none;
      flex-direction: column;
      position: absolute;
      top: var(--nav-height);
      left: 0;
      width: 100%;
      background-color: var(--surface);
      border-bottom: 1px solid var(--border);
      padding: 1.25rem;
      gap: 1rem;
      box-shadow: var(--shadow-md);
    }
    .nav-links.is-open {
      display: flex !important;
    }
    .nav-links li {
      width: 100%;
    }
    .nav-links .btn {
      width: 100%;
    }
  }
</style>