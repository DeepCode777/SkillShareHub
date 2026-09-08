<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>

<%
	List<Skill> skills = (List<Skill>) request.getAttribute("skills");
	String addMessage = request.getParameter("add");
	String editMessage = request.getParameter("edit");
	String deleteMessage = request.getParameter("delete");
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
                <th colspan="2">Action</th>
            </tr>
            <% for (Skill skill : skills) { %>
                <tr>
                    <td><%= skill.getUserName() %></td>
                    <td><%= skill.getCategoryName() %></td>
                    <td><%= skill.getSkillName() %></td>
                    <td><%= skill.getSkillDetails() %></td>
                    <td><%= skill.getAvailableMode() %></td>
                    <td>
						<form action="<%= request.getContextPath() %>/pages/admin/skills" method="get">
						    <input type="hidden" name="action" value="edit">
						    <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
 							<button type="submit">Edit</button>
						</form>
					</td>
					<td>
					    <form action="<%= request.getContextPath() %>/pages/admin/skills" method="post"
					    		onsubmit="return confirm('Are you sure you want to delete this skill?');">
					        <input type="hidden" name="action" value="delete">
					        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
					        <button type="submit">Delete</button>
					
					    </form>
					</td>
                </tr>
            <% } %>
        </table>
    <% } %>
    <hr>
    
 <%
    if ("success".equals(addMessage)) {
%>
        <p>Skill added successfully.</p>
<%
    } else if ("failed".equals(addMessage)) {
%>
        <p>Skill could not be added.</p>
<%
    }

    if ("success".equals(editMessage)) {
%>
        <p>Skill updated successfully.</p>
<%
    } else if ("failed".equals(editMessage)) {
%>
        <p>Skill could not be updated.</p>
<%
    } else if ("notfound".equals(editMessage)) {
%>
        <p>Skill not found.</p>
<%
    } else if ("invalid".equals(editMessage)) {
%>
        <p>Invalid skill ID.</p>
<%
    }
    if ("success".equals(deleteMessage)) {
%>
        <p>Skill deleted successfully.</p>
<%
    } else if ("failed".equals(deleteMessage)) {
%>
        <p>Skill could not be deleted.</p>
<%
    }
%>
    <p>
        <a href="<%= request.getContextPath() %>/pages/admin.jsp">Back to Admin Dashboard</a>
    </p>
</body>
</html>