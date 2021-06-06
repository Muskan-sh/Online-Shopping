package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "ChangePasswordServlet", value = "/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession httpSession=request.getSession();
            String new_pwd= (String) httpSession.getAttribute("new_pwd");
            String option= (String) httpSession.getAttribute("option");

            User user= (User) httpSession.getAttribute("current-user");

            UserDao userDao=new UserDao(FactoryProvider.getFactory());
            user.setUserPassword(new_pwd);
            userDao.updateUser(user);

            httpSession.removeAttribute("new_pwd");
            httpSession.removeAttribute("option");

            httpSession.setAttribute("message", "Changes Saved Successfully");
            response.sendRedirect("userProfile.jsp?option=" + option);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
