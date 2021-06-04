<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login Page</title>
    <%@include file="components/common_css_js.jsp" %>
<%--<style>--%>
<%--    a:link{--%>
<%--        color: #116466 !important;--%>
<%--    }--%>
<%--    a:hover{--%>
<%--        color: lightseagreen;--%>
<%--    }--%>
<%--</style>--%>

</head>
<body>

<!-- Navbar -->
<div class="container text-center mt-3">
    <a href="index.jsp" class="navbar-brand">
        <img src="img/myLogo.png" class="image-fluid" alt="logo" width="180">
    </a>
</div>


    <div class="container">
        <div class="row py-5">
            <div class="col col-md-10 offset-md-1">
                <div class="card" style="border: none;background: #ffe0b2;">

                    <div class="row ">

                        <div class="col-md-6 ">
                            <img src="img/login.jpg" style="height: 350px; width: 600px;" alt="img"
                                 class="img-fluid ">
                        </div>

                        <!-- Login Form -->
                        <div class="col-md-6 col-lg-6 ">
                            <%@include file="components/message.jsp" %>

                            <div class="col-md-12 text-center ">
                                <h2 style="color: #116466; font-weight: bold">Login</h2>
                            </div>
                            <form action="LoginServlet" method="post">
                                <div class="row">
                                    <div class="col-md-12 ">

                                        <!-- Email Address -->
                                        <div class="form-group input-group my-4">
                                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white  border-md border-right-0">
                                <i class="fa fa-envelope" style="color: #116466;"></i>
                            </span>
                                            </div>
                                            <input id="email" type="email" name="user_email" placeholder="Email Address"
                                                   class="form-control bg-white border-left-0 border-md" required>
                                        </div>

                                        <!-- Password -->
                                        <div class="form-group input-group my-4">
                                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white  border-md border-right-0">
                                <i class="fa fa-lock" style="color: #116466;"></i>
                            </span>
                                            </div>
                                            <input id="password" type="password" name="user_password" placeholder="Password"
                                                   class="form-control bg-white border-left-0 border-md" required>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-block" style="background: #116466;color: #d1e8e2;">Login</button>
                                        </div>

                                        <!-- New User -->
                                        <div class="text-center">
                                            <p class="my-4 font-weight-bold">New User?
                                                <a href="register.jsp"> Sign Up</a></p>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
