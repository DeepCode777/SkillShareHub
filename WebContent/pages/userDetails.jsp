<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.LearningRequest" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Details</title>
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
	<hr>
	
<%
    List<Skill> skills = (List<Skill>) request.getAttribute("skills");

    if (skills != null && !skills.isEmpty()) {
        for (Skill skill : skills) {
%>
    <div>
    	<h2>Skills</h2>
        <h3><%= skill.getSkillName() %></h3>
        <p><strong>Category:</strong><%= skill.getCategoryName() %></p>
        <p><strong>Details:</strong><%= skill.getSkillDetails() %></p>
        <p><strong>Available Mode:</strong><%= skill.getAvailableMode() %></p>
    </div>
    <hr>
<%
        }
    } else {
%>
    <p>No skills found for this user.</p>
<%
    }

    List<LearningRequest> receivedRequests = (List<LearningRequest>) request.getAttribute("receivedRequests");
    if (receivedRequests != null && !receivedRequests.isEmpty()) {
        for (LearningRequest requestData : receivedRequests) {
%>

    <div>
    	<h2>Learning Requests Received</h2>
        <p><strong>From:</strong><%= requestData.getSenderName() %></p>
        <p><strong>Skill:</strong><%= requestData.getSkillName() != null ? requestData.getSkillName() : "Skill no longer available" %></p>
        <p><strong>Message:</strong><%= requestData.getRequestMessage() %></p>
        <p><strong>Status:</strong><%= requestData.getRequestStatus() %></p>
        <p><strong>Date:</strong><%= requestData.getRequestDate() %></p>
    </div>
    <hr>
<%
        }
    } else {
%>
    <p>No learning requests received.</p>
<%
    }
    
    
    List<LearningRequest> sentRequests = (List<LearningRequest>) request.getAttribute("sentRequests");
    if (sentRequests != null && !sentRequests.isEmpty()) {
        for (LearningRequest requestData : sentRequests) {
%>
    <div>
    <h2>Learning Requests Sent</h2>
        <p><strong>To:</strong><%= requestData.getReceiverName() %></p>
        <p><strong>Skill:</strong><%= requestData.getSkillName() != null ? requestData.getSkillName() : "Skill no longer available" %></p>
        <p><strong>Message:</strong><%= requestData.getRequestMessage() %></p>
        <p><strong>Status:</strong><%= requestData.getRequestStatus() %></p>
        <p><strong>Date:</strong><%= requestData.getRequestDate() %></p>
    </div>

    <hr>

<%
        }
    } else {
%>
    <p>No learning requests sent.</p>
<%
    }
%>

 <h1>Manage Categories</h1>
    <a href="${pageContext.request.contextPath}/pages/admin.jsp">Back to Admin Panel</a>
    <br><br>
    <%
        List<Category> categories = (List<Category>) request.getAttribute("categories");
    %>
    <h2>Categories</h2>
    <%
        if (categories != null && !categories.isEmpty()) {
    %>
        <table border="1" cellpadding="10" cellspacing="0">
            <thead>
                <tr>
                    <th>Category Name</th>
                    <th>Category Icon</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Category category : categories) {
            %>
                <tr>
                    <td><%= category.getCategoryName() %></td>
                    <td><%= category.getCategoryIcon() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>No categories found.</p>
    <%
        }
    %>

	<a href="${pageContext.request.contextPath}/pages/admin/users">Back to Users</a>
</body>
</html>