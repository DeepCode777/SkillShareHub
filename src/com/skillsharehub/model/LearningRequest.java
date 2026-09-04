package com.skillsharehub.model;
import java.sql.Timestamp;

public class LearningRequest {
	private int requestId;
	private int senderUserId;
	private int receiverUserId;
	private Integer skillId;
	private String requestMessage;
	private String requestStatus;
	private Timestamp requestDate;
	private String receiverName;
	
	private String senderName;
	private String skillName;
	
	
	public LearningRequest() {
		
	}

	public LearningRequest(int requestId, int senderUserId, int receiverUserId, Integer skillId, String requestMessage,
			String requestStatus, Timestamp requestDate, String senderName, String skillName, String receiverName) {
		super();
		this.requestId = requestId;
		this.senderUserId = senderUserId;
		this.receiverUserId = receiverUserId;
		this.skillId = skillId;
		this.requestMessage = requestMessage;
		this.requestStatus = requestStatus;
		this.requestDate = requestDate;
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.skillName = skillName;
	}


	@Override
	public String toString() {
		return "LearningRequest [requestId=" + requestId + ", senderUserId=" + senderUserId + ", receiverUserId="
				+ receiverUserId + ", skillId=" + skillId + ", requestMessage=" + requestMessage + ", requestStatus="
				+ requestStatus + ", requestDate=" + requestDate + ", receiverName=" + receiverName + ", senderName="
				+ senderName + ", skillName=" + skillName + "]";
	}


	public int getRequestId() {
		return requestId;
	}


	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}


	public int getSenderUserId() {
		return senderUserId;
	}


	public void setSenderUserId(int senderUserId) {
		this.senderUserId = senderUserId;
	}


	public int getReceiverUserId() {
		return receiverUserId;
	}


	public void setReceiverUserId(int receiverUserId) {
		this.receiverUserId = receiverUserId;
	}


	public Integer getSkillId() {
		return skillId;
	}


	public void setSkillId(Integer skillId) {
		this.skillId = skillId;
	}


	public String getRequestMessage() {
		return requestMessage;
	}


	public void setRequestMessage(String requestMessage) {
		this.requestMessage = requestMessage;
	}


	public String getRequestStatus() {
		return requestStatus;
	}


	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}


	public Timestamp getRequestDate() {
		return requestDate;
	}


	public void setRequestDate(Timestamp requestDate) {
		this.requestDate = requestDate;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getSenderName() {
		return senderName;
	}


	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}


	public String getSkillName() {
		return skillName;
	}


	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
}