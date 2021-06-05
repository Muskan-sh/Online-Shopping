
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Verify Page</title>
</head>
<body>
<h2>We already send a verification  code to your email.</h2>

<%@include file="components/message.jsp" %>

<form action="VerifyCodeServlet" method="post">


  <input type="number" name="otp" >
  <input type="submit" value="verify">
</form>
</body>
</html>
