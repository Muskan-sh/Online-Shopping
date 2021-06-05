<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account Setting</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>

<div class="container">
    <h2 class="my-4 text-center" style=" font-weight: bold">Account Settings</h2>
<%--    <div class="card overflow-hidden">--%>
    <div class="card">
<%--        <div class="row no-gutters row-bordered row-border-light">--%>
        <div class="row">
<%--            <div class="col-md-3 pt-0">--%>
            <div class="col-md-3">
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action active" data-toggle="list" href="userProfile.jsp">Profile</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="userProfile.jsp">Addresses</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="userProfile.jsp">Orders</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="userProfile.jsp">Payments</a>
                    <a class="list-group-item list-group-item-action" data-toggle="list" href="userProfile.jsp">Change Password</a>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card-body media align-items-center">
                    <img src="img/user%20(1).png" alt="User image" style="width: 120px;height: 120px;">
                    <div class="media-body ml-4">
                        <label class="btn btn-outline-primary">
                            Upload new photo
                            <input type="file" style="position: absolute;visibility: hidden;width: 1px;height: 1px;opacity: 0;">
                        </label> &nbsp;
                        <button type="button" class="btn btn-default md-btn-flat">Reset</button>
                    </div>
                </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" value="<%= user1.getUserName()%>">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email</label>
                                <input type="text" class="form-control " value="<%= user1.getUserEmail()%>">

                            </div>
                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <input type="text" class="form-control" value="<%= user1.getUserPhone()%>">
                            </div>
                            <div class="form-group">
                                Set Gender:
                                <input type="radio" id="male" name="gender" value="male">
                                <label for="male">Male</label>
                                <input type="radio" id="female" name="gender" value="female">
                                <label for="female">Female</label>
                                <input type="radio" id="other" name="gender" value="other">
                                <label for="other">Other</label>

                            </div>
                        </div>

                </div>
            </div>
        </div>
    <div class="text-center mt-3">
        <button type="button" class="btn btn-primary">Save changes</button>&nbsp;
        <button type="button" class="btn btn-default">Cancel</button>
    </div>
    </div>

</div>


</body>
</html>
