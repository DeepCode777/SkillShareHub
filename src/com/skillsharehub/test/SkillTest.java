package com.skillsharehub.test;

import java.sql.SQLException;
import java.util.List;

import com.skillsharehub.dao.SkillDAO;
import com.skillsharehub.model.Skill;

public class SkillTest {

    public static void main(String[] args) throws SQLException {

        SkillDAO skillDAO = new SkillDAO();

        List<Skill> skills = skillDAO.getAllSkills();

        System.out.println("Total Skills: " + skills.size());

        for (Skill skill : skills) {

            System.out.println(
                    "User: " + skill.getUserName()
                    + " | Category: " + skill.getCategoryName()
                    + " | Skill: " + skill.getSkillName()
                    + " | Details: " + skill.getSkillDetails()
                    + " | Available Mode: " + skill.getAvailableMode()
            );
        }
        
//        // Get Skill By ID Test
//        Skill skill = skillDAO.getSkillById(4);
//
//        if (skill != null) {
//
//            System.out.println("Skill Found:");
//            System.out.println("User: " + skill.getUserName());
//            System.out.println("Category: " + skill.getCategoryName());
//            System.out.println("Skill: " + skill.getSkillName());
//            System.out.println("Details: " + skill.getSkillDetails());
//            System.out.println("Available Mode: " + skill.getAvailableMode());
//
//        } else {
//
//            System.out.println("Skill not found.");
//        }
//        
//        Skill skillAdd = new Skill();
//
//        skillAdd.setUserId(1);
//        skillAdd.setCategoryId(10);
//        skillAdd.setSkillName("Test Java Skill");
//        skillAdd.setSkillDetails("Temporary skill for testing");
//        skillAdd.setAvailableMode("Yes");
//
//        boolean result = skillDAO.addSkill(skillAdd);
//
//        System.out.println("Skill Added: " + result);
        
//        SkillDAO skillDAO = new SkillDAO();
//        Skill skill = skillDAO.getSkillById(4);
//
//        if (skill != null) {
//            skill.setCategoryId(10);
//            skill.setSkillName("Programming Updated");
//            skill.setSkillDetails("Updated skill details");
//            skill.setAvailableMode("No");
//
//            boolean resultUp = skillDAO.updateSkill(skill);
//
//            System.out.println("Duplicate Update skill for different user : " + resultUp);
//
//            Skill updatedSkill = skillDAO.getSkillById(1);
//
//            if (updatedSkill != null) {
//                System.out.println("Skill ID: " + updatedSkill.getSkillId());
//                System.out.println("User ID: " + updatedSkill.getUserId());
//                System.out.println("Category ID: " + updatedSkill.getCategoryId());
//                System.out.println("Skill Name: " + updatedSkill.getSkillName());
//                System.out.println("Skill Details: " + updatedSkill.getSkillDetails());
//                System.out.println("Available Mode: " + updatedSkill.getAvailableMode());
//            }
//        }
    	
//    	SkillDAO skillDAO = new SkillDAO();
//    	Skill skill = skillDAO.getSkillById(11);
//
//    	if (skill != null) {
//    	    skill.setSkillName("Java");
//
//    	    boolean result = skillDAO.updateSkill(skill);
//
//    	    System.out.println("Duplicate skill name update: " + result);
//    	}
    	
//    	SkillDAO skillDAO = new SkillDAO();
//    	Skill skill = skillDAO.getSkillById(11);
//
//    	if (skill != null) {
//    	    skill.setSkillName("Java Programming Updated");
//
//    	    boolean result = skillDAO.updateSkill(skill);
//
//    	    System.out.println("Different user same skill name update: " + result);
//    	}
    	
//    	SkillDAO skillDAO = new SkillDAO();
//    	Skill skill = new Skill();
//
//    	skill.setSkillId(1);
//    	skill.setCategoryId(10);
//    	skill.setSkillName("Test Skill");
//    	skill.setSkillDetails("Test details");
//    	skill.setAvailableMode("Yes");
//
//    	boolean result = skillDAO.updateSkill(skill);
//
//    	System.out.println("Update non-existing skill: " + result);
        
//        SkillDAO skillDAO = new SkillDAO();
        boolean result = skillDAO.deleteSkill(9999);

        System.out.println("Delete existing skill: " + result);
    }
}