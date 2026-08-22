package com.skillsharehub.util;

public class PasswordTest {

    public static void main(String[] args) {

        String password = "HashTest3##demo";

        String hashedPassword = PasswordUtil.hashPassword(password);

        System.out.println("Original Password: " + password);
        System.out.println("Hashed Password: " + hashedPassword);

        boolean correctPassword =
                PasswordUtil.checkPassword(password, hashedPassword);

        boolean wrongPassword =
                PasswordUtil.checkPassword("Wrong@1234", hashedPassword);

        System.out.println("Correct Password: " + correctPassword);
        System.out.println("Wrong Password: " + wrongPassword);
    }
}