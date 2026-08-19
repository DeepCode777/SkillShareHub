package com.skillsharehub.model;

public class User {
	private int userId;
	private String fullName;
	private String email;
	private String password;
	private String phone;
	private String gender;
	private String dob;
	private String city;
	private String bio;
	private String profilePhoto;
	private String createdAt;
	
	
	public User(int userId, String fullName, String email, String password, String phone, String gender, String dob,
			String city, String bio, String profilePhoto, String createdAt) {
		super();
		this.userId = userId;
		this.fullName = fullName;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.gender = gender;
		this.dob = dob;
		this.city = city;
		this.bio = bio;
		this.profilePhoto = profilePhoto;
		this.createdAt = createdAt;
	}
	
	
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}



	@Override
	public String toString() {
		return "User [userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", password=" + password
				+ ", phone=" + phone + ", gender=" + gender + ", dob=" + dob + ", city=" + city + ", bio=" + bio
				+ ", profilePhoto=" + profilePhoto + ", createdAt=" + createdAt + "]";
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


	public String getDob() {
		return dob;
	}


	public void setDob(String dob) {
		this.dob = dob;
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


	public String getProfilePhoto() {
		return profilePhoto;
	}


	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}


	public String getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
	
}
