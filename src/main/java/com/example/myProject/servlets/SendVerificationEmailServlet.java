package com.example.myProject.servlets;

import com.example.myProject.mail.SendEmail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SendVerificationEmailServlet", value = "/SendVerificationEmailServlet")
public class SendVerificationEmailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                String name = request.getParameter("user_name");
                String email = request.getParameter("user_email");
                String password = request.getParameter("user_password");
                String phone = request.getParameter("user_phone");

                HttpSession httpSession = request.getSession();

                if(name.isBlank() || email.isBlank() || password.isBlank() || phone.isBlank()){
                    httpSession.setAttribute("message","Field(s) can't be Empty");
                    response.sendRedirect("register.jsp");
                }
                else{
                    httpSession.setAttribute("name",name);
                    httpSession.setAttribute("email",email);
                    httpSession.setAttribute("password",password);
                    httpSession.setAttribute("phone",phone);

                    //get the 6-digit code
                    SendEmail sm = new SendEmail();
                    String otp = sm.getOTP();

                    //call the send email method

                    String subject= "Verify your Email on ShopHere";
                    String msgContent= "<body style=\"background: lightgrey; \">" +
                            "<div class=\"container\" style=\"background: #f5f5f5; \">" +
                            "<center><img src=\"cid:image\" alt=\"logo-image\" ></center>" +
                            "<div style=\"text-align: center;\"><h1>Welcome " + name.substring(0, name.indexOf(" ")) + "!</h1>" +
                            "<p style=\"font-size:15px; font-weight:500;\">Thanks for choosing ShopHere.</p>" +
                            "To complete your sign up, please verify your email by entering the given <span style=\"background: yellow;\">OTP</span>." +
                            "<br>Please do not share OTP with anyone.<br>" +
                            "<span style=\"font-weight: bold; font-size: 20px;margin-bottom: 10px;\">" + otp +"</span>"+
                            "</div></div>" +
                            "</body>";
                    boolean test = sm.sendEmail(name, email, otp,msgContent,subject);

                    //check if the email send successfully

                    if (test) {
                        httpSession.setAttribute("authentication-code", otp);
                        httpSession.setAttribute("senderPage","register");
                        response.sendRedirect("verify.jsp");
                    } else {
                        httpSession.setAttribute("message", "Failed to send verification email");
                        response.sendRedirect("register.jsp");
                    }
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
