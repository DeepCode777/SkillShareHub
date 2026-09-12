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
	private static final String GET_ALL_SKILLS_SQL =
	        "SELECT s.skill_id, s.user_id, s.category_id, s.skill_name, s.skill_details, s.available_mode, c.category_name, u.full_name AS user_name FROM skills s " +
	        "JOIN categories c ON s.category_id = c.category_id JOIN users u ON s.user_id = u.user_id";
	
	/*private static final String GET_SKILL_BY_ID_SQL =
	        "SELECT skill_id, user_id, category_id, skill_name, skill_details, available_mode "
	        + "FROM skills WHERE skill_id = ?";*/
	
	private static final String GET_SKILL_BY_ID_SQL =
	        "SELECT s.skill_id, s.user_id, s.category_id, s.skill_name, s.skill_details, s.available_mode, c.category_name, u.full_name AS user_name FROM skills s " +
	        "JOIN categories c ON s.category_id = c.category_id JOIN users u ON s.user_id = u.user_id WHERE s.skill_id = ?";
	
	private static final String INSERT_SKILL_SQL ="INSERT INTO skills (user_id, category_id, skill_name, skill_details, available_mode)VALUES (?, ?, ?, ?, ?)";
	
	private static final String UPDATE_SKILL_SQL = "UPDATE skills SET category_id = ?, skill_name = ?, skill_details = ?, available_mode = ? " +
	        "WHERE skill_id = ?";
	
	private static final String UPDATE_SKILL_BY_USER_SQL = "UPDATE skills SET category_id = ?, skill_name = ?, skill_details = ?, available_mode = ? "
	        + "WHERE skill_id = ? AND user_id = ?";
	
	private static final String DELETE_SKILL_SQL = "DELETE FROM skills WHERE skill_id = ?";
	
	private static final String DELETE_SKILL_BY_USER_SQL = "DELETE FROM skills WHERE skill_id = ? AND user_id = ?";
	
	private static final String GET_SKILLS_BY_USER_ID_SQL =
	        "SELECT s.skill_id, s.user_id, s.category_id, s.skill_name, s.skill_details, s.available_mode, c.category_name "
	        + "FROM skills s "
	        + "JOIN categories c ON s.category_id = c.category_id "
	        + "WHERE s.user_id = ?";
	
	// Get All Skills
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
	            skill.setCategoryName(resultSet.getString("category_name"));
	            skill.setUserName(resultSet.getString("user_name"));

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
	                skill.setCategoryName(resultSet.getString("category_name"));
	                skill.setUserName(resultSet.getString("user_name"));

	                return skill;
	            }
	        }
	    }
	    return null;
	}
	
	// Add Skills
	public boolean addSkill(Skill skill) {
	    boolean rowInserted = false;
	    try (Connection connection = DBConnection.getConnection();PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SKILL_SQL)) {

	        preparedStatement.setInt(1, skill.getUserId());
	        preparedStatement.setInt(2, skill.getCategoryId());
	        preparedStatement.setString(3, skill.getSkillName());
	        preparedStatement.setString(4, skill.getSkillDetails());
	        preparedStatement.setString(5, skill.getAvailableMode());

	        rowInserted = preparedStatement.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rowInserted;
	}
	
	// Update Skill
	public boolean updateSkill(Skill skill) {
	    boolean rowUpdated = false;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SKILL_SQL)) {

	        preparedStatement.setInt(1, skill.getCategoryId());
	        preparedStatement.setString(2, skill.getSkillName());
	        preparedStatement.setString(3, skill.getSkillDetails());
	        preparedStatement.setString(4, skill.getAvailableMode());
	        preparedStatement.setInt(5, skill.getSkillId());

	        rowUpdated = preparedStatement.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rowUpdated;
	}
	
	// Update Skill By User - MySkillEdit
	public boolean updateSkillByUser(Skill skill, int userId) throws SQLException {
	    boolean rowUpdated = false;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SKILL_BY_USER_SQL)) {

	        preparedStatement.setInt(1, skill.getCategoryId());
	        preparedStatement.setString(2, skill.getSkillName());
	        preparedStatement.setString(3, skill.getSkillDetails());
	        preparedStatement.setString(4, skill.getAvailableMode());
	        preparedStatement.setInt(5, skill.getSkillId());
	        preparedStatement.setInt(6, userId);

	        rowUpdated = preparedStatement.executeUpdate() > 0;

	    }
	    return rowUpdated;
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
	
	// Delete Skill By User - MySkillDelete
	public boolean deleteSkillByUser(int skillId, int userId) throws SQLException {

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(DELETE_SKILL_BY_USER_SQL)) {

	        statement.setInt(1, skillId);
	        statement.setInt(2, userId);

	        int rowsAffected = statement.executeUpdate();

	        return rowsAffected == 1;
	    }
	}
	
	// Section Use For LR
	public boolean isSkillOwnedByUser(int skillId, int userId) throws SQLException {

	    String sql = "SELECT skill_id FROM skills WHERE skill_id = ? AND user_id = ?";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setInt(1, skillId);
	        statement.setInt(2, userId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            return resultSet.next();
	        }
	    }
	}
	
}
