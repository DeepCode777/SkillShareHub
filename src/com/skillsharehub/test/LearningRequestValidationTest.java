package com.skillsharehub.test;

import com.skillsharehub.dao.LearningRequestDAO;

public class LearningRequestValidationTest {

    public static void main(String[] args) {

        LearningRequestDAO dao = new LearningRequestDAO();

        int pendingSenderId = 2;
        int pendingSkillId = 5;

        int newSenderId = 1;
        int newSkillId = 4;

        try {

            // Test 1: Existing Pending request
            String result1 =
                    dao.validateLearningRequest(pendingSenderId,pendingSkillId);

            System.out.println("Test 1 - Existing pending request : " + result1);

            // Test 2: No Pending request
            String result2 =
                    dao.validateLearningRequest(newSenderId,newSkillId);

            System.out.println("Test 2 - No pending request : " + result2);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}