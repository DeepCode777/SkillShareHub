package com.skillsharehub.test;

//import com.skillsharehub.model.LearningRequest;
import com.skillsharehub.service.LearningRequestService;

public class LearningRequestServiceTest {

    public static void main(String[] args) {

        LearningRequestService service = new LearningRequestService();
        

        try {

//            // Test 1 - Valid Request
//            LearningRequest request1 = new LearningRequest();
//
//            request1.setSenderUserId(5);
//            request1.setSkillId(19);
//            request1.setRequestMessage("I want to learn this skill.");
//
//            String result1 = service.createLearningRequest(request1);
//
//            System.out.println("Test 1 - Valid request : " + result1);
//
//            // Test 2 - Self Request
//            LearningRequest request2 = new LearningRequest();
//
//            request2.setSenderUserId(5);
//            request2.setSkillId(18);
//            request2.setRequestMessage("Self request test.");
//
//            String result2 = service.createLearningRequest(request2);
//
//            System.out.println("Test 2 - Self request : " + result2);
//
//            // Test 3 - Duplicate Pending Request
//            LearningRequest request3 = new LearningRequest();
//
//            request3.setSenderUserId(3);
//            request3.setSkillId(19);
//            request3.setRequestMessage("Duplicate pending test.");
//
//            String result3 = service.createLearningRequest(request3);
//
//            System.out.println("Test 3 - Duplicate pending : " + result3);
//
//            // Test 4 - Invalid Skill
//            LearningRequest request4 = new LearningRequest();
//
//            request4.setSenderUserId(1);
//            request4.setSkillId(0);
//            request4.setRequestMessage("Invalid skill test.");
//
//            String result4 = service.createLearningRequest(request4);
//
//            System.out.println("Test 4 - Invalid skill : " + result4);
        	
//            // Test 1: Valid Accepted status
//            String result1 =service.updateRequestStatus(1,2,"Accepted");      // requestId, receiverUserId , Pending
//            System.out.println("Test 1 - Accepted: " + result1);				// SUCCESS

//            // Test 2: Valid Rejected status
//            String result2 = service.updateRequestStatus(2,5,"Rejected");	// <- Pending
//            System.out.println("Test 2 - Rejected: " + result2);			// SUCCESS
            
//            // Test 3: Valid Completed status
//            String result3 = service.updateRequestStatus(5,5,"Completed");	// <- Pending
//            System.out.println("Test 3 - Completed: " + result3);				//  SUCCESS

//            // Test 4: Invalid status
//            String result4 =service.updateRequestStatus(4,5,"Invalid");	// Accepted
//            System.out.println("Test 4 - Invalid Status: " + result4);	// INVALID_STATUS
            
//            // Test 5: Empty status
//            String result5 = service.updateRequestStatus(6,3,"");		// Pending
//            System.out.println("Test 5 - Empty Status: " + result5);	// INVALID_STATUS
        	
//            // Test 6: Null status
//            String result6 = service.updateRequestStatus(6,3,null);	// Pending
//            System.out.println("Test 6 - Null Status: " + result6);	// INVALID_STATUS

//            // Test 7: Sender tries to update
//            // Use a request where user 2 is NOT the receiver.
//            String result7 = service.updateRequestStatus(6,5,"Accepted");		// Pending
//            System.out.println("Test 7 - Wrong User: " + result7);			// UPDATE_FAILED

//            // Test 8: Already Accepted request
//            String result8 = service.updateRequestStatus(4,5,"Rejected");	// Accepted
//            System.out.println("Test 8 - Already Accepted: " + result8);	// UPDATE_FAILED

//            // Test 9: Already Rejected request
//            String result9 = service.updateRequestStatus(2,5,"Accepted");	// Rejected
//            System.out.println("Test 9 - Already Rejected: " + result9);	// UPDATE_FAILED
            
//            // Test 10: Cancelled request
//            String result10 = service.updateRequestStatus(3,2,"Accepted");	// Cancel
//            System.out.println("Test 10 - Cancelled Request: " + result10);	// UPDATE_FAILED
            
        	
//        	// Test 1: Cancelled request - RequestID, UserID
//        	String result1 = service.cancelLearningRequest(9, 25);
//        	System.out.println("Test 1 - Cancelled Request: " + result1);
			
//        	Sender + Pending -> Cancel = SUCCESS
//        	Receiver + Pending -> Cancel = SUCCESS
//        	Wrong User -> Cancel = CANCEL_FAILED
//        	Accepted Request -> Cancel = CANCEL_FAILED
//        	Rejected Request -> Cancel = CANCEL_FAILED
//        	Completed Request -> Cancel = CANCEL_FAILED
//        	Already cancel -> Cancel = CANCEL_FAILED
        	
        	
 //       	// Test 1: Completed request - RequestID, RequesteduserID
 //       	String result2 = service.completeLearningRequest(10, 25);
 //       	System.out.println("Test 1 - Cancelled Request: " + result2);

//        	Receiver + Accepted -> Completed = SUCCESS
//        	Sender + Accepted -> Completed = COMPLETE_FAILED
//        	Wrong User -> Completed = COMPLETE_FAILED
//        	Receiver + Pending -> Completed = COMPLETE_FAILED
//        	Receiver + Rejected -> Completed = COMPLETE_FAILED
//        	Receiver + Cancel -> Completed = COMPLETE_FAILED
//        	Receiver + Completed -> Completed = COMPLETE_FAILED
        	
        	
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}