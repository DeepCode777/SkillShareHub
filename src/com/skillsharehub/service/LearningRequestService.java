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
}