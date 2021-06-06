package com.example.myProject;

import javax.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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

    public static void uploadPhoto(String folderName, String photoName, Part part){

            Path path1 = Paths.get("C:\\Users\\reach\\Desktop\\Online-Shopping\\src\\main\\webapp\\"+ folderName+"\\"+photoName);
            Path path2 = Paths.get("C:\\Users\\reach\\Desktop\\Online-Shopping\\target\\e_commerce_project-1.0-SNAPSHOT\\"+ folderName+"\\"+photoName);

            upload(path1,part);
            upload(path2,part);

    }

    private static void upload(Path path,Part part){
        try {

            FileOutputStream fos = new FileOutputStream(String.valueOf(path));
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
    public static  void deletePhoto(String folderName, String photoName){

        Path path1 = Paths.get("C:\\Users\\reach\\Desktop\\Online-Shopping\\src\\main\\webapp\\"+ folderName+"\\"+photoName);
        Path path2 = Paths.get("C:\\Users\\reach\\Desktop\\Online-Shopping\\target\\e_commerce_project-1.0-SNAPSHOT\\"+ folderName+"\\"+photoName);
        try {
            Files.delete(path1);
            Files.delete(path2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
