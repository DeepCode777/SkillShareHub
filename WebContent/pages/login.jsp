<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

    <h1>Login</h1>

    <div class="form-container">

        <form action="login" method="post" id="loginForm">

            <div class="container">
                <label>Email ID:</label>
                <input type="email" name="email" placeholder="Email ID" required>
            </div>

            <div class="container">
                <label>Password:</label>
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <button type="submit">Login</button>

        </form>

    </div>
	<script src="../js/login.js"></script>
</body>
</html>