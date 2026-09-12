<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.Category" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit My Skill</title>
</head>
<body>
<h1>Edit My Skill</h1>
<%
    Skill skill = (Skill) request.getAttribute("skill");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    if (skill == null) {
%>
    <p style="color: red;">Skill not found.</p>
<%
    } else {
%>
<form action="${pageContext.request.contextPath}/pages/my-skills/edit" method="post">
    <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

    <label for="skillName">Skill Name:</label>
    <input type="text" id="skillName" name="skillName" value="<%= skill.getSkillName() %>" required>
    
    <br><br>

    <label for="categoryId">Category:</label>
    <select id="categoryId" name="categoryId" required>
        <option value="">-- Select Category --</option>
        <%
            if (categories != null) {
                for (Category category : categories) {
        %>
            <option value="<%= category.getCategoryId() %>" <%= category.getCategoryId() == skill.getCategoryId() ? "selected" : "" %>><%= category.getCategoryName() %></option>
        <%
                }
            }
        %>
    </select>

    <br><br>

    <label for="skillDetails">Skill Details:</label>
    <br>
    <textarea id="skillDetails" name="skillDetails" rows="5" cols="40" required><%= skill.getSkillDetails() %></textarea>
    
    <br><br>

    <label for="availableMode">Available Mode:</label>
    <select id="availableMode" name="availableMode" required>
        <option value="Yes" <%= "Yes".equals(skill.getAvailableMode()) ? "selected" : "" %>>Yes</option>
        <option value="No" <%= "No".equals(skill.getAvailableMode()) ? "selected" : "" %>>No</option>
        <option value="Cancel" <%= "Cancel".equals(skill.getAvailableMode()) ? "selected" : "" %>>Cancel</option>
    </select>
    <br><br>
    <button type="submit">Update Skill</button>
</form>
<%
    }
%>
<br>
<a href="${pageContext.request.contextPath}/pages/my-skills">Back to My Skills</a>
</body>
</html>