<%@ page import="com.skillsharehub.model.Category" %>

<%
    Category category =
            (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Category - SkillShareHub</title>
</head>
<body>

    <h1>Edit Category</h1>

    <form action="${pageContext.request.contextPath}/pages/admin/categories" method="post" enctype="multipart/form-data">
		
		<div>
			<input type="hidden" name="action" value="update">
	        <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
		</div>
	        
		<div>
			<label>Category Name:</label>
	        <input type="text" name="categoryName" value="<%= category.getCategoryName() %>" required>
		</div>

        <br><br>
		<div>
			<label>Current Icon:</label>
			<br>
	        <img src="${pageContext.request.contextPath}/images/categories/<%= category.getCategoryIcon() %>" alt="<%= category.getCategoryName() %>" width="60" height="60">
		</div>
	        
        <br><br>
		<div>
			<label>New Category Icon (.png):</label>
	        <input type="file" name="categoryIcon" accept=".png">
		</div>
        <br><br>

        <button type="submit">Update Category</button>

    </form>

    <br>

    <a href="${pageContext.request.contextPath}/pages/admin/categories">Cancel</a>

</body>
</html>