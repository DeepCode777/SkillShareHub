<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.Admin" %>
<%
    /* Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/pages/adminLogin.jsp");
        return;
    } */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Console - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .admin-dashboard-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 1080px;
            margin: 0 auto;
        }

        .admin-header-banner {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2.25rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .admin-badge {
            display: inline-block;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--primary);
            background-color: var(--primary-light);
            border: 1px solid rgba(37, 99, 235, 0.2);
            padding: 0.2rem 0.6rem;
            border-radius: var(--radius-full);
            margin-bottom: 0.5rem;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .admin-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.75rem 1.5rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: var(--transition);
        }

        .admin-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .admin-card-icon {
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }

        .admin-card h2 {
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .admin-card p {
            font-size: 0.925rem;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 1.5rem;
            flex-grow: 1;
        }

        @media (max-width: 640px) {
            .admin-header-banner {
                flex-direction: column;
                align-items: flex-start;
            }
            .admin-header-banner .btn {
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
        <div class="container admin-dashboard-wrapper">

            <!-- Admin Banner Header -->
            <div class="admin-header-banner">
                <div>
                    <span class="admin-badge">Control Center</span>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Admin Panel</h1>
                    <p class="text-muted" style="margin-bottom: 0;">
                        <%-- Logged in as: <strong><%= admin.getUsername() != null ? admin.getUsername() : "Administrator" %></strong> --%>
                    </p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/logout" class="btn btn-outline btn-sm">Logout</a>
                </div>
            </div>

            <!-- Management Navigation Grid -->
            <div class="admin-grid">

                <!-- 1. Manage Users -->
                <div class="admin-card">
                    <div>
                        <div class="admin-card-icon">👥</div>
                        <h2>Manage Users</h2>
                        <p>View registered students and educators, inspect individual profile records, and perform account administration.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/pages/admin/users" class="btn btn-primary btn-sm">Manage Users &rarr;</a>
                </div>

                <!-- 2. Manage Categories -->
                <div class="admin-card">
                    <div>
                        <div class="admin-card-icon">📂</div>
                        <h2>Manage Categories</h2>
                        <p>Organize platform learning disciplines, add new skill classifications, and update existing taxonomy names.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/pages/admin/categories" class="btn btn-primary btn-sm">Manage Categories &rarr;</a>
                </div>

                <!-- 3. Manage Skills -->
                <div class="admin-card">
                    <div>
                        <div class="admin-card-icon">🛠️</div>
                        <h2>Manage Skills</h2>
                        <p>Audit community skill offerings, modify invalid listings, and moderate peer-to-peer catalog entries.</p>
                    </div>
                    <a href="<%= request.getContextPath() %>/pages/admin/skills" class="btn btn-primary btn-sm">Manage Skills &rarr;</a>
                </div>

            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>
