<%-- 
    Document   : index
    Created on : Sep 14, 2021, 12:47:42 PM
    Author     : thien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String id = request.getAttribute("id").toString();
            String email = request.getAttribute("email").toString();
            out.print("Id: " + id);
            out.print("<br/>Email: " + email);
        %>
    </body>
</html>
