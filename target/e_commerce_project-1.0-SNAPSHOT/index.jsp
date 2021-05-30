<%@ page import="com.example.myProject.FactoryProvider" %>
<%@ page import="com.example.myProject.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.myProject.entities.Product" %>
<%@ page import="com.example.myProject.dao.CategoryDao" %>
<%@ page import="com.example.myProject.entities.Category" %>
<%@ page import="com.example.myProject.Helper" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ShopHere</title>
    <%@include file="components/common_css_js.jsp" %>

    <style>
        .discount-label{
            font-size: 14px !important;
            font-style: italic !important;
        }
        .original-price-label{
            font-size: 14px !important;
            font-style: italic !important;
            text-decoration: line-through !important;
        }
        .card {
            border: 1px solid darkblue;
        }
        .card:hover{
            background: powderblue;
            cursor: pointer;
        }
    </style>


</head>
<body>
    
    <%@include file="components/navbar.jsp"%>
    <div class="container-fluid">
    <div class="row mt-4 mx-3">

        <%
            String cat= request.getParameter("category");
//            out.println(cat);

            ProductDao pdao= new ProductDao(FactoryProvider.getFactory());
            List<Product> plist=null;
            if(cat==null || cat.trim().equals("all") ){
                plist= pdao.getAllProducts();
            }else {
                int cId= Integer.parseInt(cat);
                plist=pdao.getProductsByCategoryId(cId);
            }
            CategoryDao cdao= new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist= cdao.getAllCategories();
        %>

        <%--    Display categories    --%>
        <div class="col-md-2">

            <div class="list-group">
                <a href="index.jsp?category=all" class="list-group-item list-group-item-action active bg-dark text-white border-dark" aria-current="true">
                    All Products
                </a>
                <%
                    for(Category c:clist){
                %>
                        <a href="index.jsp?category=<%= c.getCategoryID()%>" class="list-group-item list-group-item-action">
                            <%= c.getCategoryTitle() %>
                        </a>

                <%
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
                                for(Product p:plist) {
//                                String path = null;
//                                try {
//                                    path = "resources/product_images/" + product.getpPhoto();
//                                    System.out.println(path);
//                                } catch (Exception e) {
//                                    e.printStackTrace();
//                                }
                            %>
                                <!-- Product Card -->

                                <div class="card product-card">
                                    <div class="container text-center">
                                        <img src="product_images/<%=p.getpPhoto() %>" style="max-height: 250px; max-width: 95%; width: auto; " class="card-img-top m-2" alt="Product image">
                                    </div>
                                    <div class="card-body">
                                        <h4 class="card-title"><%=p.getpName()%> </h4>
                                        <p class="card-text">
                                            <%=Helper.get10Words(p.getpDescription())%>
                                        </p>
                                    </div>
                                    <div class="card-footer text-center">
                                        <button class="btn bg-dark text-light" onclick="add_to_cart(<%= p.getpID()%>,'<%= p.getpName()%>','<%= p.getSellingPrice()%>')">Add to Cart</button>
                                        <button class="btn border-primary text-dark">&#8377; <%=p.getSellingPrice()%>/- <span class="text-secondary original-price-label">&#8377; <%=p.getpPrice()%></span><span class="text-dark discount-label"> <%=p.getpDiscount()%>% Off</span></button>
                                    </div>
                                </div>

                            <%
                                }

                                if(plist.size()==0){
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
