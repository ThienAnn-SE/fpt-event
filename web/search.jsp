<%-- 
    Document   : pagination.jsp
    Created on : Oct 3, 2021, 12:58:10 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/event.css" />
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
            <div class="main">
                <div class="side-bar">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <div class="title">
                                <i class="fad fa-list"></i>
                                category
                                <i class="far fa-chevron-down"></i>
                            </div>
                            <ul class="sub-menu">
                                <li><a href="SearchEventController?btAction=catetory&catetoryID=10">Seminar</a></li>
                                <li><a href="SearchEventController?btAction=catetory&catetoryID=15">Entertainment Event</a></li>
                                <li><a href="SearchEventController?btAction=catetory&catetoryID=20">Learning Event</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <div class="title">
                                <i class="fal fa-money-bill-wave"></i>
                                search by price
                            </div>
                            <div class="price">
                                <form action="#">
                                    <div class="value">
                                        <span id="range1">0</span>
                                        <span>-</span>
                                        <span id="range2">500000</span>
                                    </div>
                                    <div class="range">
                                        <div class="slider"></div>
                                        <input
                                            type="range"
                                            min="0"
                                            max="500000"
                                            step="1000"
                                            value="0"
                                            id="slider1"
                                            />
                                        <input
                                            type="range"
                                            min="0"
                                            max="500000"
                                            step="1000"
                                            value="500000"
                                            id="slider2"
                                            />
                                    </div>

                                    <div class="min">
                                        <span class="prev"></span>
                                        <input type="number" value="0" />
                                        <span class="next"></span>
                                    </div>

                                    <div class="max">
                                        <span class="prev"></span>
                                        <input type="number" value="500000" />
                                        <span class="next"></span>
                                    </div>
                                </form>
                            </div>
                        </li>
                        <li class="nav-item">
                            <div class="title">
                                <i class="fal fa-calendar-week"></i>
                                search by date
                            </div>
                            <div class="date">
                                <input type="date" id="start-date" />
                                <input type="date" id="end-date" />
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="container">
                    <div class="title">
                        <i class="far fa-calendar-star"></i>
                        <h2>events</h2>
                    </div>
                    <div class="row">
                    <c:forEach items="${requestScope.eventList}" var="event">
                        <div class="event col-md-4">
                            <div class="event-img">
                                <img src="./asset/img/trungthu.png" />
                            </div>
                            <div class="event-content">
                                <h2 class="event-name">
                                    <i class="fal fa-heart"></i> <a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a>
                                </h2>
                                <ul class="event-detail">
                                    <li class="create-date">
                                        <i class="fal fa-clock"></i> ${event.createDate}
                                    </li>
                                    <li class="slot">
                                        <c:set  var="registerNum" value="${0}"/>
                                        <c:forEach var="register" items="${registerNumList}">
                                            <c:if test="${register.eventID  eq event.eventID}">
                                                <c:set var="registerNum" value="${register.registerNum}"/>
                                            </c:if>
                                        </c:forEach>
                                        <i class="far fa-user-alt"></i> ${registerNum}/${event.slot}Slots
                                    </li>
                                    <li class="event-category">
                                        <i class="fal fa-folder"></i> <a href="SearchEventController?btAction=catetory&catetoryID=${event.catetoryID}">
                                            <c:forEach var="catetory" items="${catetoryList}">
                                                <c:if test="${event.catetoryID eq catetory.catetoryID}">
                                                    ${catetory.catetoryName}
                                                </c:if>
                                            </c:forEach>
                                        </a>
                                    </li>
                                    <li class="event-comment">
                                        <i class="fal fa-comments"></i> 0 Comments
                                    </li>
                                </ul>
                                <p>
                                    ${e.content}
                                </p>
                                <a href="#"><button><i class="fas fa-ticket-alt"></i> Register</button></a>
                                <a class="read-more" href="ViewEventController?eventID=${event.eventID}"
                                   >continue reading <i class="fal fa-chevron-right"></i
                                    ></a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="pagination">
                    <c:set scope="request" var="pre" value="${(index-1 <= 1) ? 1 : (index-1)}"/>
                    <a class="page-link btn-prev" href="SearchEventController?page=${pre}">
                        <span><i class="fas fa-chevron-left"></i> Previous</span>
                    </a>

                    <c:forEach begin="1" end="${endPage}" var="i">
                        <a class="page-link num" href="SearchEventController?page=${i}">${i}</a>
                    </c:forEach>

                    <c:set scope="request" var="next" value="${(index+1 >= endPage) ? endPage : (index+1)}"/>
                    <a class="page-link btn-next" href="SearchEventController?page=${next}${lastSearch}">
                        <span>Next <i class="fas fa-chevron-right"></i></span>
                    </a>
                </div>
            </div>
        </div>

        <script src="./asset/js/main.js"></script>

        <script>
            var prevs = document.querySelectorAll(".prev");
            var nexts = document.querySelectorAll(".next");
            var numbers = document.querySelectorAll('input[type="number"]');
            var range1 = document.getElementById("range1");
            var range2 = document.getElementById("range2");
            var slider1 = document.getElementById("slider1");
            var slider2 = document.getElementById("slider2");
            for (pre of prevs) {
                pre.addEventListener("click", function () {
                    var price = this.parentElement.classList;
                    if (price.value == "min") {
                        if (numbers[0].value > 0) {
                            numbers[0].value = parseInt(numbers[0].value) - 1000;
                            slider1.value = numbers[0].value;
                            range1.innerHTML = slider1.value;
                        }
                    } else if (price.value == "max") {
                        if (numbers[1].value > 0) {
                            numbers[1].value = parseInt(numbers[1].value) - 1000;
                            slider2.value = numbers[1].value;
                            range2.innerHTML = slider2.value;
                        }
                    }
                });
            }
            for (next of nexts) {
                next.addEventListener("click", function () {
                    var price = this.parentElement.classList;
                    if (price.value == "min") {
                        if (numbers[0].value < 500000) {
                            numbers[0].value = parseInt(numbers[0].value) + 1000;
                            slider1.value = numbers[0].value;
                            range1.innerHTML = slider1.value;
                        }
                    } else if (price.value == "max") {
                        if (numbers[1].value < 500000) {
                            numbers[1].value = parseInt(numbers[1].value) + 1000;
                            slider2.value = numbers[1].value;
                            range2.innerHTML = slider2.value;
                        }
                    }
                });
            }
            numbers[0].addEventListener("input", function () {
                slider1.value = numbers[0].value;
                range1.innerHTML = slider1.value;
            });
            numbers[1].addEventListener("input", function () {
                slider2.value = numbers[1].value;
                range2.innerHTML = slider2.value;
            });
            slider1.addEventListener("input", function () {
                numbers[0].value = slider1.value;
                range1.innerHTML = slider1.value;
            });
            slider2.addEventListener("input", function () {
                numbers[1].value = slider2.value;
                range2.innerHTML = slider2.value;
            });

            document.querySelectorAll('.event-name i').forEach((item) => {
                item.addEventListener("click", () => {
                    item.classList.toggle('followed');
                    if (item.classList.contains('followed')) {
                        item.className = 'fas fa-heart followed';
                        item.style.color = 'red';
                    } else {
                        item.className = 'fal fa-heart';
                        item.style.color = 'var(--black)';
                    }
                });
            });
        </script>
    </body>
</html>
