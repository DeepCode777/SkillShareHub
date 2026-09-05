package com.skillsharehub.test;

import com.skillsharehub.util.PasswordUtil;

public class PasswordHashTest {

    public static void main(String[] args) {

        String password = "";

        String hash = PasswordUtil.hashPassword(password);

        System.out.println(hash);
    }
}