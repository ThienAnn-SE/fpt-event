<%-- 
    Document   : review
    Created on : Oct 2, 2021, 4:00:46 AM
    Author     : thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review payment</title>
    </head>
    <body>
        <div align="center">
            <h1>Please Review Before Paying</h1>
            <form action="execute_payment" method="post">
                <table class="table table-borderless">
                    <tr>
                        <td colspan="2"><b>Transaction Details:</b></td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td>You are going to register for the event "${event.eventName}"</td>
                    </tr>
                    <tr>
                        <td>Subtotal:</td>
                        <td>${event.ticketFee}VND</td>
                    </tr>
                    <tr>
                        <td>Total:</td>
                        <td>${event.ticketFee} VND</td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Payer Information:</b></td>
                    </tr>
                    <tr>
                        <td>First Name:</td>
                        <td>${user.name}</td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>${user.email}</td>
                    </tr> 
                    <tr>
                        <td>Phone number:</td>
                        <td>${user.phone}</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" >
                            <button type="submit" class="btn btn-outline-primary" value="Pay Now">
                                Pay Now
                            </button>
                        </td>          
                    </tr>
                </table>
                <c:if test="${event.ticketFee ne 0}">
                    <c:set var="action" value="pay"/>
                </c:if>
                <input name="btAction" type="hidden" value="${action}">
            </form>
    </body>
</html>
