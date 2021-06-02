
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Page</title>
    <%@include file="components/common_css_js.jsp" %>
    <style>
        .card{
            background: #CFD8DC;
        }
    </style>

</head>
<body>
    <%@include file="components/navbar.jsp"%>
    <div class="container">
        <div class="row mt-3">
            <div class="col-md-6 offset-md-3">
                <div class="card mt-3">
                    <div class="card-header bg-dark text-white text-center">
                        <h3>Login Here</h3>
                    </div>
                    <div class="card-body">
                        <%@include file="components/message.jsp"%>
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input name="user_email" type="email" class="form-control" id="email" aria-describedby="emailHelp" required>
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input name="user_password" type="password" class="form-control" id="password" required>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary  mx-3">Submit</button>
                                <button type="reset" class="btn btn-primary  ">Reset</button>
                                <p class="mt-2">New user? <a href="register.jsp">Register here!</a></p>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
