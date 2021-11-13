<%-- 
    Document   : review
    Created on : Oct 2, 2021, 4:00:46 AM
    Author     : thien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
            integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
            crossorigin="anonymous"
            />
    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>

            <section class="checkout-area"> 
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="checkout-info">
                                <h3>Information Details</h3>
                                <div class="checkout-info-text">
                                    <strong><span>Name:</span></strong>
                                    <span>${user.name}</span>
                            </div>
                            <div class="checkout-info-text">
                                <strong><span>Email:</span></strong>
                                <span>${user.email}</span>
                            </div>
                            <div class="checkout-info-text">
                                <strong><span>Gender:</span></strong>
                                <c:if test="${user.gender}">
                                    <span>Male</span>
                                </c:if>
                                <c:if test="${not user.gender}">
                                    <span>Female</span>
                                </c:if>
                            </div>
                            <div class="checkout-info-text">
                                <strong><span>Date of birth:</span></strong>
                                <span>${user.dayOfBirth}</span>
                            </div>
                            <div class="checkout-info-text">
                                <strong><span>Phone:</span></strong>
                                <span>${user.phoneNumber}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="order">
                            <h3>Your Order</h3>
                            <div class="order-content">
                                <table>
                                    <thead>
                                        <tr>
                                            <th class="order-name">Event</th>
                                            <th class="order-price">Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="order-item">
                                            <td class="order-name">
                                                [${event.eventName}]-ticket
                                                <strong>x 1</strong>
                                            </td>
                                            <td class="order-price">
                                                <span>
                                                    <c:if test="${event.ticketFee eq 0}">
                                                        Free
                                                    </c:if>
                                                    <c:if test="${event.ticketFee gt 0}">
                                                        ${event.ticketFee} VND
                                                    </c:if>
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>Total</th>
                                            <td>
                                                <strong>
                                                    <span>
                                                        <c:if test="${event.ticketFee eq 0}">
                                                            Free
                                                        </c:if>
                                                        <c:if test="${event.ticketFee gt 0}">
                                                            ${event.ticketFee} VND
                                                        </c:if>
                                                    </span>
                                                </strong>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <form action="RegisterEventController" name="payment" method="POST">
                                    <div class="payment">
                                        <div class="payment-method">
                                            <c:if test="${event.ticketFee eq 0}">
                                                <p>Confirm your registration</p>
                                            </c:if>
                                            <c:if test="${event.ticketFee ne 0}">
                                                <p>There are some payment methods available for you.</p>
                                                <input type="radio" id="cash" class="radio-input" name="payment" value="cash" checked/>
                                                <label for="cash" class="radio-label"></label>
                                                <span class="radio-name">Cash</span>
                                                <input type="radio" id="paypal" class="radio-input" name="payment" value="paypal"/>
                                                <label for="paypal" class="radio-label"></label>
                                                <span class="radio-name">Paypal</span>
                                            </c:if>
                                        </div>
                                        <p class="payment-submit">
                                            <input type="hidden" name="eventID" value="${event.eventID}"/>
                                            <input type="submit" class="btn" value="Register">
                                        </p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>