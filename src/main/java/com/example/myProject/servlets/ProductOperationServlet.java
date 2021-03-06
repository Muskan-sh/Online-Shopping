package com.example.myProject.servlets;

import com.example.myProject.FactoryProvider;
import com.example.myProject.Helper;
import com.example.myProject.dao.CategoryDao;
import com.example.myProject.dao.ProductDao;
import com.example.myProject.entities.Category;
import com.example.myProject.entities.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet(name = "ProductOperationServlet", value = "/ProductOperationServlet")
public class ProductOperationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {

                // Adding category
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category added successfully!!<br>" +
                        "Category Id is : " + catId);
                response.sendRedirect("admin.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {

                // adding product
                String name = request.getParameter("pName");
                String description = request.getParameter("pDesc");
                int price = Integer.parseInt(request.getParameter("pPrice"));
                int discount = Integer.parseInt(request.getParameter("pDiscount"));
                int quantity = Integer.parseInt(request.getParameter("pQuantity"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Part part = request.getPart("pPhoto");
                String photo = part.getSubmittedFileName();

                Product product = new Product();
                product.setpName(name);
                product.setpDescription(description);
                product.setpPrice(price);
                product.setpDiscount(discount);
                product.setpQuantity(quantity);
                product.setpPhoto(photo);

                // Category by ID..
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = categoryDao.getCategoryById(categoryId);
                product.setCategory(category);

                // product saved..

                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                int pId = productDao.saveProduct(product);

                productDao.updateProductPhoto(product, category.getCategoryTitle().replace(' ','-') + "-" + pId +photo.substring(photo.indexOf('.')));

                //uploading pic

                try {
                    Helper.uploadPhoto("product_images",product.getpPhoto(),part);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Product added successfully!!<br>" +
                        "Product Id is : " + pId);
                response.sendRedirect("admin.jsp");

            }


        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
