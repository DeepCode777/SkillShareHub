package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.skillsharehub.model.Category;
import com.skillsharehub.util.DBConnection;

public class CategoryDAO {
	private static final String GET_ALL_CATEGORIES_SQL = "SELECT category_id, category_name, icon FROM categories";
	private static final String GET_CATEGORY_BY_ID_SQL = "SELECT category_id, category_name, icon FROM categories WHERE category_id = ?";
	private static final String INSERT_CATEGORY_SQL = "INSERT INTO categories (category_name, icon) VALUES (?, ?)";
	private static final String UPDATE_CATEGORY_SQL = "UPDATE categories SET category_name = ?, icon = ? WHERE category_id = ?";
	private static final String DELETE_CATEGORY_SQL = "DELETE FROM categories WHERE category_id = ?";
	
	// Get All Categories
	public List<Category> getAllCategories() {

	    List<Category> categories = new ArrayList<>();

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_CATEGORIES_SQL);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        while (resultSet.next()) {

	            Category category = new Category();

	            category.setCategoryId(resultSet.getInt("category_id"));
	            category.setCategoryName(resultSet.getString("category_name"));
	            category.setCategoryIcon(resultSet.getString("icon"));

	            categories.add(category);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return categories;
	}
	
	// Get Category By ID
	public Category getCategoryById(int categoryId) {

	    Category category = null;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(GET_CATEGORY_BY_ID_SQL)) {

	        preparedStatement.setInt(1, categoryId);

	        try (ResultSet resultSet = preparedStatement.executeQuery()) {

	            if (resultSet.next()) {

	                category = new Category();

	                category.setCategoryId(resultSet.getInt("category_id"));
	                category.setCategoryName(resultSet.getString("category_name"));
	                category.setCategoryIcon(resultSet.getString("icon"));
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return category;
	}
	
	// Add Category
	public boolean addCategory(Category category) {

	    boolean rowInserted = false;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORY_SQL)) {

	        preparedStatement.setString(1, category.getCategoryName());
	        preparedStatement.setString(2, category.getCategoryIcon());

	        rowInserted = preparedStatement.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return rowInserted;
	}
	
	
	// Update Category
	public boolean updateCategory(Category category) {

	    boolean rowUpdated = false;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CATEGORY_SQL)) {

	        preparedStatement.setString(1, category.getCategoryName());
	        preparedStatement.setString(2, category.getCategoryIcon());
	        preparedStatement.setInt(3, category.getCategoryId());

	        rowUpdated = preparedStatement.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return rowUpdated;
	}
	
	// Delete Category
	public boolean deleteCategory(int categoryId) {

	    boolean rowDeleted = false;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement =
	                 connection.prepareStatement(DELETE_CATEGORY_SQL)) {

	        preparedStatement.setInt(1, categoryId);

	        rowDeleted = preparedStatement.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return rowDeleted;
	}
}