<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Skill Share Hub</title>
</head>
<body>

    <h2>Admin Login</h2>
	<div>
    <form action="adminLogin" method="post">
		<div>
			<label for="username">Username:</label>
        	<input type="text" id="username" name="username" required>
		</div>
        
		<div>
			<label for="password">Password:</label>
        	<input type="password" id="password" name="password" required>	
		</div>
        
        <div>
        	<button type="submit">Login</button>
        </div>

    </form>
	</div>
</body>
</html>