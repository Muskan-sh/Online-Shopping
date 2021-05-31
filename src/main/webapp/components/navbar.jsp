<%@ page import="com.example.myProject.entities.User" %>
<%@ page import="com.example.myProject.dao.CartDao" %>
<%@ page import="com.example.myProject.FactoryProvider" %>
<%
    User user1= (User) session.getAttribute("current-user");
%>

<%@include file="common_css_js.jsp" %>


<nav class="navbar navbar-expand-lg navbar-dark bg-dark ">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">ShopHere</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
                <li class="nav-item active">
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">

                <li class="nav-item active">
                    <a class="nav-link" href="cart.jsp" ><i class="fas fa-shopping-cart mr-1 " style="font-size: 20px;" ></i><span class="cart-items">

                    <%
                        if(user1==null){
                    %>
                            (0)
                    <%
                        }else{
                            CartDao cdao= new CartDao(FactoryProvider.getFactory());
                    %>
                            (<%= cdao.getCartItemsByUserId(user1.getUserID()).size()%>)
                    <%
                            }
                    %>
                    </span></a>
                </li>

                <%if(user1==null){
                %>
                    <li class="nav-item active">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="register.jsp">Register</a>
                    </li>

                <%
                    }else if(user1.getUserType().equals("admin")){
                %>
                    <li class="nav-item active">
                        <a class="nav-link" href="#!">Hello <%= user1.getUserName()%> </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="admin.jsp">Admin Panel</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                <%
                    }else{
                %>
                    <li class="nav-item active">
                        <a class="nav-link" href="#!">Hello <%= user1.getUserName()%> </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="normal.jsp">Profile</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                <%
                    }
                %>

            </ul>

        </div>
    </div>
</nav>