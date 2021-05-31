
<%
    String message = (String) session.getAttribute("message");
    if(message!= null){

//        out.println(message);

%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    <div class="text-center">
    <strong>
        <%
            out.println(message);
        %>
    </strong>
    </div>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        session.removeAttribute("message");
    }
%>