package com.skillsharehub.model;

public class Skill {
	private int skillId;
	private int userId;
	private int categoryId;
	private String skillName;
	private String skillDetails;
	private String availableMode;
	private String categoryName;
	
	public Skill() {
		
	}
	
	
	@Override
	public String toString() {
		return "Skill [skillId=" + skillId + ", userId=" + userId + ", categoryId=" + categoryId + ", skillName="
				+ skillName + ", skillDetails=" + skillDetails + ", availableMode=" + availableMode + ", categoryName="
				+ categoryName + "]";
	}



	public Skill(int skillId, int userId, int categoryId, String skillName, String skillDetails, String availableMode, String categoryName) {
		super();
		this.skillId = skillId;
		this.userId = userId;
		this.categoryId = categoryId;
		this.skillName = skillName;
		this.skillDetails = skillDetails;
		this.availableMode = availableMode;
		this.categoryId = categoryId;
		this.categoryName = categoryName;
	}
	
	
	
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getSkillId() {
		return skillId;
	}
	public void setSkillId(int skillId) {
		this.skillId = skillId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getSkillName() {
		return skillName;
	}
	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
	public String getSkillDetails() {
		return skillDetails;
	}
	public void setSkillDetails(String skillDetails) {
		this.skillDetails = skillDetails;
	}
	public String getAvailableMode() {
		return availableMode;
	}
	public void setAvailableMode(String availableMode) {
		this.availableMode = availableMode;
	}
	
	
	
}