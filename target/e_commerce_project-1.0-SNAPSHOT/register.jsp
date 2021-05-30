
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Page</title>
    <%@include file="components/common_css_js.jsp" %>
    <style>
        .card{
            background: #CFD8DC;
        }
    </style>
</head>
<body>
    <%@include file="components/navbar.jsp"%>
    <div class="container-fluid">
        <div class="row mt-3">
            <div class="col-md-4 offset-md-4">
                <%@include file="components/message.jsp"%>
                <div class="card">
                    <div class="card-header bg-dark text-white text-center">
                        <h3>Sign Up here!!</h3>
                    </div>
                    <div class="card-body ">
                        <form action="RegisterServlet" method="post">
                            <div class="form-group">
                                <label for="name">User Name</label>
                                <input name="user_name" type="text" class="form-control" id="name"
                                       placeholder="Enter here" aria-describedby="emailHelp">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input name="user_email" type="email" class="form-control" id="email"
                                       placeholder="Enter here" aria-describedby="emailHelp">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input name="user_password" type="password" class="form-control" id="password"
                                       placeholder="Enter here" aria-describedby="emailHelp">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input name="user_phone" type="number" class="form-control" id="phone"
                                       placeholder="Enter here" aria-describedby="emailHelp">
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <textarea name="user_address" id="address" style ="height: 130px" class="form-control" placeholder="Enter here"></textarea>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary mx-3">Register</button>
                                <button type="reset" class="btn btn-primary">Reset</button>
                                <p class="mt-2">Already have an account?<br>
                                    <a href="login.jsp"> Login here!</a> </p>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
