<%-- 
    Document   : register
    Created on : Sep 17, 2021, 2:30:17 PM
    Author     : thien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register page</title>
    </head>
    <body>
        <c:set var="errors" value="${requestScope.INSERT_ERROR}"/>
        <c:set var="email" value="${requestScope.USER_EMAIL}"/>
        <c:set var="name" value="${requestScope.USER_NAME}"/>
        <form action="UpdateController" method="POST">
            
            <label for="txtEmail">Email: </label>
            ${email}
            <input type="hidden" value="${email}" name="txtEmail"/>
            <br/>
            
            <label for="txtUsername">Username: </label> 
            <input type="text" value="${name}" name="txtUsername"/>
            <c:if test="${not empty requestScope.NameError}">
                <font color="red">
                ${requestScope.NameError}
                </font>
            </c:if>
            <br/>
            
            <label for="gender">Gender:  </label>
            <select name="gender">
                <option value="1">Male</option>
                <option value="0">Female</option>
            </select>
            <br/>
            
            <label for="txtDate">Date of birth: </label>
            <input type="date" name="txtDate" placeholder="MM-DD-YYYY"/>
            <c:if test="${not empty errors.invalidDate}">
                <font color="red">
                ${errors.invalidDate}
                </font>
            </c:if>
            <br/>
            
            <label for="txtPhoneNumber">Phone number: </label>
            <input type="tel" name="txtPhoneNumber"/>
            <c:if test="${not empty errors.invalidPhoneNumber}">
                <font color="red">
                ${errors.invalidPhoneNumber}
                </font>
            </c:if>
            <br/>
            <input type="submit">
        </form>
    </body>
</html>
