package com.example.myProject.servlets;

import com.example.myProject.mail.SendEmail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SendEmailServlet", value = "/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
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

                httpSession.setAttribute("name",name);
                httpSession.setAttribute("email",email);
                httpSession.setAttribute("password",password);
                httpSession.setAttribute("phone",phone);

                //get the 6-digit code
                SendEmail sm = new SendEmail();
                String otp = sm.getOTP();

                //call the send email method
                boolean test = sm.sendEmail(name, email, otp);

                //check if the email send successfully

                if (test) {
                    httpSession.setAttribute("authentication-code", otp);
                    response.sendRedirect("verify.jsp");
                } else {
                    httpSession.setAttribute("message", "Failed to send verification email");
                    response.sendRedirect("register.jsp");
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
