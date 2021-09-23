<%-- 
    Document   : info
    Created on : Sep 22, 2021, 9:33:50 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello: ${sessionScope.USER_DATA.name}</h1>
        <h3>Email: ${sessionScope.USER_DATA.email}</h3>
        <h3>Birth: ${sessionScope.USER_DATA.dayOfBirth}</h3>
        <h3>Gender: ${sessionScope.USER_DATA.gender}</h3>
        <h3>Phone: ${sessionScope.USER_DATA.phoneNumber}</h3>
        <h3>Role: ${sessionScope.USER_DATA.role}</h3>
        <h3>Status ${sessionScope.USER_DATA.status}</h3>
    </body>
</html>
