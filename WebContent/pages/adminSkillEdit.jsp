<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Skill" %>
<%@ page import="com.skillsharehub.model.Category" %>

<%
    Skill skill = (Skill) request.getAttribute("skill");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Skill</title>
</head>
<body>
    <h1>Edit Skill</h1>
    <p>
        <a href="<%= request.getContextPath() %>/pages/admin/skills">Back to Manage Skills</a>
    </p>

    <hr>
    <form action="<%= request.getContextPath() %>/pages/admin/skills" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="skillId" value="<%= skill.getSkillId() %>">

        <!-- User / Owner - Read Only -->
        <div>
            <label>User:</label>
            <input type="text" value="<%= skill.getUserName() %>" readonly>
        </div>
        <br>

        <!-- Category -->
        <div>
            <label>Category:</label>
            <select name="categoryId" required>
                <% if (categories != null) {
                    for (Category category : categories) { %>

                        <option value="<%= category.getCategoryId() %>"
                            <%= category.getCategoryId() == skill.getCategoryId()
                                ? "selected" : "" %>>

                            <%= category.getCategoryName() %>

                        </option>
                <%  }
                } %>
            </select>
        </div>
        <br>

        <!-- Skill Name -->
        <div>
            <label>Skill Name:</label>
            <input type="text" name="skillName" value="<%= skill.getSkillName() %>" required>
        </div>
        <br>
        <!-- Skill Details -->
        <div>
            <label>Skill Details:</label>
            <br>
            <textarea name="skillDetails" rows="5" cols="40" required><%= skill.getSkillDetails() %></textarea>
        </div>
        <br>
        <!-- Available Mode -->
        <div>
            <label>Available Mode:</label>
            <select name="availableMode" required>
                <option value="Yes" <%= "Yes".equals(skill.getAvailableMode()) ? "selected" : "" %>> Yes </option>
                <option value="No" <%= "No".equals(skill.getAvailableMode()) ? "selected" : "" %>> No</option>
                <option value="Cancel" <%= "Cancel".equals(skill.getAvailableMode()) ? "selected" : "" %>>Cancel </option>
            </select>
        </div>
        <br><br>
        <button type="submit">Update Skill</button>
    </form>
</body>
</html>