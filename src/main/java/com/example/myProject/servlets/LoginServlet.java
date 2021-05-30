package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out =response.getWriter()){

            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            // Validations
            // Authentication
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(userEmail,userPassword);

            HttpSession httpSession= request.getSession();

            if(user == null){
                httpSession.setAttribute("message","Invalid Details or User doesn't exist!!" );
                response.sendRedirect("login.jsp");
            }else{
                //login approved
                httpSession.setAttribute("current-user",user);
                if (user.getUserType().equals("admin")){
                    // admin page
                    response.sendRedirect("index.jsp");
                }
                else if(user.getUserType().equals("normal")){
                    // normal user page
                    response.sendRedirect("index.jsp");
                }
                else {
                    out.println("User type could not be identified");
                }
            }

        }

        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }
}
