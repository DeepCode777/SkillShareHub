<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.Category" %>
<%@ page import="com.skillsharehub.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skills</title>
</head>
<body>
    <h1>Available Skills</h1>
    <!-- Search Form -->
    <form action="${pageContext.request.contextPath}/pages/skills" method="get">

        <label for="skillName">Skill Name:</label>
        <input type="text" id="skillName" name="skillName" value="<%= request.getAttribute("searchSkillName") != null ? request.getAttribute("searchSkillName") : "" %>">

        <br><br>

        <label for="categoryId">Category:</label>
        <select id="categoryId" name="categoryId">
            <option value="0"
                <%= ((Integer) request.getAttribute("searchCategoryId") != null
                     && (Integer) request.getAttribute("searchCategoryId") == 0)
                     ? "selected" : "" %>>
                All Categories
            </option>
            <%
			    List<Category> categories = (List<Category>) request.getAttribute("categories");	
			    if (categories != null) {
			        for (Category category : categories) {
			%>
			    <option value="<%= category.getCategoryId() %>"
			        <%= ((Integer) request.getAttribute("searchCategoryId") != null
			             && (Integer) request.getAttribute("searchCategoryId")
			                    == category.getCategoryId())
			             ? "selected" : "" %>>
			        <%= category.getCategoryName() %>
			    </option>
			<%
			        }
			    }
			%>
        </select>

        <br><br>

        <label for="availableMode">Available Mode:</label>
        <select id="availableMode" name="availableMode">
            <option value="" <%= request.getAttribute("searchAvailableMode") == null || request.getAttribute("searchAvailableMode").toString().isEmpty() ? "selected" : "" %>>All Modes</option>
            <option value="Yes" <%= "Yes".equals(request.getAttribute("searchAvailableMode")) ? "selected" : "" %>>Yes</option>
            <option value="No" <%= "No".equals(request.getAttribute("searchAvailableMode")) ? "selected" : "" %>>No</option>
            <option value="Cancel" <%= "Cancel".equals(request.getAttribute("searchAvailableMode")) ? "selected" : "" %>>Cancel</option>
        </select>
        <br><br>
        <button type="submit">Search</button>
        <a href="${pageContext.request.contextPath}/pages/skills">Clear</a>
    </form>
    <hr>
    <%
        List<Skill> skills = (List<Skill>) request.getAttribute("skills");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
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

			<p>
				<a href="${pageContext.request.contextPath}/pages/skill-details?skillId=<%= skill.getSkillId() %>">View Details</a>
			</p>
            	<%
    				if (skill.getAvailableMode() != null
            			&& skill.getAvailableMode().equals("Yes")
            			&& loggedInUser != null
            			&& skill.getUserId() != loggedInUser.getUserId()) {
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
    <br>
    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Back to Home</a>
</body>
</html>