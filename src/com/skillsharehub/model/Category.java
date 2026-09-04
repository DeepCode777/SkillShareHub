package com.skillsharehub.model;

public class Category {
	private int categoryId;
	private String categoryName;
	private String categoryIcon;
	
	public Category() {
		
	}
	
	public Category(int categoryId, String categoryName, String categoryIcon) {
		super();
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryIcon = categoryIcon;
	}

	@Override
	public String toString() {
		return "Category [categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryIcon="
				+ categoryIcon + "]";
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategoryIcon() {
		return categoryIcon;
	}

	public void setCategoryIcon(String categoryIcon) {
		this.categoryIcon = categoryIcon;
	}
}
