<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.Category" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Categories - SkillShareHub</title>
</head>
<body>

    <h1>Manage Categories</h1>
    <a href="${pageContext.request.contextPath}/pages/admin.jsp">
        Back to Admin Panel
    </a>
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
                    <th>Category Icon</th>
                    <th>Category Name</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Category category : categories) {
            %>
                <tr>
                    <td><span><img src="${pageContext.request.contextPath}/images/categories/<%= category.getCategoryIcon() %>"
         							width="20"
         							height="20"></span>
         			</td>
                    <td><%= category.getCategoryName() %></td>
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
    
   <h2>Add Category</h2>

<form action="${pageContext.request.contextPath}/pages/admin/categories" method="post" enctype="multipart/form-data" >

    <input type="hidden" name="action" value="add">

	<div>
		<label>Category Name:</label>
    	<input type="text" name="categoryName" required>
	</div>

    <div>
    	<label>Category Icon:</label>
    	<input type="file" name="categoryIcon" accept=".png,.jpg,.jpeg" required>
    </div>
    <br><br>

    <button type="submit">Add Category</button>

</form>

<%
    String addStatus = request.getParameter("add");

    if ("success".equals(addStatus)) {
%>
    <p>Category added successfully.</p>
<%
    } else if ("failed".equals(addStatus)) {
%>
    <p>Failed to add category. Category name may already exist.</p>
<%
    } else if ("invalid".equals(addStatus)) {
%>
    <p>Please enter a category name and icon.</p>
<%
    }
%>

<br>
</body>
</html>