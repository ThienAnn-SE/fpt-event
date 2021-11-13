<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core"
                  prefix="c"%>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home page</title>
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
            <div class="banner-area" style="background-image: url('./asset/img/banner.jpg')">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="counting-wrapper">
                                <div class="banner-title">
                                    <span>next event</span>
                                    <h1>upcoming latest event</h1>
                                </div>
                                <div class="counting-text">
                                    <div class="countdown">
                                        <div class="count-time" id="hour">00</div>
                                        <div class="count-time" class="dot">:</div>
                                        <div class="count-time" id="minute">00</div>
                                        <div class="count-time" class="dot">:</div>
                                        <div class="count-time" id="second">00</div>
                                    </div>
                                </div>
                            <c:forEach begin="0" end="0" var="event" items="${eventList}">
                                <a href="RegisterEventController?eventID=${event.eventID}" class="btn">
                                    <span class="btn-text">book ticket</span>
                                    <span class="btn-border"></span>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="banner-event">
                                <div class="event-outer">
                                    <div class="event-item">
                                        <div class="upcoming-event-wrapper">
                                            <c:set var="startDate" value="${event.startDate}"/>
                                            <div class="upcoming-event-img">
                                                <a href="ViewEventController?eventID=${event.eventID}}">
                                                    <img src="${event.imageURL}" />
                                                </a>
                                                <div class="price"><span>${event.ticketFee} VND</span></div>
                                            </div>
                                            <div class="upcoming-event-text">
                                                <h3><a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a></h3>
                                                <div class="event-meta">
                                                    <span>
                                                        <i class="far fa-calendar-alt"></i> 
                                                        ${event.startDate} - ${event.endDate}
                                                    </span>
                                                    <span>
                                                        <c:forEach var="category" items="${categoryList}">
                                                            <c:if test="${event.categoryID eq category.categoryID}">
                                                                ${category.categoryName}
                                                            </c:if>
                                                        </c:forEach>                                                      
                                                    </span>
                                                    <span> 
                                                        <i class="fal fa-comments"></i> 
                                                        <c:set var="num" value="0"/>
                                                        <c:forEach var="comment" items="${commentNum}">
                                                            <c:if test="${comment.eventID eq event.eventID}">
                                                                <c:set var="num" value="${comment.commentNum}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        ${num} Comments
                                                    </span>
                                                    <c:forEach var="register" items="${registerNumList}">
                                                        <c:if test="${event.eventID eq register.eventID}">
                                                            <c:set var="registerNum" value="${register.registerNum}"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <span><i class="far fa-users"></i> ${registerNum}/${event.slot}</span>
                                                </div>
                                                <a href="ViewEventController?eventID=${event.eventID}" class="btn">
                                                    <span class="btn-text">view details</span>
                                                    <span class="btn-border"></span>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="relate-event-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="upcoming-event-title text-center">
                            <span></span>
                            <h1>upcoming events</h1>
                            <p>We arrange many other events for enjoy</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach begin="1" end="3" var="event" items="${eventList}">
                        <div class="col-lg-4">
                            <div class="upcoming-event-wrapper">
                                <div class="upcoming-event-img">
                                    <a href="ViewEventController?eventID=${event.eventID}">
                                        <img src="${event.imageURL}" />
                                    </a>
                                    <div class="price"><span>${event.ticketFee} VND</span></div>
                                </div>
                                <div class="upcoming-event-text">
                                    <h3><a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a></h3>
                                    <div class="event-meta">
                                        <span>
                                            <i class="far fa-calendar-alt"></i> 
                                            ${event.startDate} - ${event.endDate}
                                        </span>
                                        <span>
                                            <c:forEach var="category" items="${categoryList}">
                                                <c:if test="${event.categoryID eq category.categoryID}">
                                                    ${category.categoryName}
                                                </c:if>
                                            </c:forEach>    
                                        </span>
                                        <span> <i class="fal fa-comments"></i> 0 Comments</span>
                                        <c:forEach var="register" items="${registerNumList}">
                                            <c:if test="${event.eventID eq register.eventID}">
                                                <c:set var="registerNum" value="${register.registerNum}"/>
                                            </c:if>
                                        </c:forEach>
                                        <span><i class="far fa-users"></i> ${registerNum}/${event.slot}</span>
                                    </div>
                                    <a href="RegisterEventController?eventID=${event.eventID}" class="btn">
                                        <span class="btn-text">book ticket</span>
                                        <span class="btn-border"></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
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
