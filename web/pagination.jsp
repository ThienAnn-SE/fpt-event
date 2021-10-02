<%-- 
    Document   : pagination.jsp
    Created on : Oct 3, 2021, 12:58:10 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <table border="1">
            <tr>
                <th>No.</th>
                <th>ID</th>
                <th>Name</th>
            </tr>
            <c:forEach varStatus="counter" items="${requestScope.listEvent}" var="event">
                <tr>
                    <td>${counter.count}</td>
                    <td>${event.eventID}</td>
                    <td>${event.eventName}</td>
                </tr>
            </c:forEach>
        </table>

        <c:set scope="request" var="pre" value="${(index-1 <= 1) ? 1 : (index-1)}"/>
        <a class="page-link" href="ViewEventController?i=${pre}">Previous</a>...
        
        <c:forEach begin="1" end="${endPage}" var="i">
            <a class="page-link" href="ViewEventController?i=${i}">${i}</a>
        </c:forEach>...
        
        <c:set scope="request" var="next" value="${(index+1 >= endPage) ? endPage : (index+1)}"/>
        <a class="page-link" href="ViewEventController?i=${next}">Next</a>
    </body>
</html>
