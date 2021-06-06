package com.example.myProject;

import javax.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.InputStream;

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

    public static void uploadPhoto(String path, Part part){
        try {

            FileOutputStream fos = new FileOutputStream(path);
            InputStream is = part.getInputStream();

            // reading data
            byte[] data = new byte[is.available()];
            is.read(data);

            // writing data
            fos.write(data);
            fos.close();

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
