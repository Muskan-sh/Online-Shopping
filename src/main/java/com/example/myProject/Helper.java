package com.example.myProject;

public class Helper {

    public static String get10Words(String description) {
        String[] strings = description.split(" ");

        if (strings.length > 10) {
            String res = "";
            for (int i = 0; i < 10; i++) {
                res += strings[i] + " ";
            }
            return res.trim() + "...";
        }

        return description;
    }
}
