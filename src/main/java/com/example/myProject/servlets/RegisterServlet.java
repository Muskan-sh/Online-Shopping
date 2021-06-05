package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;
import com.example.myProject.mail.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                HttpSession httpSession  = request.getSession();

                String userName= (String) httpSession.getAttribute("name");
                String userEmail= (String) httpSession.getAttribute("email");
                String userPassword= (String) httpSession.getAttribute("password");
                String userPhone= (String) httpSession.getAttribute("phone");


                // creating User object
                String userType = "";
                if (userEmail.equals("shopherewebsite@gmail.com")) {
                    userType = "admin";
                } else {
                    userType = "normal";
                }
                User user = new User(userName, userEmail, userPassword, userPhone,
                        "user (1).png", "", userType);

                UserDao userDao = new UserDao(FactoryProvider.getFactory());
                int userId = userDao.saveUser(user);

                httpSession.removeAttribute("name");
                httpSession.removeAttribute("email");
                httpSession.removeAttribute("password");
                httpSession.removeAttribute("phone");

                httpSession.setAttribute("message", "Registration Successful !!");
                response.sendRedirect("login.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
