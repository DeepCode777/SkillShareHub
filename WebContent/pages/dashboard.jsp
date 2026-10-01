<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Skill Share Hub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .dashboard-hero {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .user-welcome-info h1 {
            font-size: 1.85rem;
            margin-bottom: 0.35rem;
        }

        .user-meta-tags {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .dashboard-action-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.75rem 1.5rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-decoration: none !important;
            color: var(--text);
            min-height: 180px;
        }

        .dashboard-action-card:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        .dashboard-action-card .card-icon {
            font-size: 2rem;
            margin-bottom: 0.75rem;
            color: var(--primary);
        }

        .dashboard-action-card h3 {
            font-size: 1.25rem;
            margin-bottom: 0.35rem;
        }

        .dashboard-action-card p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .dashboard-action-card .action-link-text {
            color: var(--primary);
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        @media (max-width: 640px) {
            .dashboard-hero {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="/includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container page" style="padding-top: 2rem; padding-bottom: 4rem;">
            
            <!-- Welcome Header Card -->
            <div class="dashboard-hero">
                <div class="user-welcome-info">
                    <h1>Welcome, <%= user.getFullName() %>!</h1>
                    <div class="user-meta-tags">
                        <span class="text-muted" style="font-size: 0.95rem;">Email: <%= user.getEmail() %></span>
                    </div>
                </div>

                <div style="display: flex; gap: 0.75rem;">
                    <a href="${pageContext.request.contextPath}/pages/profile" class="btn btn-outline btn-sm">View Profile</a>
                    <a href="logout" class="btn btn-danger btn-sm">Log Out</a>
                </div>
            </div>

            <!-- Quick Access Navigation Grid -->
            <div class="grid grid-2" style="margin-top: 1rem;">
                
                <!-- Discover Skills -->
                <a href="${pageContext.request.contextPath}/pages/skills" class="dashboard-action-card">
                    <div>
                        <div class="card-icon">🔍</div>
                        <h3>Explore Skills</h3>
                        <p>Browse skills offered by other students and find learning opportunities across multiple domains.</p>
                    </div>
                    <span class="action-link-text">Browse Catalog &rarr;</span>
                </a>

                <!-- My Skills -->
                <a href="${pageContext.request.contextPath}/pages/my-skills" class="dashboard-action-card">
                    <div>
                        <div class="card-icon">💡</div>
                        <h3>My Skills</h3>
                        <p>Manage the skills you share, edit existing offerings, or add new skills you can teach.</p>
                    </div>
                    <span class="action-link-text">Manage My Skills &rarr;</span>
                </a>

                <!-- Learning Requests -->
                <a href="${pageContext.request.contextPath}/pages/requests" class="dashboard-action-card">
                    <div>
                        <div class="card-icon">📬</div>
                        <h3>Learning Requests</h3>
                        <p>Review sent requests to other providers and respond to learning requests you have received.</p>
                    </div>
                    <span class="action-link-text">View Requests &rarr;</span>
                </a>

                <!-- User Profile -->
                <a href="${pageContext.request.contextPath}/pages/profile" class="dashboard-action-card">
                    <div>
                        <div class="card-icon">👤</div>
                        <h3>My Profile</h3>
                        <p>Keep your contact information, personal bio, and profile picture updated for the community.</p>
                    </div>
                    <span class="action-link-text">Edit Details &rarr;</span>
                </a>

            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>
