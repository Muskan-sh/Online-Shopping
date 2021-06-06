package com.example.myProject.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "VerifyCodeServlet", value = "/VerifyCodeServlet")
public class VerifyCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession httpSession = request.getSession();
            String authcode= (String) httpSession.getAttribute("authentication-code");
            String senderPage= (String) httpSession.getAttribute("senderPage");

            String otp = request.getParameter("otp");

            if(otp.equals(authcode)){
                httpSession.removeAttribute("authentication-code");
                if(senderPage.equals("register"))
                    response.sendRedirect("RegisterServlet");
                else
                    response.sendRedirect("ChangePasswordServlet");
            }
            else{
                httpSession.setAttribute("message", "Incorrect verification code");
                response.sendRedirect("verify.jsp");
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}