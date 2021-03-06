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
    <style>
        table{
            /*border-collapse: collapse;*/
            border: solid 1px #116466 !important;
        }
        /*tr{*/
        /*    border: solid 1px #116466;*/
        /*}*/
        .custom-head{
            background:#116466;
            color: #d1e8e2;
        }
    </style>
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
    <h2 class="my-4 text-center" style=" font-weight: bold">Cart is empty!!</h2>
    <div class="text-center">
        <a class="btn mt-5" style="background: #116466; color: #d1e8e2;" href="index.jsp" role="button">Add items to Cart</a>
    </div>
    <%
    } else {
    %>
    <h2 class="my-4 text-center" style=" font-weight: bold">Your Cart</h2>
    <table class="table table-hover  text-center ">
        <thead class="custom-head">
        <tr>
            <th scope="col">Product Image</th>
            <th scope="col">Product Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Total Price</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody style="background: #f5f5f5;">
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

                    <button class="btn btn-danger">Remove</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="row my-4">
        <div class="col-md-4 offset-md-4" >
            <a class="btn " style="background: #116466; color: #d1e8e2;" href="index.jsp" role="button">Add More Items</a>
            <form action="" method="post" style="float: right;">
                <button class="btn" style="background: #116466; color: #d1e8e2;">Checkout</button>
            </form>
        </div>
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
