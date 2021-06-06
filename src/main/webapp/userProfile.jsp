<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Account Setting</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col col-md-10 offset-md-1">
            <h2 class="my-3 text-center" style=" font-weight: bold">Account Settings</h2>
            <div class="card" style="background: #f5f5f5 !important;">
                <div class="row ">
                    <%
                        String[] options = {"Profile", "Addresses", "Orders", "Payments", "Change Password", "Delete Account"};

                        String option = request.getParameter("option");
                        if (option == null) {
                            option = options[0];
                        }

                    %>
                    <!--  Display Options -->
                    <div class="col-md-3 ">

                        <div class="list-group list-group-flush" style="margin-left: 30px;">
                            <%
                                for (String op : options) {
                                    if (option.equals(op)) {

                            %>
                            <a class="list-group-item list-group-item-action"
                               style="font-weight: bold;background: #f5f5f5;"
                               href="userProfile.jsp?option=<%=op%>"><%=op%>
                            </a>
                            <%
                            } else {
                            %>
                            <a class="list-group-item list-group-item-action" style="background: #f5f5f5;"
                               href="userProfile.jsp?option=<%=op%>"><%=op%>
                            </a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <!--  Display Settings....  -->
                    <div class="col-md-9">

                        <div class="card " style="background: #fafafa !important;">
                            <div class="card-body">
                                <%@include file="components/message.jsp"%>
                                <!--  ------------------Profile---------------------------------------------------------------  -->
                                <%
                                    if (option.equals(options[0])) {
                                %>

                                <form class="mx-4" action="UpdateUserProfileServlet" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="option" value="<%=option%>" />
                                    <div class="form-group">

                                        <img src="user_profile_images/<%=user1.getUserPic()%>" alt="User image" class="mx-2 my-2 ml-2"
                                             style="max-width: 120px;max-height: 120px;width: auto;">
                                        <label class="btn btn-outline-primary ml-2" for="photo">Upload new photo</label>&nbsp;
<%--                                        <input type="file" id="photo" name="photo" >--%>
                                        <input type="file" id="photo" name="photo" style="position: absolute;visibility: hidden;opacity: 0;">

                                        <label class="btn btn-outline-danger" for="remove">Remove Photo</label>
<%--                                        <input type="checkbox"--%>
                                        <input type="checkbox" style="position: absolute;visibility: hidden;opacity: 0;"
                                               name="remove" id="remove" value="remove">
                                        <br><small>Changes will be shown after they are saved.</small>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="name">Name</label>
                                        <input type="text" class="form-control" id="name" name="name"
                                               value="<%= user1.getUserName()%>" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="text" class="form-control " value="<%= user1.getUserEmail()%>"
                                               disabled>

                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" value="<%= user1.getUserPhone()%>"
                                               disabled>
                                    </div>
                                    <%
                                        if (user1.getGender() == null) {
                                    %>
                                    <div class="form-group">
                                        Set Gender:
                                        <input type="radio" class=" ml-3" id="male" name="gender" value="male">
                                        <label for="male" class="mr-3">Male</label>
                                        <input type="radio" class=" ml-3" id="female" name="gender" value="female">
                                        <label for="female" class="mr-3">Female</label>
                                        <input type="radio" class=" ml-3" id="other" name="gender" value="other">
                                        <label for="other" class="mr-3">Other</label>
                                    </div>
                                    <%
                                    } else {
                                        String[] gender = {"male", "female", "other"};
                                    %>
                                    <div class="form-group">
                                        Gender:
                                        <%
                                            for (String gen : gender) {
                                                String genlabel = gen.substring(0, 1).toUpperCase() + gen.substring(1);
                                                if (user1.getGender().equals(gen)) {
                                        %>
                                        <input type="radio" class=" ml-3" id="<%=gen%>" name="gender" value="<%=gen%>"
                                               checked>
                                        <label for="<%=gen%>" class="mr-3"><%=genlabel%>
                                        </label>
                                        <%
                                        } else {

                                        %>
                                        <input type="radio" class=" ml-3" id="<%=gen%>" name="gender" value="<%=gen%>">
                                        <label for="<%=gen%>" class=" mr-3"><%=genlabel%>
                                        </label>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="form-group mt-1 text-center">
                                        <button type="submit" class="btn btn-outline-primary">Save Changes
                                        </button>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <a type="button" role="button" class="btn btn-outline-danger" href="userProfile.jsp?option=<%=option%>">Cancel</a>
                                </div>

                                <%
                                } else if (option.equals(options[1])) {
                                %>
                                <!--  --------------------Addresses------------------------------------------------------------  -->
                                <%
                                } else if (option.equals(options[2])) {
                                %>
                                <!--  --------------------Orders---------------------------------------------------------------  -->
                                <%
                                } else if (option.equals(options[3])) {
                                %>
                                <!--  --------------------Payments-------------------------------------------------------------  -->
                                <%
                                } else if (option.equals(options[4])) {
                                %>
                                <!--  --------------------Change Password------------------------------------------------------  -->
                                <form class="mx-4" action="UpdateUserProfileServlet" method="post">
                                    <input type="hidden" name="option" value="<%=option%>">

<%--                                    <div class="form-group">--%>
<%--                                        <label class="form-label">Current Password</label>--%>
<%--                                        <input type="password" class="form-control" name="pwd" required>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-group">--%>
<%--                                        <label class="form-label">New Password</label>--%>
<%--                                        <input type="password" class="form-control" name="new_pwd" required>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-group">--%>
<%--                                        <label class="form-label">Repeat New Password</label>--%>
<%--                                        <input type="text" class="form-control" name="new_pwd_2" required>--%>
<%--                                    </div>--%>

                                    <label class="form-label">Current Password</label>
                                    <div class="input-group form-group">
                                        <input type="password" class="form-control" id="pwd" name="pwd" required>
                                        <div class="input-group-append">
                                            <input type="button" onclick="p1()" value="view" >
                                        </div>
                                    </div>
                                    <label class="form-label">New Password</label>
                                    <div class="input-group form-group">
                                        <input type="password" class="form-control" id="new_pwd" name="new_pwd" required>
                                        <div class="input-group-append">
                                            <input type="button" onclick="p2()" value="view" >
                                        </div>
                                    </div>
                                    <label class="form-label">Repeat New Password</label>
                                    <div class="input-group form-group">
                                        <input type="password" class="form-control" id="new_pwd_2" name="new_pwd_2" required>
                                        <div class="input-group-append">
                                            <input type="button" onclick="p3()" value="view" >
                                        </div>
                                    </div>

                                    <div class="form-group mt-1 text-center">
                                        <button type="submit" class="btn btn-outline-primary">Save Changes
                                        </button>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <a type="button" role="button" class="btn btn-outline-danger" href="userProfile.jsp?option=<%=option%>">Cancel</a>
                                </div>

                                <script>
                                    function p1() {
                                        var x = document.getElementById("pwd");
                                        if (x.type === "password") {
                                            x.type = "text";
                                        } else {
                                            x.type = "password";
                                        }
                                    }
                                    function p2() {
                                        var x = document.getElementById("new_pwd");
                                        if (x.type === "password") {
                                            x.type = "text";
                                        } else {
                                            x.type = "password";
                                        }
                                    }
                                    function p3() {
                                        var x = document.getElementById("new_pwd_2");
                                        if (x.type === "password") {
                                            x.type = "text";
                                        } else {
                                            x.type = "password";
                                        }
                                    }

                                </script>

                                <%
                                } else {
                                %>
                                <!--  --------------------Delete Account------------------------------------------------------  -->
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


</body>
</html>
