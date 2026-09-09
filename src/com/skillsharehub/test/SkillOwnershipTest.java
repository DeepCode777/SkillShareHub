package com.skillsharehub.test;

import com.skillsharehub.dao.SkillDAO;

public class SkillOwnershipTest {

    public static void main(String[] args) {

        SkillDAO dao = new SkillDAO();
        int skillId = 4;
        int ownerUserId = 1;
        int differentUserId = 2;

        try {

            // Test 1: Correct owner
            boolean ownerResult = dao.isSkillOwnedByUser(skillId, ownerUserId);

            System.out.println("Test 1 - Correct owner : " + ownerResult);

            // Test 2: Different user
            boolean differentUserResult = dao.isSkillOwnedByUser(skillId, differentUserId);

            System.out.println( "Test 2 - Different user : " + differentUserResult);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}