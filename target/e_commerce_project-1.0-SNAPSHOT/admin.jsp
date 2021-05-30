<%@ page import="com.example.myProject.entities.User" %>
<%@ page import="com.example.myProject.dao.CategoryDao" %>
<%@ page import="com.example.myProject.FactoryProvider" %>
<%@ page import="com.example.myProject.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.myProject.dao.UserDao" %>
<%@ page import="com.example.myProject.dao.ProductDao" %>
<%
    User user= (User) session.getAttribute("current-user");
    if(user==null){
        session.setAttribute("message","You are not logged in !!<br>" +
                "Login first");
        response.sendRedirect("login.jsp");
        return;
    }else{
        if(user.getUserType().equals("normal")){
            session.setAttribute("message","Access denied!!<br>" +
                    "You are not Admin");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Page</title>
    <%@include file="components/common_css_js.jsp" %>
    <style>
        /*.modal-header{*/
        /*    background: #CFD8DC;*/
        /*}*/
        .card {
            background: pink;
            border: 1px solid crimson;
        }
        .card:hover{
            background: lightgrey;
            cursor: pointer;
        }
    </style>

</head>
<body>
    <%@include file="components/navbar.jsp" %>
    <!-- Display code for admin panel-->
    <div class="container admin">
        <div class="container-fluid mt-4 text-center ">
            <%@include file="components/message.jsp"%>
        </div>
        <!-- 1st row -->
        <div class="row mt-4">
            <!-- 1st column -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 110px" class="img-fluid" src="img/customer.png" alt="Users_icon">
                        </div>
                        <h1><%= new UserDao(FactoryProvider.getFactory()).getTotalUsers()%></h1>
                        <h1 class="text-uppercase text-muted">Users</h1>
                    </div>
                </div>
            </div>
            <!-- 2nd column -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 110px" class="img-fluid" src="img/categories.png" alt="Category_icon">
                        </div>
                        <h1><%= new CategoryDao(FactoryProvider.getFactory()).getTotalCategories()%></h1>
                        <h1 class="text-uppercase text-muted">Categories</h1>
                    </div>
                </div>
            </div>
            <!-- 3rd column -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 110px" class="img-fluid" src="img/shopping-cart.png" alt="Product_icon">
                        </div>
                        <h1><%= new ProductDao(FactoryProvider.getFactory()).getTotalProducts()%></h1>
                        <h1 class="text-uppercase text-muted">Products</h1>
                    </div>
                </div>
            </div>

        </div>
        <!-- 2st row -->
        <div class="row mt-3">
            <!-- 2nd row - 1st col -->
            <div class="col-md-6">
                <div class="card" data-toggle="modal" data-target="#addCategoryModal">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 110px" class="img-fluid" src="img/list.png" alt="Category_icon">
                        </div>
                        <p class="mt-3">Click here to add new category</p>
                        <h1 class="text-uppercase text-muted">Add Category</h1>
                    </div>
                </div>
            </div>
            <!-- 2nd row - 2st col -->
            <div class="col-md-6">
                <div class="card" data-toggle="modal" data-target="#addProductModal">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 110px" class="img-fluid" src="img/plus.png" alt="Product_icon">
                        </div>
                        <p class="mt-3">Click here to add new product</p>
                        <h1 class="text-uppercase text-muted">Add Product</h1>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Add category modal -->

    <!-- Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="modal1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark text-light">
                    <h4 class="modal-title" id="modal1">Fill category details</h4>
                    <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="ProductOperationServlet" method="post">
                        <input type="hidden" name="operation" value="addcategory">
                        <div class="form-group">
                            <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
                        </div>
                        <div class="form-group">
                            <textarea style="height: 200px" class="form-control" name="catDescription" placeholder="Enter category description"  required></textarea>
                        </div>
                        <div class="container text-center">
                            <button class="btn btn-outline-success mx-4">Add Category</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- end of category modal--%>
    <%-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------   --%>

    <!-- Add product modal -->

    <!-- Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="modal2" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark text-light">
                    <h4 class="modal-title" id="modal2">Fill product details</h4>
                    <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="operation" value="addproduct"/>
                        <div class="form-group">
                            <input type="text" class="form-control" name="pName" placeholder="Enter product name" required/>
                        </div>
                        <div class="form-group">
                            <textarea style="height: 100px" class="form-control" name="pDesc" placeholder="Enter product description" required></textarea>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control" name="pPrice" placeholder="Enter product price" required/>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control" name="pDiscount" placeholder="Enter discount offered" required/>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control" name="pQuantity" placeholder="Enter product quantity" required/>
                        </div>
                        <%
                            CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                            List<Category> categories = categoryDao.getAllCategories();
                        %>
                        <div class="form-group">
                            <select class="form-control" name="categoryId">
                                <%
                                    for(Category c : categories){
                                %>
                                <option value="<%= c.getCategoryID() %>"> <%= c.getCategoryTitle() %></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pPhoto">Choose Product Image</label><br>
                            <input type="file" id="pPhoto" name="pPhoto" required/>
                        </div>
<%--                        <div class="dropdown">--%>
<%--                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
<%--                                Select product category--%>
<%--                            </button>--%>
<%--                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">--%>
<%--                                <a class="dropdown-item" href="#">Action</a>--%>
<%--                                <a class="dropdown-item" href="#">Another action</a>--%>
<%--                                <a class="dropdown-item" href="#">Something else here</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class="container text-center">
                            <button class="btn btn-outline-success mx-4">Add Product</button>
                            <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- end of product modal--%>

</body>
</html>
