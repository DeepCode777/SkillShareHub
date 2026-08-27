package com.skillsharehub.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skillsharehub.model.Skill;
import com.skillsharehub.util.DBConnection;

public class SkillDAO {
	private static final String GET_ALL_SKILLS_SQL = "SELECT skill_id, user_id, category_id, skill_name, skill_details, available_mode "
			+ "FROM skills";
	
	private static final String GET_SKILL_BY_ID_SQL =
	        "SELECT skill_id, user_id, category_id, skill_name, skill_details, available_mode "
	        + "FROM skills WHERE skill_id = ?";
	
	private static final String DELETE_SKILL_SQL = "DELETE FROM skills WHERE skill_id = ?";
	
	private static final String GET_SKILLS_BY_USER_ID_SQL =
	        "SELECT s.skill_id, s.user_id, s.category_id, s.skill_name, s.skill_details, s.available_mode, c.category_name "
	        + "FROM skills s "
	        + "JOIN categories c ON s.category_id = c.category_id "
	        + "WHERE s.user_id = ?";
	
	public List<Skill> getAllSkills() throws SQLException {

	    List<Skill> skills = new ArrayList<>();

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(GET_ALL_SKILLS_SQL);
	         ResultSet resultSet = statement.executeQuery()) {

	        while (resultSet.next()) {

	            Skill skill = new Skill();

	            skill.setSkillId(resultSet.getInt("skill_id"));
	            skill.setUserId(resultSet.getInt("user_id"));
	            skill.setCategoryId(resultSet.getInt("category_id"));
	            skill.setSkillName(resultSet.getString("skill_name"));
	            skill.setSkillDetails(resultSet.getString("skill_details"));
	            skill.setAvailableMode(resultSet.getString("available_mode"));

	            skills.add(skill);
	        }
	    }

	    return skills;
	}
	
	// get Skills By ID
	public Skill getSkillById(int skillId) throws SQLException {

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(GET_SKILL_BY_ID_SQL)) {

	        statement.setInt(1, skillId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            if (resultSet.next()) {

	                Skill skill = new Skill();

	                skill.setSkillId(resultSet.getInt("skill_id"));
	                skill.setUserId(resultSet.getInt("user_id"));
	                skill.setCategoryId(resultSet.getInt("category_id"));
	                skill.setSkillName(resultSet.getString("skill_name"));
	                skill.setSkillDetails(resultSet.getString("skill_details"));
	                skill.setAvailableMode(resultSet.getString("available_mode"));

	                return skill;
	            }
	        }
	    }
	    return null;
	}
	
	// Get Skills By User ID
	public List<Skill> getSkillsByUserId(int userId) throws SQLException {

	    List<Skill> skills = new ArrayList<>();

	    try (Connection connection = DBConnection.getConnection();PreparedStatement statement = connection.prepareStatement(GET_SKILLS_BY_USER_ID_SQL)) {

	        statement.setInt(1, userId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            while (resultSet.next()) {

	                Skill skill = new Skill();

	                skill.setSkillId(resultSet.getInt("skill_id"));
	                skill.setUserId(resultSet.getInt("user_id"));
	                skill.setCategoryId(resultSet.getInt("category_id"));
	                skill.setSkillName(resultSet.getString("skill_name"));
	                skill.setSkillDetails(resultSet.getString("skill_details"));
	                skill.setAvailableMode(resultSet.getString("available_mode"));
	                skill.setCategoryName(resultSet.getString("category_name"));

	                skills.add(skill);
	            }
	        }
	    }

	    return skills;
	}
	
	// Delete Skill
	public boolean deleteSkill(int skillId) throws SQLException {

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(DELETE_SKILL_SQL)) {

	        statement.setInt(1, skillId);

	        int rowsAffected = statement.executeUpdate();

	        return rowsAffected == 1;
	    }
	}
}
