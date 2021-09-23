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
        <h1>Hello ${sessionScope.USER_DATA.name}</h1>
        <a href="info.jsp">info</a>
    </body>
</html>
