package com.skillsharehub.test;

import com.skillsharehub.dao.LearningRequestDAO;

public class LearningRequestValidationTest {

    public static void main(String[] args) {

        LearningRequestDAO dao = new LearningRequestDAO();

        int pendingSenderId = 2;
        int pendingSkillId = 5;

        int newSenderId = 1;
        int newSkillId = 4;

        // Update
        int requestId = 10;
        int receiverUserId = 25;
        String newStatus = "Pending";
        
        int requestId2 = 10;
        int receiverUserId2 = 25;
        String newStatus2 = "Accepted";
        
        int SenderUserId = 25;
        
        int requestId3 = 10;
        int receiverUserId3 = 25;
        String newStatus3 = "Rejected";
        
        try {

            // Test 1: Existing Pending request
            String result1 =
                    dao.validateLearningRequest(pendingSenderId,pendingSkillId);

            System.out.println("Test 1 - Existing pending request : " + result1);

            // Test 2: No Pending request
            String result2 =
                    dao.validateLearningRequest(newSenderId,newSkillId);

            System.out.println("Test 2 - No pending request : " + result2);
            
            // Update Status
            boolean test1 = dao.updateRequestStatus(requestId, receiverUserId, newStatus);
            System.out.println("Test 1 Pending : " + test1); // true
            
            boolean test2 = dao.updateRequestStatus(requestId2, receiverUserId2, newStatus2);
            System.out.println("Test 2 Accepted : " + test2); // true
            
            boolean test3 = dao.updateRequestStatus(requestId, SenderUserId, newStatus);
            System.out.println("Test 3 Pending : " + test3); // false
            
            boolean test5 = dao.updateRequestStatus(requestId2, receiverUserId2, newStatus2);
            System.out.println("Test 5 Accepted : " + test5); // false
            
            boolean test4 = dao.updateRequestStatus(requestId3, receiverUserId3, newStatus3);
            System.out.println("Test 4 Rejected : " + test4); // false

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}