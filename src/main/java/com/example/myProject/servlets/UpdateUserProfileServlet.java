package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.Helper;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;
import com.example.myProject.mail.SendEmail;

import javax.servlet.RequestDispatcher;
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
//            out.println(option);

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
//                    System.out.println("\""+photo+"\"");
                    String userPic = user.getUserPic();
                    boolean changes = false;


                    if (name.isBlank()) {
                        httpSession.setAttribute("message", "Name can't be Blank");
                        response.sendRedirect("userProfile.jsp?option=" + option);
                    } else {
                        if (remove != null && !userPic.equals("profile-user.png")) {
                            System.out.println("(Inside If)  remove :   " + remove + "   Userpic :   " + userPic);
                            Helper.deletePhoto("user_profile_images", userPic);
                            user.setUserPic("profile-user.png");
                            changes = true;
                        }
                        if (remove == null && !photo.isEmpty() && !photo.equals(userPic)) {

                            System.out.println("(Inside else If)  remove :   " + remove + "   Userpic :   " + userPic);

                            if (!userPic.equals("profile-user.png")) {
                                Helper.deletePhoto("user_profile_images", userPic);
                            }
                            try {
                                Helper.uploadPhoto("user_profile_images", photo, part);
                                user.setUserPic(photo);
                                changes = true;
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        if (!name.equals(user.getUserName())) {
                            user.setUserName(name);
                            changes = true;
                        }
                        if (gender != null && !gender.equals(user.getGender())) {
                            user.setGender(gender);
                            changes = true;
                        }
                        if (!changes) {
//                            System.out.println("no change");
                            httpSession.setAttribute("message", "No changes made!!");
                            response.sendRedirect("userProfile.jsp?option=" + option);
                            return;
                        } else {
                            userDao.updateUser(user);
                            httpSession.setAttribute("message", "Changes Saved Successfully");
                            response.sendRedirect("userProfile.jsp?option=" + option);
                        }
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


                            SendEmail sm = new SendEmail();
                            String otp = sm.getOTP();

                            String subject = "Request for Password Change";
                            String msgContent = "<body style=\"background: lightgrey; \">" +
                                    "<div class=\"container\" style=\"background: #f5f5f5; \">" +
                                    "<center><img src=\"cid:image\" alt=\"logo-image\" ></center>" +
                                    "<div style=\"text-align: center;\"><h1>ALERT" + "!</h1>" +
                                    "Request to change password is made for your ShopHere account.<br>" +
                                    "Enter the given <span style=\"background: yellow;\">OTP</span> to process password change." +
                                    "<br>Please do not share OTP with anyone.<br>" +
                                    "<span style=\"font-weight: bold; font-size: 20px;margin-bottom: 10px;\">" + otp + "</span>" +
                                    "</div></div>" +
                                    "</body>";
                            boolean test = sm.sendEmail(user.getUserName(), user.getUserEmail(), otp, msgContent, subject);

                            //check if the email send successfully

                            if (test) {
                                httpSession.setAttribute("authentication-code", otp);

                                httpSession.setAttribute("new_pwd", new_pwd);
                                httpSession.setAttribute("option", option);
                                response.sendRedirect("verify.jsp");

                            } else {
                                httpSession.setAttribute("message", "Failed to send verification email");
                                response.sendRedirect("userProfile.jsp?option=\" + option");
                            }

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
