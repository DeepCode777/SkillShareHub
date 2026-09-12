<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
</head>
<body>
<h1>My Profile</h1>
<%
    User profileUser = (User) request.getAttribute("profileUser");
    if (profileUser == null) {
%>
    <p style="color: red;">Unable to load profile.</p>
<%
    } else {
%>
<%
    if (profileUser.getProfileImage() != null && !profileUser.getProfileImage().trim().isEmpty()) {
%>
    <div>
        <img src="${pageContext.request.contextPath}/images/profile/<%= profileUser.getProfileImage() %>" alt="Profile Image" width="100" height="100">
    </div>
<%
    } else {
%>
    <p>No profile image available.</p>
<%
    }
%>
    <p>
        <strong>Full Name:</strong>
        <%= profileUser.getFullName() %>
    </p>

    <p>
        <strong>Email:</strong>
        <%= profileUser.getEmail() %>
    </p>

    <p>
        <strong>Phone:</strong>
        <%= profileUser.getPhone() %>
    </p>

    <p>
        <strong>Gender:</strong>
        <%= profileUser.getGender() %>
    </p>

    <p>
        <strong>Date of Birth:</strong>
        <%= profileUser.getDate_of_birth() %>
    </p>

    <p>
        <strong>City:</strong>
        <%= profileUser.getCity() %>
    </p>

    <p>
        <strong>Bio:</strong>
        <%= profileUser.getBio() %>
    </p>
<%
    }
%>
<br>
<a href="${pageContext.request.contextPath}/pages/profile/edit">Edit Profile</a>
<a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Back to Home</a>

</body>
</html>