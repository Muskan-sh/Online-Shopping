package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.dao.CartDao;
import com.example.myProject.dao.ProductDao;
import com.example.myProject.entities.Cart;
import com.example.myProject.entities.Product;
import com.example.myProject.entities.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "UpdateCartServlet", value = "/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    @Override
    @SuppressWarnings(value = "unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession httpSession = request.getSession();

            String op= request.getParameter("operation");
            Cart cartItem = ((List<Cart>) httpSession.getAttribute("cart_List")).get(Integer.parseInt(request.getParameter("cart_item")));

            int pid=Integer.parseInt(request.getParameter("object_name"));
            int uid= ((User)httpSession.getAttribute("current-user")).getUserID();

            System.out.println(op);

            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
            Product p = pdao.getProductById(pid);

            CartDao cdao= new CartDao(FactoryProvider.getFactory());


            if(op.trim().equals("decrease")){
                if(cartItem.getAmount()==1){
                    httpSession.setAttribute("message", "Minimum product quantity is 1  !!");
                    response.sendRedirect("cart.jsp");
                }else {
                    cdao.decreaseAmountBy1(cartItem);
                    response.sendRedirect("cart.jsp");
                }

            }
            else if(op.trim().equals("increase")){
                if (cartItem.getAmount() == p.getpQuantity()) {
                    httpSession.setAttribute("message", "Product quantity can't be increased due to stock limits!!");
                    response.sendRedirect("cart.jsp");
                } else {
                    cdao.increseAmountBy1(cartItem);
                    response.sendRedirect("cart.jsp");
                }
            }
            else if(op.trim().equals("remove")){
                cdao.removeItem(pid,uid);
                httpSession.setAttribute("message", "Product Removed from cart!!");
                response.sendRedirect("cart.jsp");
            }



        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
