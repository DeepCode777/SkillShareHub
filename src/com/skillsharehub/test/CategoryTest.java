package com.skillsharehub.test;
import java.util.List;

import com.skillsharehub.dao.CategoryDAO;
import com.skillsharehub.model.Category;

public class CategoryTest {

    public static void main(String[] args) {

        CategoryDAO categoryDAO = new CategoryDAO();

        List<Category> categories = categoryDAO.getAllCategories();

        System.out.println("Total Categories: " + categories.size());

        for (Category category : categories) {
            System.out.println(category.getCategoryId() + " | " + category.getCategoryName() + " | " + category.getCategoryIcon());
        }
                CategoryDAO categoryDAO1 = new CategoryDAO();

                // Test 1: Existing Category ID
                System.out.println("=== Test 1: Existing Category ===");

                Category category = categoryDAO1.getCategoryById(1);

                if (category != null) {
                    System.out.println("Category Found:");
                    System.out.println("ID: " + category.getCategoryId());
                    System.out.println("Name: " + category.getCategoryName());
                    System.out.println("Icon: " + category.getCategoryIcon());
                } else {
                    System.out.println("Category not found.");
                }

                // Test 2: Non-existing Category ID
                System.out.println("\n=== Test 2: Non-existing Category ===");

                Category notFoundCategory = categoryDAO.getCategoryById(3);

                if (notFoundCategory == null) {
                    System.out.println("Correct: Category not found.");
                } else {
                    System.out.println("Error: Category should not exist.");
                }
                
                
//                // Add
//                Category category3 = new Category();
//
//                category3.setCategoryName("Test Category");
//                category3.setCategoryIcon("test-icon.png");
//
//                boolean result = categoryDAO.addCategory(category3);
//
//                System.out.println("Category Added: " + result);
//                
//                
//                // Update
//                Category category4 = new Category();
//
//                category4.setCategoryId(1);
//                category4.setCategoryName("Programming Updated");
//                category4.setCategoryIcon("programming-new.png");
//
//                boolean result2 = categoryDAO.updateCategory(category4);
//
//                System.out.println("Category Updated: " + result2);
//                
                boolean result = categoryDAO.deleteCategory(7);

                System.out.println("Category Deleted: " + result);
    }
}