<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Category" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add My Skill</title>
</head>
<body>

<h1>Add My Skill</h1>

<%
    String error = request.getParameter("error");

    if ("invalid".equals(error)) {
%>
    <p style="color: red;">Please enter valid skill information.</p>
<%
    } else if ("failed".equals(error)) {
%>
    <p style="color: red;">Unable to add skill.</p>
<%
    }

    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<form action="${pageContext.request.contextPath}/pages/my-skills/add"
      method="post">

    <label for="skillName">Skill Name:</label>
    <input type="text" id="skillName" name="skillName" required>

    <br><br>

    <label for="categoryId">Category:</label>
    <select id="categoryId" name="categoryId" required>
        <option value="">-- Select Category --</option>
        <%
            if (categories != null) {
                for (Category category : categories) {
        %>
            <option value="<%= category.getCategoryId() %>">
                <%= category.getCategoryName() %>
            </option>
        <%
                }
            }
        %>
    </select>

    <br><br>

    <label for="skillDetails">Skill Details:</label>
    <br>
    <textarea id="skillDetails" name="skillDetails" rows="5" cols="40" required></textarea>

    <br><br>

    <label for="availableMode">Available Mode:</label>
    <select id="availableMode" name="availableMode" required>
        <option value="">-- Select Mode --</option>
        <option value="Yes">Yes</option>
        <option value="No">No</option>
        <option value="Cancel">Cancel</option>
    </select>

    <br><br>

    <button type="submit">Add Skill</button>
</form>
<br>

<a href="${pageContext.request.contextPath}/pages/my-skills">Back to My Skills</a>

</body>
</html>