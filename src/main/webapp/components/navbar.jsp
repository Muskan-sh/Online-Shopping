<%@ page import="com.example.myProject.entities.User" %>
<%@ page import="com.example.myProject.dao.CartDao" %>
<%@ page import="com.example.myProject.FactoryProvider" %>
<%
    User user1= (User) session.getAttribute("current-user");
%>

<%@include file="common_css_js.jsp" %>
<style>
    .bg{
        background: #116466 !important;
    }
    .bg2{
        font-size: large;
        font-weight: 600;
        color: #d1e8e2 !important;
    }
</style>


<nav class="navbar navbar-expand-lg bg navbar-light">
    <div class="container">
        <a href="index.jsp" class="navbar-brand">
            <span style="font-size: x-large; color: #d1e8e2;font-weight: bold">ShopHere</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link bg2" href="index.jsp">Home </a>
                </li>
<%--                <li class="nav-item dropdown">--%>
<%--                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">--%>
<%--                        Categories--%>
<%--                    </a>--%>
<%--                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">--%>
<%--                        <a class="dropdown-item" href="#">Action</a>--%>
<%--                        <a class="dropdown-item" href="#">Another action</a>--%>
<%--                        <div class="dropdown-divider"></div>--%>
<%--                        <a class="dropdown-item" href="#">Something else here</a>--%>
<%--                    </div>--%>
<%--                </li>--%>

            </ul>

            <ul class="navbar-nav ml-auto">

                <li class="nav-item active">
                    <a class="nav-link mx-3" href="cart.jsp" ><i class="fas fa-shopping-cart mr-1 " style="font-size: 22px;color: #d1e8e2"></i><span class="bg2">
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
                        <a class="nav-link bg2" href="login.jsp">Login/Sign Up</a>
                    </li>
<%--                    <li class="nav-item active">--%>
<%--                        <a class="nav-link" href="register.jsp">Register</a>--%>
<%--                    </li>--%>

                <%
                    }else if(user1.getUserType().equals("admin")){
                %>
                    <li class="nav-item active">
                        <a class="nav-link bg2 mx-3" href="admin.jsp">Hello, <%= user1.getUserName().substring(0,user1.getUserName().indexOf(" "))%> </a>
                    </li>
<%--                    <li class="nav-item active">--%>
<%--                        <a class="nav-link" href="admin.jsp">Admin Panel</a>--%>
<%--                    </li>--%>
                    <li class="nav-item active">
                        <a class="nav-link bg2" href="LogoutServlet">Logout</a>
                    </li>
                <%
                    }else{
                %>
                    <li class="nav-item active">
                        <a class="nav-link bg2 mx-3" href="userProfile.jsp">Hello, <%= user1.getUserName().substring(0,user1.getUserName().indexOf(" "))%> </a>
                    </li>
<%--                    <li class="nav-item active">--%>
<%--                        <a class="nav-link" href="normal.jsp">Profile</a>--%>
<%--                    </li>--%>
                    <li class="nav-item active">
                        <a class="nav-link bg2" href="LogoutServlet">Logout</a>
                    </li>
                <%
                    }
                %>

            </ul>

        </div>
    </div>
</nav>