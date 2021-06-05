<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>Registration Page</title>
    <%@include file="components/common_css_js.jsp" %>
    <%--    <style>--%>
    <%--        body{--%>
    <%--            background: white !important;--%>
    <%--        }--%>
    <%--    </style>--%>
</head>
<body>
<div class="container text-center mt-3">
    <!-- Navbar Brand -->
    <a href="index.jsp" class="navbar-brand">
        <img src="img/myLogo.png" class="image-fluid" alt="logo" width="180">
    </a>
</div>
<%--    </nav>--%>
<div class="container">
    <div class="row py-3 align-items-center">

        <div class="col-md-6 pr-lg-5 mb-5 mb-md-0 my-4">
            <img src="img/register1.jpeg" style="height: 370px; width: 600px;" alt="img"
                 class="img-fluid mb-3 d-none d-md-block">
        </div>

        <!-- Registeration Form -->
        <div class="col-md-6 col-lg-6 ">
            <%@include file="components/message.jsp" %>
            <div class="col-md-12 text-center ">
                <h2 style="color: #116466; font-weight: bold">Create an Account</h2>
            </div>
            <form action="SendEmailServlet" method="post">
                <div class="row">
                    <div class="col-md-12 ">
                        <!-- Name -->
                        <div class="input-group form-group my-4">
                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-user" style="color: #116466;"></i>
                            </span>
                            </div>
                            <input id="name" type="text" name="user_name" placeholder="Enter Name"
                                   class="form-control bg-white border-left-0 border-md" required>
                        </div>

                        <!-- Email Address -->
                        <div class="form-group input-group my-4">
                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-envelope" style="color: #116466;"></i>
                            </span>
                            </div>
                            <input id="email" type="email" name="user_email" placeholder="Enter Email Address"
                                   class="form-control bg-white border-left-0 border-md" required>
                        </div>

                        <!-- Phone Number -->
                        <div class="form-group input-group my-4">
                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-phone-square" style="color: #116466;"></i>
                            </span>
                            </div>
                            <input id="phone" type="tel" name="user_phone" placeholder="Enter Phone Number"
                                   class="form-control bg-white border-md border-left-0 pl-3" required>
                        </div>

                        <!-- Password -->
                        <div class="form-group input-group my-4">
                            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-lock" style="color: #116466;"></i>
                            </span>
                            </div>
                            <input id="password" type="password" name="user_password" placeholder="Set Password"
                                   class="form-control bg-white border-left-0 border-md" required>
                        </div>

                        <!-- Submit Button -->
                        <div class="form-group">
                            <button type="submit" class="btn btn-block" style="background: #116466;color: #d1e8e2;">Continue
                            </button>
                        </div>

                        <!-- Already Registered -->
                        <div class="text-center">
                            <p class="mt-2 font-weight-bold">Already have an account?
                                <a href="login.jsp"> Login here!</a></p>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
