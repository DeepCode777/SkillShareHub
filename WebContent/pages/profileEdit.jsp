<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.skillsharehub.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
</head>
<body>

<h1>Edit Profile</h1>

<%
    User profileUser = (User) request.getAttribute("profileUser");

    if (profileUser == null) {
%>

    <p style="color: red;">Unable to load profile.</p>

<%
    } else {
%>

<form action="${pageContext.request.contextPath}/pages/profile/edit"
      method="post"
      enctype="multipart/form-data">

    <div>
        <label>Full Name:</label>
        <input type="text"
               name="fullName"
               value="<%= profileUser.getFullName() %>"
               required>
    </div>

    <br>

    <div>
        <label>Email:</label>
        <input type="email"
               value="<%= profileUser.getEmail() %>"
               readonly>
    </div>

    <br>

    <div>
        <label>Phone:</label>
        <input type="text"
               name="phone"
               value="<%= profileUser.getPhone() %>"
               required>
    </div>

    <br>

    <div>
        <label>Gender:</label>

        <input type="radio"
               name="gender"
               value="Male"
               <%= "Male".equals(profileUser.getGender()) ? "checked" : "" %>>
        Male

        <input type="radio"
               name="gender"
               value="Female"
               <%= "Female".equals(profileUser.getGender()) ? "checked" : "" %>>
        Female

        <input type="radio"
               name="gender"
               value="Other"
               <%= "Other".equals(profileUser.getGender()) ? "checked" : "" %>>
        Other
    </div>

    <br>

    <div>
        <label>Date of Birth:</label>
        <input type="date"
               name="dob"
               value="<%= profileUser.getDate_of_birth() %>"
               required>
    </div>

    <br>

    <div>
        <label>City:</label>
        <input type="text"
               name="city"
               value="<%= profileUser.getCity() %>"
               required>
    </div>

    <br>

    <div>
        <label>Bio:</label>
        <textarea name="bio"
                  rows="5"
                  cols="40"><%= profileUser.getBio() != null
                      ? profileUser.getBio() : "" %></textarea>
    </div>

    <br>

    <div>
        <label>Current Profile Image:</label>
        <br>

        <%
            if (profileUser.getProfileImage() != null
                    && !profileUser.getProfileImage().trim().isEmpty()) {
        %>

            <img src="${pageContext.request.contextPath}/images/profile/<%= profileUser.getProfileImage() %>"
                 alt="Profile Image"
                 width="150"
                 height="150">

        <%
            } else {
        %>

            <p>No profile image available.</p>

        <%
            }
        %>
    </div>

    <br>

    <div>
        <label>Change Profile Image:</label>
        <input type="file"
               name="profilePicture"
               accept=".jpg,.jpeg,.png">
    </div>

    <br>

    <button type="submit">Update Profile</button>

</form>

<%
    }
%>

<br>

<a href="${pageContext.request.contextPath}/pages/profile">
    Cancel
</a>

</body>
</html>