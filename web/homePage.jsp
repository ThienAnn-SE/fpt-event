<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home page</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/homePage.css" />
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
        <div class="banner">
            <img src="./asset/img/event.jpg" />
            <div class="content">
                <c:forEach begin="0" end="0" var="event" items="${eventList}">
                    <c:set var="startDate" value="${event.startDate}"/>
                    <h1>${event.eventName}</h1>
                    <p>Begin date: ${event.startDate}</p>
                    <a href="ViewEventController?eventID=${event.eventID}"><button>Read More</button></a>
                </c:forEach>
            </div>
            <div class="countdown">
                <h2 id="hour">00</h2>
                <h2 class="dot">:</h2>
                <h2 id="minute">00</h2>
                <h2 class="dot">:</h2>
                <h2 id="second">00</h2>
            </div>
        </div>

        <div class="container">
            <div class="title">
                <i class="far fa-calendar-star"></i>
                <h2>events are upcoming</h2>
            </div>
            <div class="row"> 
                <c:forEach var="event" begin="1" items="${eventList}">
                    <div class="event col-md-4">
                        <div class="event-img">
                            <img src="./asset/img/trungthu.png" />
                        </div>
                        <div class="event-content">
                            <h2 class="event-name">
                                <i class="fal fa-heart"></i><a href="RegisterEventController?eventID=${event.eventID}">${event.eventName}</a>
                            </h2>
                            <ul class="event-detail">
                                <li class="create-date">
                                    <i class="fal fa-clock"></i> ${event.createDate}
                                </li>
                                <li class="slot">
                                    <i class="far fa-user-alt"></i> 50/${event.slot} Slots
                                </li>
                                <li class="event-category">
                                    <i class="fal fa-folder"></i>
                                    <c:choose>
                                        <c:when test="${event.catetoryID eq 10}">
                                            <a href="SearchEventController?btAction=catetory&catetoryID=10">Seminar</a>
                                        </c:when>
                                        <c:when test="${event.catetoryID eq 15}">
                                            <a href="SearchEventController?btAction=catetory&catetoryID=15">Entertainment</a>
                                        </c:when>
                                        <c:when test="${event.catetoryID eq 20}">
                                            <a href="SearchEventController?btAction=catetory&catetoryID=20">Learning</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="SearchEventController">Uncategorized</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="event-comment">
                                    <i class="fal fa-comments"></i> 0 Comments
                                </li>
                            </ul>
                            <p>
                                ${event.content}
                            </p>
                            <a href="RegisterEventController?eventID=${event.eventID}">
                                <button><i class="fas fa-ticket-alt"></i> Register</button>
                            </a>
                            <a class="read-more" href="ViewEventController?eventID=${event.eventID}"
                               >continue reading <i class="fal fa-chevron-right"></i
                                ></a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="read-more">
                <a href="SearchEventController">Continue to reading ... </a>
            </div>
        </div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>

            <script src="./asset/js/main.js"></script>

        <script>
            var countDate = new Date("${startDate}").getTime();
            function countDown() {
                var now = new Date().getTime();
                var distance = countDate - now;
                var day = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hour = Math.floor(
                        (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
                        );
                var minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var second = Math.floor((distance % (1000 * 60)) / 1000);

                    if (day > 0) {
                        hour = day * 24 + hour;
                    }
                    document.getElementById("hour").innerHTML =
                            hour < 10 ? "0" + hour : hour;
                    document.getElementById("minute").innerHTML =
                            minute < 10 ? "0" + minute : minute;
                    document.getElementById("second").innerHTML =
                            second < 10 ? "0" + second : second;
                }
                setInterval(function () {
                    countDown();
                }, 1000);
        </script>
    </body>
</html>
