<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.skillsharehub.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h1>Welcome, <%= user.getFullName() %>!</h1>

<p>Email: <%= user.getEmail() %></p>

<p>User ID: <%= user.getUserId() %></p>

<a href="logout">Log Out</a>

</body>
</html>