<%@ page import="com.example.myProject.FactoryProvider" %>
<%@ page import="com.example.myProject.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.myProject.entities.Product" %>
<%@ page import="com.example.myProject.dao.CategoryDao" %>
<%@ page import="com.example.myProject.entities.Category" %>
<%@ page import="com.example.myProject.entities.User" %>
<%@ page import="com.example.myProject.Helper" %>
<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <title>ShopHere</title>
    <%@include file="components/common_css_js.jsp" %>
    <style>
        .discount-label {
            font-size: 14px !important;
            font-style: italic !important;
        }

        .original-price-label {
            font-size: 14px !important;
            font-style: italic !important;
            text-decoration: line-through !important;
        }

        .card, .custom-border {
            background: #f5f5f5 !important;
            border: 1px solid #116466 !important;
        }

        .card:hover {
            background: #d1e8e2 !important;
            cursor: pointer !important;
        }

        .stock {
            color: red !important;
        }
    </style>


</head>
<body>

<%@include file="components/navbar.jsp" %>
<div class="container-fluid">
    <%@include file="components/message.jsp" %>
    <div class="row mt-4 mx-3">

        <%
            String cat = request.getParameter("category");
//            out.println(cat);

            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
            List<Product> plist = null;
            int cId = 0;
            if (cat == null || cat.trim().equals("all")) {
                cId = 0;
                plist = pdao.getAllProducts();
            } else {
                cId = Integer.parseInt(cat);
                plist = pdao.getProductsByCategoryId(cId);
            }
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist = cdao.getAllCategories();
        %>

        <%--    Display categories    --%>
        <div class="col-md-2">

            <div class="list-group">
                <a href="index.jsp?category=all" class="list-group-item list-group-item-action active"
                   style="background: #116466; border: #116466;" aria-current="true">
                    All Products
                </a>
                <%
                    for (Category c : clist) {
                        if (cId != 0 && c.getCategoryID() == cId) {
                %>
                <a href="index.jsp?category=<%= c.getCategoryID()%>" style="background: #f5f5f5;color: #116466;font-weight: bold;"
                   class="list-group-item list-group-item-action active" >
                    <%= c.getCategoryTitle() %>
                </a>
                <%
                } else {
                %>
                <a href="index.jsp?category=<%= c.getCategoryID()%>" style="background: #f5f5f5;"
                   class="list-group-item list-group-item-action ">
                    <%= c.getCategoryTitle() %>
                </a>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <%--      Display Products      --%>
        <div class="col-md-9">

            <div class="row ">
                <div class="col-md-12">
                    <div class="card-columns">
                        <%--  Traversing products --%>
                        <%
                            for (Product p : plist) {
                        %>
                        <!-- Product Card -->

                        <div class="card product-card">
                            <div class="container text-center">
                                <img src="product_images/<%=p.getpPhoto() %>"
                                     style="max-height: 180px; max-width: 80%; width: auto; " class="card-img-top m-2"
                                     alt="Product image">
                            </div>


                            <div class="card-body">
                                <h4 class="card-title"><%=p.getpName()%>
                                </h4>
                                <p class="card-text">
                                    <%=Helper.get10Words(p.getpDescription())%>
                                </p>
                            </div>
                            <div class="card-footer text-center">
                                <%
                                    if (p.getpQuantity() == 0) {
                                %>
                                <p class="stock">Out of Stock</p>
                                <%
                                } else {
                                %>
                                <form action="AddToCartServlet" method="post">
                                    <input type="hidden" name="productId" value="<%= p.getpID()%>">
                                    <button class="btn " style="background: #116466; color: #d1e8e2;">Add to Cart
                                    </button>
                                </form>
                                <%
                                    }
                                %>
                                <a class="btn custom-border mt-1 " href="#"><span style="color: black;font-weight: 500">&#8377; <%=p.getSellingPrice()%>/-</span>
                                    <span class="text-secondary original-price-label">&#8377; <%=p.getpPrice()%></span><span
                                            class="text-dark discount-label"> <%=p.getpDiscount()%>% Off</span></a>
                            </div>
                        </div>

                        <%
                            }

                            if (plist.size() == 0) {
                                out.println("<h3>No item in this category..</h3>");
                            }
                        %>

                    </div>

                </div>
            </div>

        </div>

    </div>
</div>

</body>
</html>
