package com.skillsharehub.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
	private int userId;
	private String fullName;
	private String email;
	private String password;
	private String phone;
	private String gender;
	private Date date_of_birth;
	private String city;
	private String bio;
	private String profileImage;
	private Timestamp createdAt;
	
	
	
	@Override
	public String toString() {
		return "User [userId=" + userId + ", fullName=" + fullName + ", email=" + email 
				+ ", phone=" + phone + ", gender=" + gender + ", date_of_birth=" + date_of_birth + ", city=" + city
				+ ", bio=" + bio + ", profileImage=" + profileImage + ", createdAt=" + createdAt + "]";
	}



	public int getUserId() {
		return userId;
	}



	public void setUserId(int userId) {
		this.userId = userId;
	}



	public String getFullName() {
		return fullName;
	}



	public void setFullName(String fullName) {
		this.fullName = fullName;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getGender() {
		return gender;
	}



	public void setGender(String gender) {
		this.gender = gender;
	}



	public Date getDate_of_birth() {
		return date_of_birth;
	}



	public void setDate_of_birth(Date date_of_birth) {
		this.date_of_birth = date_of_birth;
	}



	public String getCity() {
		return city;
	}



	public void setCity(String city) {
		this.city = city;
	}



	public String getBio() {
		return bio;
	}



	public void setBio(String bio) {
		this.bio = bio;
	}



	public String getProfileImage() {
		return profileImage;
	}



	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}



	public Timestamp getCreatedAt() {
		return createdAt;
	}



	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}



	public User(int userId, String fullName, String email, String password, String phone, String gender,
			Date date_of_birth, String city, String bio, String profileImage, Timestamp createdAt) {
		super();
		this.userId = userId;
		this.fullName = fullName;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.gender = gender;
		this.date_of_birth = date_of_birth;
		this.city = city;
		this.bio = bio;
		this.profileImage = profileImage;
		this.createdAt = createdAt;
	}



	public User() {
		// TODO Auto-generated constructor stub
	}
	
		
}
