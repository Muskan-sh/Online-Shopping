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

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int productId = Integer.parseInt(request.getParameter("productId"));
            int userId = 0;

            HttpSession httpSession = request.getSession();

            User user = (User) httpSession.getAttribute("current-user");
            System.out.println(user);
            if (user == null) {
                httpSession.setAttribute("message", "You need to Login before adding items in Cart!!");
                response.sendRedirect("login.jsp");
                return;
            } else {
                userId = user.getUserID();
            }

            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
            Product p = pdao.getProductById(productId);


            CartDao cartDao = new CartDao(FactoryProvider.getFactory());
            List<Cart> items = cartDao.getAllCartItems();

            Cart cartItem = new Cart(new Cart.CartPK(userId, productId));
            boolean added = false;
            try {
                if (items.size() != 0) {
                    for (Cart item : items) {
                        if (item.getCartPK().equals(cartItem.getCartPK())) {
                            if (item.getAmount() == p.getpQuantity()) {
                                added = true;
                                httpSession.setAttribute("message", "Product quantity can't be increased due to <strong>stock limits</strong>!!");
                                response.sendRedirect("index.jsp");
                            } else {
                                cartDao.increseAmountBy1(item);
                                added = true;
                                httpSession.setAttribute("message", "Product quantity increased!!");
                                response.sendRedirect("index.jsp");
                            }
                            break;
                        }
                    }
                }
                if (!added) {
                    cartDao.saveItemInCart(cartItem);
                    httpSession.setAttribute("message", "Product added in Cart!!");
                    response.sendRedirect("index.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

//            out.println("User Id: " + user.getUserID() + "<br>Product Id: " + productId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
