<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	List<User> users = (List<User>)request.getAttribute("users");
%>
<%
    String deleteStatus = request.getParameter("delete");
    if ("success".equals(deleteStatus)) {
%>
    <p>User deleted successfully.</p>
<%
    } else if ("failed".equals(deleteStatus)) {
%>
    <p>Failed to delete user.</p>
<%
    }
%>
	<h2>Manage Users</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Gender</th>
        <th>Date of Birth</th>
        <th>City</th>
        <th>Bio</th>
        <th>Profile Image</th>
        <th>Created At</th>
    </tr>

    <% if (users != null && !users.isEmpty()) { %>

    <% for (User user : users) { %>

        <tr>
            <td><%= user.getUserId() %></td>
            <td><%= user.getFullName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getPhone() %></td>
            <td><%= user.getGender() %></td>
            <td><%= user.getDate_of_birth() %></td>
            <td><%= user.getCity() %></td>
            <td><%= user.getBio() %></td>
            <td><%= user.getProfileImage() %></td>
            <td><%= user.getCreatedAt() %></td>
			<td>
			    <form method="post"
			          action="${pageContext.request.contextPath}/pages/admin/users">
			
			        <input type="hidden" name="action" value="delete">
			
			        <input type="hidden"
			               name="userId"
			               value="<%= user.getUserId() %>">
			
			        <button type="submit" onclick="return confirm('Are You sure want to delete this user?');">Delete</button>
			
			    </form>
			</td>
        </tr>

    <% } %>

<% } else { %>

    <tr>
        <td colspan="11">No users found.</td>
    </tr>

<% } %>

</table>
</body>
</html>