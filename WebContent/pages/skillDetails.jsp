<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillsharehub.model.Skill" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skill Details</title>
</head>
<body>
<%
    Skill skill = (Skill) request.getAttribute("skill");
    if (skill == null) {
%>
    <h1>Skill Not Found</h1>
    <p>The requested skill could not be found.</p>
<%
    } else {
%>
    <h1>Skill Details</h1>
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

    <p>
        <strong>Skill Owner:</strong>
        <%= skill.getUserName() %>
    </p>

    <%-- <p>
        <strong>Skill ID:</strong>
        <%= skill.getSkillId() %>
    </p> --%>
    <br>
    <%
        if (skill.getAvailableMode() != null
                && skill.getAvailableMode().equals("Yes")) {
    %>
        <form action="${pageContext.request.contextPath}/pages/learning-request" method="get">
            <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
            <button type="submit">Request to Learn</button>
        </form>
	    <%
	        }
	    %>
	<%
	    }
	%>
<br>
<a href="${pageContext.request.contextPath}/pages/skills">Back to Skills</a>

</body>
</html>