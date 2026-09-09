package com.skillsharehub.test;

import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.service.LearningRequestService;

public class LearningRequestServiceTest {

    public static void main(String[] args) {

        LearningRequestService service = new LearningRequestService();

        try {

            // Test 1 - Valid Request
            LearningRequest request1 = new LearningRequest();

            request1.setSenderUserId(5);
            request1.setSkillId(19);
            request1.setRequestMessage("I want to learn this skill.");

            String result1 = service.createLearningRequest(request1);

            System.out.println("Test 1 - Valid request : " + result1);

            // Test 2 - Self Request
            LearningRequest request2 = new LearningRequest();

            request2.setSenderUserId(5);
            request2.setSkillId(18);
            request2.setRequestMessage("Self request test.");

            String result2 = service.createLearningRequest(request2);

            System.out.println("Test 2 - Self request : " + result2);

            // Test 3 - Duplicate Pending Request
            LearningRequest request3 = new LearningRequest();

            request3.setSenderUserId(3);
            request3.setSkillId(19);
            request3.setRequestMessage("Duplicate pending test.");

            String result3 = service.createLearningRequest(request3);

            System.out.println("Test 3 - Duplicate pending : " + result3);

            // Test 4 - Invalid Skill
            LearningRequest request4 = new LearningRequest();

            request4.setSenderUserId(1);
            request4.setSkillId(0);
            request4.setRequestMessage("Invalid skill test.");

            String result4 = service.createLearningRequest(request4);

            System.out.println("Test 4 - Invalid skill : " + result4);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}