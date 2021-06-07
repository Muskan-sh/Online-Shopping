<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Verify Page</title>
    <%@include file="components/common_css_js.jsp" %>


</head>
<body>


<div class="container">
    <div class="row my-5">
        <div class="col-md-4 offset-md-4 ">
            <%@include file="components/message.jsp" %>
            <div class="card" style="background: #fafafa ;">
                <div class="card-header text-center" style="background: #f5f5f5;color: #116466;font-weight: bold;font-size: x-large;">
                    Verify
                </div>
                <div class="card-body text-center">
                    Verification mail has been sent in your registered email id.
                    <br>Enter the otp to continue the request.

                        <form action="VerifyCodeServlet" method="post">

<%--                        <form action="ChangePasswordServlet" method="post">--%>

                            <div class="form-group ">
                                <input class="form-control" style="width: 110px; margin-left: auto;margin-right: auto;" type="number" name="otp" required>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-block" style="background: #116466;color: #d1e8e2;">Verify</button>
                            </div>
                    </form>

                    <%
                        HttpSession httpSession = request.getSession();
                        String senderPage = (String) httpSession.getAttribute("senderPage");
                        String option= (String) httpSession.getAttribute("option");

                        httpSession.setAttribute("message","Verification Failed");
                        if (senderPage != null && senderPage.equals("register")) {
                    %>
                    <div>
                        <a type="button" role="button" class="btn btn-block btn-outline-danger" href="register.jsp">Cancel</a>
                    </div>
                    <%
                    }
                    else{
                    %>

                    <div>
                        <a type="button" role="button" class="btn btn-block btn-outline-danger" href="userProfile.jsp?option=<%=option%>">Cancel</a>
                    </div>
                    <%
                        }
                    %>

                </div>

            </div>

        </div>
    </div>

</div>


</body>
</html>
