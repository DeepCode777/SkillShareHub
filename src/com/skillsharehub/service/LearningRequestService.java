package com.skillsharehub.service;

import com.skillsharehub.dao.LearningRequestDAO;
import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.model.Skill;

public class LearningRequestService {

    private LearningRequestDAO learningRequestDAO;
    private SkillDAO skillDAO;

    public LearningRequestService() {
        learningRequestDAO = new LearningRequestDAO();
        skillDAO = new SkillDAO();
    }

    public String createLearningRequest(LearningRequest request) throws Exception {

        // Get selected skill
        Skill skill = skillDAO.getSkillById(request.getSkillId());

        if (skill == null) {
            return "SKILL_NOT_FOUND";
        }

        // Self-request validation
        if (skill.getUserId() == request.getSenderUserId()) {
            return "SELF_REQUEST";
        }

        // Duplicate Pending validation
        String validation = learningRequestDAO.validateLearningRequest(request.getSenderUserId(),request.getSkillId());

        if (!"VALID".equals(validation)) {
            return validation;
        }

        // Set receiver from actual skill owner
        request.setReceiverUserId(skill.getUserId());

        // Initial status
        request.setRequestStatus("Pending");

        // Create request
        boolean created = learningRequestDAO.createLearningRequest(request);

        if (created) {
            return "SUCCESS";
        }

        return "FAILED";
    }
    
    //
    public String updateRequestStatus(int requestId, int receiverUserId, String newStatus) throws Exception {

        // Validate new status
        if (!"Accepted".equals(newStatus) && !"Rejected".equals(newStatus)) {
            return "INVALID_STATUS";
        }

        // Update request status
        boolean updated = learningRequestDAO.updateRequestStatus(requestId, receiverUserId, newStatus);

        if (updated) {
            return "SUCCESS";
        }

        return "UPDATE_FAILED";
    }
    
    //
    public String cancelLearningRequest(int requestId, int userId) throws Exception {

        boolean cancelled = learningRequestDAO.cancelLearningRequest(requestId,userId);
        if (cancelled) {
            return "SUCCESS";
        }

        return "CANCEL_FAILED";
    }
    
    //
    public String completeLearningRequest(int requestId, int receiverUserId) throws Exception {

        boolean completed = learningRequestDAO.completeLearningRequest(requestId, receiverUserId);
        if (completed) {
            return "SUCCESS";
        }
        return "COMPLETE_FAILED";
    }
}