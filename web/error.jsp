<%-- 
    Document   : error
    Created on : Sep 21, 2021, 2:21:14 PM
    Author     : thien
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <p>${requestScope.error}</p>
        <p>${requestScope.errorMessage}</p>
    </body>
</html>
