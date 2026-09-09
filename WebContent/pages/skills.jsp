<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skills</title>
</head>
<body>
    <h1>Available Skills</h1>
    <%
        List<Skill> skills = (List<Skill>) request.getAttribute("skills");

        if (skills == null || skills.isEmpty()) {
    %>

        <p>No skills available.</p>

    <%
        } else {
            for (Skill skill : skills) {
    %>
        <div>
            <h2><%= skill.getSkillName() %></h2>
            <p>
                <strong>Category:</strong>
                <%= skill.getCategoryName() %>
            </p>

            <p>
                <strong>Skill Details:</strong>
                <%= skill.getSkillDetails() %>
            </p>

            <p>
                <strong>Skill Owner:</strong>
                <%= skill.getUserName() %>
            </p>
            <p>
                <strong>Available Mode:</strong>
                <%= skill.getAvailableMode() %>
            </p>
            
            <%
			    if (skill.getAvailableMode() != null && skill.getAvailableMode().equals("Yes")) {
			%>
			    <form action="${pageContext.request.contextPath}/pages/learning-request" method="get">
			        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">
			        <button type="submit">Request to Learn</button>
			    </form>
			<%
			    }
			%>
            <hr>
        </div>
    <%
            }
        }
    %>
</body>
</html>