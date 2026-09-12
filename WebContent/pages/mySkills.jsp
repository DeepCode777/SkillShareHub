<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Skills</title>
</head>
<body>
<h1>My Skills</h1>

<a href="${pageContext.request.contextPath}/pages/my-skills/add">+ Add Skill</a>

<%
    List<Skill> mySkills = (List<Skill>) request.getAttribute("mySkills");
    if (mySkills == null || mySkills.isEmpty()) {
%>
    <p>You have not added any skills yet.</p>
<%
    } else {
        for (Skill skill : mySkills) {
%>
    <div>
        <p>
            <strong>Skill Name:</strong>
            <%= skill.getSkillName() %>
        </p>

        <p>
            <strong>Category:</strong>
            <%= skill.getCategoryName() %>
        </p>

        <p>
            <strong>Skill Details:</strong>
            <%= skill.getSkillDetails() %>
        </p>

        <p>
            <strong>Available Mode:</strong>
            <%= skill.getAvailableMode() %>
        </p>
    </div>
		<a href="${pageContext.request.contextPath}/pages/my-skills/edit?skillId=<%= skill.getSkillId() %>">Edit</a>
		
		<form action="${pageContext.request.contextPath}/pages/my-skills/delete" method="post" style="display:inline;"
      		onsubmit="return confirm('Are you sure you want to delete this skill?');">
    		<input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
    		<button type="submit">Delete</button>
		</form>
    <hr>
<%
        }
    }
%>
<br>

<a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Back to Home</a>

</body>
</html>