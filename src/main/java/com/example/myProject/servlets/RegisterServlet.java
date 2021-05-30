package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.dao.UserDao;
import com.example.myProject.entities.User;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out =response.getWriter()){

            try {
                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");

                // Validations...
                // creating User object
                User user = new User(userName,userEmail,userPassword,userPhone,
                        "default.jpg",userAddress,"normal");

                UserDao userDao=new UserDao(FactoryProvider.getFactory());
                int userId=userDao.saveUser(user);

                HttpSession httpSession= request.getSession();
                httpSession.setAttribute("message","Registration Successful !!" +
                        "<br> Your User Id is "+userId );
                response.sendRedirect("login.jsp");
                return;

            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }
}
