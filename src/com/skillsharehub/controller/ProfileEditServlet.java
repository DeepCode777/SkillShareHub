package com.skillsharehub.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.skillsharehub.dao.UserDAO;
import com.skillsharehub.model.User;

@MultipartConfig
@WebServlet("/pages/profile/edit")
public class ProfileEditServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {

            int userId = loggedInUser.getUserId();
            User user = userDAO.getUserById(userId);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/pages/profile?profile=notfound");
                return;
            }
            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("/pages/profileEdit.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load edit profile.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        int userId = loggedInUser.getUserId();

        // Full Name
        String fullName = request.getParameter("fullName");
        if (fullName == null || fullName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Full name is required.");
            return;
        }

        fullName = fullName.trim();
        if (fullName.length() < 3) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Full name must contain at least 3 characters.");
            return;
        }

        // Phone
        String phone = request.getParameter("phone");
        if (phone == null || phone.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Phone number is required.");
            return;
        }

        phone = phone.trim();
        if (!phone.matches("^[0-9]{10}$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Phone number must contain exactly 10 digits.");
            return;
        }

        // Gender
        String gender = request.getParameter("gender");
        if (gender == null || gender.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please select your gender.");
            return;
        }

        gender = gender.trim();
        if (!gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid gender selected.");
            return;
        }

        // Date of Birth
        String dob = request.getParameter("dob");

        if (dob == null || dob.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date of birth is required.");
            return;
        }

        Date dateOfBirth;

        try {
            dateOfBirth = Date.valueOf(dob);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date of birth.");
            return;
        }

        Date today = new Date(System.currentTimeMillis());

        if (dateOfBirth.after(today)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date of birth cannot be a future date.");
            return;
        }

        // City
        String city = request.getParameter("city");

        if (city == null || city.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "City is required.");
            return;
        }

        city = city.trim();

        if (city.length() < 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "City name must contain at least 2 characters.");
            return;
        }

        if (!city.matches("^[A-Za-z ]+$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "City name can contain only letters and spaces.");
            return;
        }

        // Bio
        String bio = request.getParameter("bio");

        if (bio != null) {
            bio = bio.trim();

            if (bio.length() > 500) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bio must not exceed 500 characters.");
                return;
            }
        }

        // Get existing user
        User existingUser;
        try {
            existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                response.sendRedirect(request.getContextPath() + "/pages/profile?profile=notfound");
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load user profile.");
            return;
        }

        // Existing profile image
        String profileImageName = existingUser.getProfileImage();

        // New profile image
        Part profilePicture = request.getPart("profilePicture");

        if (profilePicture != null && profilePicture.getSize() > 0) {
            String contentType = profilePicture.getContentType();
            if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only JPG, JPEG, and PNG images are allowed.");
                return;
            }

            long maxSize = 2 * 1024 * 1024;

            if (profilePicture.getSize() > maxSize) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Profile image must not exceed 2 MB.");
                return;
            }

            String uploadPath =
                    getServletContext().getRealPath("/images/profile");

            String originalFileName =
                    profilePicture.getSubmittedFileName();

            if (originalFileName == null || originalFileName.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid profile image filename.");
                return;
            }

            String extension = "";
            int dotIndex = originalFileName.lastIndexOf(".");
            if (dotIndex != -1) {
                extension = originalFileName.substring(dotIndex).toLowerCase();
            }

            profileImageName = UUID.randomUUID().toString() + extension;
            File uploadDirectory = new File(uploadPath);
            if (!uploadDirectory.exists()) {
                if (!uploadDirectory.mkdirs()) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to create image directory.");
                    return;
                }
            }
            String filePath = uploadPath + File.separator + profileImageName;
            profilePicture.write(filePath);
        }

        // Create updated User object
        User user = new User();

        user.setUserId(userId);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setGender(gender);
        user.setDate_of_birth(dateOfBirth);
        user.setCity(city);
        user.setBio(bio);
        user.setProfileImage(profileImageName);

        try {

            boolean updated = userDAO.updateUserProfile(user);
            if (updated) {

                // Update session user data
                user.setEmail(existingUser.getEmail());
                user.setPassword(existingUser.getPassword());
                user.setCreatedAt(existingUser.getCreatedAt());
                session.setAttribute("loggedInUser", user);
                response.sendRedirect(request.getContextPath() + "/pages/profile?profile=updated");

            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Profile update failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred while updating profile.");
        }
    }
}