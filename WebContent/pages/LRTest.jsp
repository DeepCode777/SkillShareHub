<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Learning Request Test</title>
</head>
<body>

<h2>Learning Requests Servlet Test</h2>

<form action="${pageContext.request.contextPath}/pages/learning-request" method="post">

    <label>Skill ID:</label>
    <input type="number" name="skillId" required>

    <br><br>

    <label>Message:</label>
    <textarea name="message" required></textarea>

    <br><br>

    <button type="submit">Send Learning Request</button>

</form>

</body>
</html>