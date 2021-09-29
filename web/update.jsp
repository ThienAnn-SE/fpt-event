<%-- 
    Document   : register
    Created on : Sep 17, 2021, 2:30:17 PM
    Author     : thien
--%>

<%@page import="utils.GetParam"%>
<%@page import="daos.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register page</title>
    </head>
    <body>
        <%
            User user = (User) GetParam.getClientAttribute(request, "user", new User());
        %>
        <c:if test="${not empty requestScope.errorMessage}">
            <p>${requestScope.errorMessage}</p>
        </c:if>
        <form action="UpdateController" method="POST">

            <label for="txtEmail">Email: </label>
            ${email}
            <input type="hidden" value="${email}" name="txtEmail"/>
            <br/>

            <label for="txtUsername">Username: </label> 
            <input type="text" value="<%=user.getName()%>" name="txtUsername"/>
            <c:if test="${not empty requestScope.NameError}">
                <font color="red">
                ${requestScope.NameError}
                </font>
            </c:if>
            <br/>

            <label for="gender">Gender:  </label>
            <select name="gender" >
                <c:choose>
                    <c:when test="<%=user.isGender()%>">
                        <option selected value="1" selected>Male</option>
                        <option value="0">Female</option>
                    </c:when>
                    <c:otherwise>
                        <option value="1">Male</option>
                        <option selected value="0">Female</option>
                    </c:otherwise>
                </c:choose>

            </select>
            <br/>

            <label for="txtDate">Date of birth: </label>
            <input type="date" name="txtDate" value="<%= user.getDayOfBirth()%>" placeholder="YYYY-MM-DD"/>
            <c:if test="${not empty requestScope.txtDateError}">
                <font color="red">
                ${requestScope.txtDateError}
                </font>
            </c:if>
            <br/>

            <label for="txtPhoneNumber">Phone number: </label>
            <input type="tel" name="txtPhoneNumber" value="<%= user.getPhoneNumber()%>"/>
            <c:if test="${not empty requestScope.txtPhoneNumber}">
                <font color="red">
                ${requestScope.txtPhoneNumber}
                </font>
            </c:if>
            <br/>
            <input type="submit">
        </form>
    </body>
</html>
