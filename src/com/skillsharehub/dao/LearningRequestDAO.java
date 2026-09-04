package com.skillsharehub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.util.DBConnection;

public class LearningRequestDAO {
	
	private static final String GET_RECEIVED_REQUESTS_SQL =
	        "SELECT lr.request_id, lr.sender_user_id, lr.receiver_user_id, lr.skill_id, lr.message, lr.status, lr.request_date, u.full_name AS sender_name, s.skill_name "
	        + "FROM learning_requests lr "
	        + "JOIN users u ON lr.sender_user_id = u.user_id "
	        + "LEFT JOIN skills s ON lr.skill_id = s.skill_id "
	        + "WHERE lr.receiver_user_id = ?";
	
	private static final String GET_SENT_REQUESTS_SQL =
	        "SELECT lr.request_id, lr.sender_user_id, lr.receiver_user_id, lr.skill_id, lr.message, lr.status, lr.request_date, u.full_name AS receiver_name, s.skill_name "
	        + "FROM learning_requests lr "
	        + "JOIN users u ON lr.receiver_user_id = u.user_id "
	        + "LEFT JOIN skills s ON lr.skill_id = s.skill_id "
	        + "WHERE lr.sender_user_id = ?";
	
	public List<LearningRequest> getReceivedRequestsByUserId(int userId) throws SQLException {

	    List<LearningRequest> requests = new ArrayList<>();

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(GET_RECEIVED_REQUESTS_SQL)) {

	        statement.setInt(1, userId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            while (resultSet.next()) {

	                LearningRequest request = new LearningRequest();

	                request.setRequestId(resultSet.getInt("request_id"));
	                request.setSenderUserId(resultSet.getInt("sender_user_id"));
	                request.setReceiverUserId(resultSet.getInt("receiver_user_id"));

	                int skillId = resultSet.getInt("skill_id");
	                if (resultSet.wasNull()) {
	                    request.setSkillId(null);
	                } else {
	                    request.setSkillId(skillId);
	                }

	                request.setRequestMessage(resultSet.getString("message"));
	                request.setRequestStatus(resultSet.getString("status"));
	                request.setRequestDate(resultSet.getTimestamp("request_date"));

	                request.setSenderName(resultSet.getString("sender_name"));
	                request.setSkillName(resultSet.getString("skill_name"));

	                requests.add(request);
	            }
	        }
	    }

	    return requests;
	}
	
	public List<LearningRequest> getSentRequestsByUserId(int userId) throws SQLException {

	    List<LearningRequest> requests = new ArrayList<>();

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement =
	                 connection.prepareStatement(GET_SENT_REQUESTS_SQL)) {

	        statement.setInt(1, userId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            while (resultSet.next()) {

	                LearningRequest request = new LearningRequest();

	                request.setRequestId(resultSet.getInt("request_id"));
	                request.setSenderUserId(resultSet.getInt("sender_user_id"));
	                request.setReceiverUserId(resultSet.getInt("receiver_user_id"));

	                int skillId = resultSet.getInt("skill_id");

	                if (resultSet.wasNull()) {
	                    request.setSkillId(null);
	                } else {
	                    request.setSkillId(skillId);
	                }

	                request.setRequestMessage(resultSet.getString("message"));
	                request.setRequestStatus(resultSet.getString("status"));
	                request.setRequestDate(resultSet.getTimestamp("request_date"));

	                request.setReceiverName(resultSet.getString("receiver_name"));
	                request.setSkillName(resultSet.getString("skill_name"));

	                requests.add(request);
	            }
	        }
	    }

	    return requests;
	}
}
