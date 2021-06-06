package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.Helper;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig
@WebServlet(name = "UpdateUserProfileServlet", value = "/UpdateUserProfileServlet")
public class UpdateUserProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String option = request.getParameter("option");
            out.println(option);

            HttpSession httpSession = request.getSession();
            User user = (User) httpSession.getAttribute("current-user");

            UserDao userDao = new UserDao(FactoryProvider.getFactory());

            if ("Profile".equals(option)) {
                String remove = request.getParameter("remove");
                String name = request.getParameter("name");
                String gender = request.getParameter("gender");

                try {
                    Part part = request.getPart("photo");
                    String photo = part.getSubmittedFileName();
                    String userPic = user.getUserPic();


                    if (name.isBlank()) {
                        httpSession.setAttribute("message", "Name can't be Blank");
                        response.sendRedirect("userProfile.jsp?option=" + option);
                    } else {
                        if (remove != null) {
                            System.out.println("(Inside If)  remove :   " + remove + "   Userpic :   " + userPic);
                            if (!userPic.equals("profile-user.png")) {
                                Helper.deletePhoto("user_profile_images", userPic);
                            }
                            user.setUserPic("profile-user.png");
                        } else if (!photo.equals(userPic)) {

                            System.out.println("(Inside else If)  remove :   " + remove + "   Userpic :   " + userPic);

                            if (!userPic.equals("profile-user.png")) {
                                Helper.deletePhoto("user_profile_images", userPic);
                            }

                            try {
                                Helper.uploadPhoto("user_profile_images", photo, part);
                                user.setUserPic(photo);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                        } else if (!name.equals(user.getUserName())) {
                            user.setUserName(name);
                        } else if (gender != null && !gender.equals(user.getGender())) {
                            user.setGender(gender);
                        } else {
                            httpSession.setAttribute("message", "No changes made!!");
                            response.sendRedirect("userProfile.jsp?option=" + option);
                        }
                        userDao.updateUser(user);
                        httpSession.setAttribute("message", "Changes Saved Successfully");
                        response.sendRedirect("userProfile.jsp?option=" + option);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }


            } else if ("Addresses".equals(option)) {
            } else if ("Orders".equals(option)) {
            } else if ("Payments".equals(option)) {
            } else if ("Change Password".equals(option)) {
                String pwd = request.getParameter("pwd");
                String new_pwd = request.getParameter("new_pwd");
                String new_pwd_2 = request.getParameter("new_pwd_2");

                if (pwd.isBlank() || new_pwd.isBlank() || new_pwd_2.isBlank()) {
                    httpSession.setAttribute("message", "No changes made");
                    response.sendRedirect("userProfile.jsp?option=" + option);
                } else {
                    if (pwd.equals(user.getUserPassword())) {
                        if (!new_pwd.equals(new_pwd_2)) {
                            httpSession.setAttribute("message", "Enter new password correctly");
                            response.sendRedirect("userProfile.jsp?option=" + option);
                        } else {
                            user.setUserPassword(new_pwd);
                            userDao.updateUser(user);
                            httpSession.setAttribute("message", "Changes Saved Successfully");
                            response.sendRedirect("userProfile.jsp?option=" + option);
                        }

                    } else {
                        httpSession.setAttribute("message", "Current password is incorrect. Try again!!");
                        response.sendRedirect("userProfile.jsp?option=" + option);
                    }
                }
            } else if ("Delete Account".equals(option)) {
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
