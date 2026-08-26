<%@ page import="com.skillsharehub.model.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	User user = (User)request.getAttribute("user");
%>
	<h2>User Details</h2>
	<p><strong>User ID:</strong> <%= user.getUserId() %></p>
	<p><strong>Full Name:</strong> <%= user.getFullName() %></p>
	<p><strong>Email:</strong> <%= user.getEmail() %></p>
	<p><strong>Phone:</strong> <%= user.getPhone() %></p>
	<p><strong>Gender:</strong> <%= user.getGender() %></p>
	<p><strong>Date of Birth:</strong> <%= user.getDate_of_birth() %></p>
	<p><strong>City:</strong> <%= user.getCity() %></p>
	<p><strong>Bio:</strong> <%= user.getBio() %></p>
	<p><strong>Profile Image:</strong> <%= user.getProfileImage() %></p>
	<p><strong>Created At:</strong> <%= user.getCreatedAt() %></p>
	
	<a href="${pageContext.request.contextPath}/pages/admin/users">Back to Users</a>
</body>
</html>