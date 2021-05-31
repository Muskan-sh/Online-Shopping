<%@ page import="com.example.myProject.dao.CartDao" %>
<%@ page import="com.example.myProject.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.myProject.entities.Cart" %>
<%@ page import="com.example.myProject.entities.User" %>
<%@ page import="com.example.myProject.dao.ProductDao" %>
<%@ page import="com.example.myProject.entities.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Your Cart</title>
    <%@include file="components/common_css_js.jsp" %>

</head>
<body>
<%@include file="components/navbar.jsp" %>

<div class="container">
    <div class="container-fluid mt-2 text-center ">
        <%@include file="components/message.jsp" %>
    </div>
    <%
        HttpSession httpSession = request.getSession();
        System.out.println(user1);
        if (user1 == null) {
            httpSession.setAttribute("message", "Login To view Cart details!!");
            response.sendRedirect("login.jsp");
            return;
        } else {
            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

            CartDao cdao = new CartDao(FactoryProvider.getFactory());
            List<Cart> items = cdao.getCartItemsByUserId(user1.getUserID());
            httpSession.setAttribute("cart_List", items);
            if (items.size() == 0) {
    %>
    <h1 class="text-dark text-center mt-5">Cart is empty!!</h1>
    <div class="text-center">
        <a class="btn btn-outline-primary mt-5" href="index.jsp" role="button">Add items to Cart</a>
    </div>
    <%
    } else {
    %>
    <h1 class="mt-4 text-center">Your Cart</h1>
    <table class="table table-hover mt-4 text-center ">
        <thead class="thead-dark ">
        <tr>
            <th scope="col">Product Image</th>
            <th scope="col">Product Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Total Price</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            int i = -1;
            for (Cart item : items) {
                i++;
                Product p = pdao.getProductById(item.getCartPK().getProductId());
        %>
        <tr>
            <td>
                <div class="container">
                    <img style="max-height: 110px; max-width: 95%; width: auto; " class="img-fluid"
                         src="product_images/<%=p.getpPhoto() %>"
                         alt="Product image">
                </div>
            </td>
            <th scope="row"><%=p.getpName()%>
            </th>
            <td><%=p.getpPrice()%>
            </td>
            <td>
                <form action="UpdateCartServlet" method="post" style="float:left;">
                    <input type="hidden" name="operation" value="decrease">
                    <input type="hidden" name="object_name" value="<%=p.getpID()%>">
                    <input type="hidden" name="cart_item" value="<%=i%>">

                    <button class="btn btn-transparent"><i class="fas fa-minus-circle" style="font-size: 20px;"></i>
                    </button>
                </form>
                <%=item.getAmount()%>
                <form action="UpdateCartServlet" method="post" style="float: right;">
                    <input type="hidden" name="operation" value="increase">
                    <input type="hidden" name="object_name" value="<%=p.getpID()%>">
                    <input type="hidden" name="cart_item" value="<%=i%>">

                    <button class="btn btn-transparent"><i class="fas fa-plus-circle" style="font-size: 21px;"></i>
                    </button>
                </form>

            </td>
            <td><%= p.getpPrice() * item.getAmount()%>
            </td>
            <td>
                <form action="UpdateCartServlet" method="post">
                    <input type="hidden" name="operation" value="remove">
                    <input type="hidden" name="object_name" value="<%=p.getpID()%>">
                    <input type="hidden" name="cart_item" value="<%=i%>">

                    <button class="btn btn-outline-danger">Remove</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="text-center mt-5">
        <form action="" method="post">
            <button class="btn btn-outline-primary">Checkout</button>
        </form>
    </div>
    <%
        }
    %>

    <%
        }
    %>


</div>


</body>
</html>

<%--<div class="row mt-2">&ndash;%&gt;--%>
<%--                    <div class="col-md-6 offset-md-3">--%>
<%--                        <div class="card">--%>
<%--                            <p class="bg-dark text-white "><%=p.getpName()%></p>--%>
<%--                            <div class="card-body">--%>
<%--                                    <div class="container">--%>
<%--                                        <img style="max-height: 110px; max-width: 95%; width: auto; " class="img-fluid"--%>
<%--                                             src="product_images/<%=p.getpPhoto() %>"--%>
<%--                                             alt="Category_icon">--%>
<%--                                    </div>--%>
<%--                                &nbsp;--%>

<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>