<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.Skill" %>
<%
    Skill skill = (Skill) request.getAttribute("skill");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Request to Learn</title>
</head>
<body>
    <h1>Request to Learn</h1>
    <h2><%= skill.getSkillName() %></h2>
    <p>
        <strong>Category:</strong>
        <%= skill.getCategoryName() %>
    </p>

    <p>
        <strong>Skill Owner:</strong>
        <%= skill.getUserName() %>
    </p>

    <p>
        <strong>Details:</strong>
        <%= skill.getSkillDetails() %>
    </p>
    <hr>

    <form action="${pageContext.request.contextPath}/pages/learning-request" method="post">
        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

        <label for="message">Message:</label>
        <br>
        <textarea id="message" name="message" rows="5" cols="50" required></textarea>

        <br><br>
        <button type="submit">Send Learning Request</button>
    </form>
    
    <br>
    <a href="${pageContext.request.contextPath}/pages/skills">Back to Skills</a>
</body>
</html>