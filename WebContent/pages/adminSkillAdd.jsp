<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.User" %>
<%@ page import="com.skillsharehub.model.Category" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Skill</title>
</head>
<body>

    <h1>Add Skill</h1>

    <p>
        <a href="<%= request.getContextPath() %>/pages/admin/skills">
            Cancel
        </a>
    </p>

    <hr>

    <form action="<%= request.getContextPath() %>/pages/admin/skills" method="post">

        <input type="hidden" name="action" value="add">

        <label>User:</label>
        <select name="userId" required>
            <option value="">-- Select User --</option>

            <% if (users != null) {
                for (User user : users) { %>

                    <option value="<%= user.getUserId() %>">
                        <%= user.getFullName() %>
                    </option>

            <%  }
            } %>

        </select>

		<div>
	        <label>Category:</label>
	        <select name="categoryId" required>
	
	            <option value="">-- Select Category --</option>
	
	            <% if (categories != null) {
	                for (Category category : categories) { %>
	                    <option value="<%= category.getCategoryId() %>">
	                        <%= category.getCategoryName() %>
	                    </option>
	            <%  }
	            } %>
	        </select>
		</div>
		
		<div>
	        <label>Skill Name:</label>
	        <input type="text" name="skillName" required>
		</div>
		
		<div>
	        <label>Skill Details:</label>
	        <textarea name="skillDetails" rows="5" cols="40" required></textarea>
		</div>

		<div>
	        <label>Available Mode:</label>
	        <select name="availableMode" required>
	            <option value="">-- Select Mode --</option>
	            <option value="Yes">Yes</option>
	            <option value="No">No</option>
	            <option value="Cancel">Cancel</option>
	        </select>
		</div>
		
        <br><br>

        <button type="submit">Add Skill</button>

    </form>
</body>
</html>