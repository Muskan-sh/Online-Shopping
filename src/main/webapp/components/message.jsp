
<%
    String message = (String) session.getAttribute("message");
    if(message!= null){

//        out.println(message);

%>
<style>
    .custom{
        /*background:#ffe6c1;*/
        background: #fff3e0;
        color: #116466;
    }
</style>
<div class="alert alert-dismissible custom fade show" role="alert">
    <div class="text-center">
    <strong>
        <%
            out.println(message);
        %>
    </strong>
    </div>
    <button type="button" class="close " style="color: #116466;" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        session.removeAttribute("message");
    }
%>