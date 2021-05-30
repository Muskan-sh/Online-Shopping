<%@ page import="com.example.myProject.entities.User" %>
<%
    User user= (User) session.getAttribute("current-user");
    if(user==null){
        session.setAttribute("message","You are not logged in !!<br>" +
                "Login first");
        response.sendRedirect("login.jsp");
        return;
    }else{
        if(user.getUserType().equals("admin")){
            session.setAttribute("message","Access denied!!<br>" +
                    "Admin can not access someone else's account");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User-Home page</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
    <%@include file="components/navbar.jsp" %>
    <h1>Normal User's Profile</h1>
</body>
</html>
