<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" href="../css/profile.css">
</head>
<body>
<div class="profile-container">
    <h1>My Profile</h1>
    <%
        User profileUser = (User) request.getAttribute("profileUser");
        if (profileUser == null) {
    %>
        <p style="color: red;">Unable to load profile.</p>
    <%
        } else {
    %>
        <div class="profile-card">
            <%
                if (profileUser.getProfileImage() != null && !profileUser.getProfileImage().trim().isEmpty()) {
            %>
                <div class="profile-image">
                    <img src="${pageContext.request.contextPath}/images/profile/<%= profileUser.getProfileImage() %>" alt="Profile Image" width="100" height="100">
                </div>
            <%
                } else {
            %>
            <div class="profile-image">
    			<div class="default-profile-image">No Image</div>
			</div>
            <%
                }
            %>
            <div class="profile-details">
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
            </div>
        </div>
    <%
        }
    %>
    <br>
    <a href="${pageContext.request.contextPath}/pages/profile/edit">Edit Profile</a>
    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Back to Home</a>
</div>

</body>
</html>