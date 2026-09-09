<%--- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<jsp:include page="../includes/navbar.jsp"/>

    <h1 class="page-title text-center">Login</h1>

    <div>

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
		
		<p class="register-link">Don't have an account?
			<a href="register.jsp">Create New Account</a>
		</p>
    </div>

	<script src="../js/login.js"></script>
	<jsp:include page="../includes/footer.jsp"/>
</body>
</html>
---%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Skill Share Hub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<main>

    <div class="container page">

        <div class="login-container">

            <h1 class="page-title text-center">Login</h1>

            <div class="card login-card">

                <form action="login" method="post">

                    <div class="form-group">
                        <label for="email">Email ID:</label>
                		<input type="email" id="email" name="email" class="form-control" placeholder="Email ID" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                		<input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
                    </div>

                    <button type="submit" class="btn-primary">Login</button>

                </form>

                <p class="register-link">
                    Don't have an account?
                    <a href="register.jsp">Create New Account</a>
                </p>

            </div>

        </div>

    </div>

</main>
<script src="../js/login.js"></script>
</body>
</html>