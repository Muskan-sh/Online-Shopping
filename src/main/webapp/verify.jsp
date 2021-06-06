
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Verify Page</title>
</head>
<body>
<h2>We already send a verification  code to your email.</h2>

<%@include file="components/message.jsp" %>
<%
  HttpSession httpSession= request.getSession();
  String senderPage= (String) httpSession.getAttribute("senderPage");
  if(senderPage!=null && senderPage.equals("register")){

%>
<form action="VerifyCodeServlet" method="post">
  <%
    }
  else{
  %>
    <form action="ChangePasswordServlet" method="post">
<%
  }
%>


    <input type="number" name="otp" >
  <input type="submit" value="verify">
</form>
</body>
</html>
