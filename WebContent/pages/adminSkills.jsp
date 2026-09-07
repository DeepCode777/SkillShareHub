<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>

<%
    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Skills</title>
</head>
<body>
    <h1>Manage Skills</h1>
    <% if (skills == null || skills.isEmpty()) { %>
        <p>No skills available.</p>
    <% } else { %>
        <table border="1">
            <tr>
                <th>User Name</th>
                <th>Category</th>
                <th>Skill Name</th>
                <th>Skill Details</th>
                <th>Available Mode</th>
            </tr>
            <% for (Skill skill : skills) { %>
                <tr>
                    <td><%= skill.getUserName() %></td>
                    <td><%= skill.getCategoryName() %></td>
                    <td><%= skill.getSkillName() %></td>
                    <td><%= skill.getSkillDetails() %></td>
                    <td><%= skill.getAvailableMode() %></td>
                </tr>
            <% } %>
        </table>
    <% } %>
    <hr>
    <p>
        <a href="<%= request.getContextPath() %>/pages/admin.jsp">Back to Admin Dashboard</a>
    </p>
</body>
</html>