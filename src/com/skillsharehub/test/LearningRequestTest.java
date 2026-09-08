package com.skillsharehub.test;

import com.skillsharehub.dao.LearningRequestDAO;
//import com.skillsharehub.dao.LearningRequestDAO;
//import com.skillsharehub.dao.SkillDAO;
//import com.skillsharehub.model.LearningRequest;
//import com.skillsharehub.model.Skill;

public class LearningRequestTest {

    public static void main(String[] args) {

//        LearningRequestDAO learningRequestDAO = new LearningRequestDAO();
//
//        LearningRequest request = new LearningRequest();
//
//        request.setSenderUserId(1);
//        request.setReceiverUserId(2);
//        request.setSkillId(5);
//
//        request.setRequestMessage("I would like to learn this skill.");
//        request.setRequestStatus("Pending");

    	LearningRequestDAO dao = new LearningRequestDAO();

        int senderUserId = 1;
        int skillId = 4;
    	
        try {

//            boolean result = learningRequestDAO.createLearningRequest(request);
//
//            System.out.println("Create learning request: " + result);
//
//            if (result) {
//                System.out.println("Learning request inserted successfully.");
//            } else {
//                System.out.println("Learning request was not inserted.");
//            }
            
//        	// user select the skill
//            SkillDAO skillDAO = new SkillDAO();
//
//            int skillId = 5;
//
//            Skill skill = skillDAO.getSkillById(skillId);
//
//            if (skill != null) {
//
//                System.out.println("Skill found: " + skill.getSkillName());
//                System.out.println("Skill owner user ID: " + skill.getUserId());
//                System.out.println("Skill owner name: " + skill.getUserName());
//
//            } else {
//
//                System.out.println("Skill not found.");
//            }
        	
        	boolean result = dao.hasPendingRequest(senderUserId, skillId);

            System.out.println("Has pending request : " + result);


        } catch (Exception e) {

            System.out.println("Database error while creating learning request.");

            e.printStackTrace();
        }
    }
}