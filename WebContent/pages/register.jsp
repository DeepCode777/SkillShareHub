<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body>
	<h1>Register</h1>
 <div class="form-container">
  <form action="register" method="post" enctype="multipart/form-data">

    <div class="container">
      <label>Full name: </label>
      <input type="text" name="fullname" placeholder="Full name" required>
    </div>
    
    <div class="container">
      <label>Email ID: </label>
      <input type="email" name="email" placeholder="Email ID" required>
    </div>
    
    <div class="container">
      <label>Password: </label>
      <input type="password" name="password" placeholder="Password" required>
    </div>
    
    <br><br>
    
    <div class="container">
      <label>Phone: </label>
      <input type="text" name="phone" placeholder="Phone" required>
    </div>

    <div class="container">
      <label>Gender: </label>
      <input type="radio" name="gender" value="Male" required> Male
      <input type="radio" name="gender" value="Female" required> Female
      <input type="radio" name="gender" value="Other" required> Other
    </div>

    <div class="container">
      <label>Date of Birth: </label>
      <input type="date" name="dob" required>
    </div>

    <div class="container">
      <label>City: </label>
      <input type="text" name="city" placeholder="City" required>
    </div>
    
    <div class="container">
      <label>Bio: </label>
      <textarea name="bio" placeholder="Tell us about yourself"></textarea>
    </div>

    <div class="container">
      <label>Profile Picture: </label>
      <input type="file" name="profilePicture">
    </div>

    <button type="submit">Register</button>
    
  </form>
</div>
</body>
</html>