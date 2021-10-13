<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/profile.css" />
        <link rel="stylesheet" type="text/css" href="./asset/css/evo-calendar.css" />
        <link
            rel="stylesheet"
            type="text/css"
            href="./asset/css/evo-calendar.orange-coral.css"
            />
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

            <div class="container-fluid">
                <div class="row">
                    <div class="left col-md-3">
                        <div class="info-card">
                            <div class="circle"></div>
                            <div class="circle"></div>
                            <h3 class="info">Profile Card</h3>
                            <h3 class="school">FPT University</h3>
                            <img src="${avatar}" class="avatar" />
                        <div class="show-card">
                            <div class="edit">
                                <a href="#"><i class="fal fa-edit"></i> Edit</a>
                            </div>
                            <h3 class="phone-number">
                                <c:choose>
                                    <c:when test="${not empty user.phoneNumber}">
                                        ${user.phoneNumber}
                                    </c:when>
                                    <c:otherwise>
                                        phone number
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <h5 class="dob">
                                <span>D.O.B </span>
                                <c:choose>
                                    <c:when test="${not empty user.dayOfBirth}">
                                        <span>${user.dayOfBirth}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>DD/MM/YYYY</span>
                                    </c:otherwise>
                                </c:choose>

                            </h5>
                            <h5 class="fullname">
                                <c:choose>
                                    <c:when test="${not empty user.name}">
                                        ${user.name}
                                    </c:when>
                                    <c:otherwise>
                                        your name
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <h5 class="gender">
                                <c:choose>
                                    <c:when test="${user.gender eq true}">
                                        <i class="fal fa-mars"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fal fa-venus"></i>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                        </div>

                        <form action="UpdateController" method="POST">
                            <div class="save">
                                <i class="fal fa-save"></i>
                                <input type="submit" value="Save" />
                            </div>
                            <h3 class="phone-number">
                                <input 
                                    type="tel" 
                                    name="txtPhoneNumber" 
                                    placeholder="Your Phone Number" 
                                    value="${user.phoneNumber}"
                                    />
                            </h3>
                            <h5 class="dob">
                                <span>D.O.B </span>
                                <span
                                    ><input
                                        type="date"
                                        name="txtDate"
                                        placeholder="Your Day Of Birth" 
                                        value="${user.dayOfBirth}"
                                        required/>
                                </span>
                            </h5>
                            <h5 class="fullname">
                                <input
                                    type="text"
                                    name="txtUsername"
                                    placeholder="Your Full Name"
                                    value="${user.name}"
                                    required
                                    />
                            </h5>
                            <h5 class="gender">
                                <label class="female">
                                    <input type="radio" name="gender" value="0" />
                                    <i class="fal fa-venus"></i>
                                </label>
                                <label class="male">
                                    <input type="radio" name="gender" value="1" checked />
                                    <i class="fal fa-mars"></i>
                                </label>
                            </h5>
                        </form>

                    </div>
                    <div class="nav">
                        <a class="nav-link schedular active" href="#">view schedule</a>
                        <a class="nav-link followed" href="#">view followed events</a>
                        <a class="nav-link registered" href="#">view registered events</a>
                    </div>
                </div>

                <div class="right col-md-9">
                    <div id="calendar"></div>


                    <!--followed event -->
                    <div id="event-followed">
                        <div class="content">
                            <div class="header">
                                <img src="./asset/img/trungthu.png" />
                                <div>
                                    <p><a href="#">Club Name </a><i class="fas fa-caret-right"></i> <a href="#">Event Name</a></p>
                                    <span>Sep 30 2021 - 14:00</span>
                                </div>
                            </div>
                            <p class="text">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, temporibus? Quibusdam quo labore nam quidem illo exercitationem rerum, facere ut laudantium molestiae dignissimos modi neque inventore tenetur eius quisquam expedita!
                            </p>
                            <div class="event-img row">
                                <img src="./asset/img/event.png" class="col-md-4"/>
                                <img src="./asset/img/event.png" class="col-md-4"/>
                                <img src="./asset/img/event.png" class="col-md-4"/>
                            </div>


                    <div id="event-followed">
                        <c:choose>
                            <c:when test="${empty eventFollowedList}">
                                <h3> You did not follow any event!!!</h3>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="event" items="${eventFollowedList}">
                                    <div class="content">
                                        <div class="header">
                                            <img src="./asset/img/trungthu.png" />
                                            <div>
                                                <p ><a href="ViewClubDetail?clubID=${event.clubID}">
                                                        <c:forEach var="club" items="${club}">
                                                            <c:if test="${event.clubID eq club.clubID}">
                                                                ${club.clubName}
                                                            </c:if>
                                                        </c:forEach></a>
                                                    <i class="fas fa-caret-right"></i> <a href="ViewEventController?eventID=${event.eventID}">${event.eventName}/a></p>
                                                <span>${event.startDate}</span>
                                            </div>
                                        </div>
                                        <p class="text">
                                            ${event.content}
                                        </p>
                                        <div class="event-img row">
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                        </div>
                                        <div class="text-bottom">
                                            <div class="total-follow">
                                                <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" />
                                                <span>100</span> <%-- tym --%>
                                            </div>
                                            <div class="slot">
                                                <c:set  var="registerNum" value="${0}"/>
                                                <c:forEach var="register" items="${registerNumList_follow}">
                                                    <c:if test="${register.eventID  eq event.eventID}">
                                                        <c:set var="registerNum" value="${register.registerNum}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <p>Available slots: <span>${registerNum}/${event.slot}</span></p> 
                                            </div>
                                        </div>
                                        <div class="footer"></div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>            
                    </div>

                    <!-- end of followed event -->

                    <!-- registered event -->

                    <div id="event-registered">
                        <c:choose>
                            <c:when test="${empty eventRegisterList}">
                                <h3> you don't have any event registration!!!</h3>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="event" items="${eventRegisterList}">
                                    <div class="content">
                                        <div class="header">
                                            <img src="./asset/img/trungthu.png" />
                                            <div>
                                                <p ><a href="ViewClubDetail?clubID=${event.clubID}">
                                                        <c:forEach var="club" items="${club}">
                                                            <c:if test="${event.clubID eq club.clubID}">
                                                                ${club.clubName}
                                                            </c:if>
                                                        </c:forEach></a>
                                                    <i class="fas fa-caret-right"></i> <a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a></p>
                                                <span>${event.startDate}</span>
                                            </div>
                                        </div>
                                        <p class="text">
                                            ${event.content}
                                        </p>
                                        <div class="event-img row">
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                            <img src="./asset/img/event.png" class="col-md-4"/>
                                        </div>
                                        <div class="text-bottom">
                                            <div class="total-follow">
                                                <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" />
                                                <span>100</span> <%-- tym --%>
                                            </div>
                                            <div class="slot">
                                                <c:set  var="registerNum" value="${0}"/>
                                                <c:forEach var="register" items="${registerNumList_register}">
                                                    <c:if test="${register.eventID  eq event.eventID}">
                                                        <c:set var="registerNum" value="${register.registerNum}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <p>Available slots: <span>${registerNum}/${event.slot}</span></p> 
                                            </div>
                                        </div>
                                        <div class="footer"></div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>          
                    </div>
                    <!--end of registered event -->
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="./asset/js/evo-calendar.js"></script>
        <script src="./asset/js/main.js"></script>

        <script>
            var form = document.querySelector("form");
            var showCard = document.querySelector(".show-card");
            var edit = document.querySelector(".edit");
            var save = document.querySelector('.save input[type="submit"]');
            var calendar = document.querySelector('#calendar');
            var eventFollowed = document.querySelector('#event-followed');
            var eventRegistered = document.querySelector('#event-registered');

            eventRegistered.style.display = 'none';
            eventFollowed.style.display = 'none';
            document.querySelectorAll(".nav a").forEach((item) => {
                item.addEventListener("click", (event) => {
                    document.querySelector(".nav a.active").classList.remove("active");
                    item.classList.add("active");
                    if (document.querySelector(".nav a.schedular").classList.contains("active")) {
                        calendar.style.display = "block";
                        eventFollowed.style.display = "none";
                        eventRegistered.style.display = "none";
                    } else if (document.querySelector(".nav a.followed").classList.contains("active")) {
                        calendar.style.display = "none";
                        eventFollowed.style.display = "block";
                        eventRegistered.style.display = "none";
                    } else if (document.querySelector(".nav a.registered").classList.contains("active")) {
                        calendar.style.display = "none";
                        eventFollowed.style.display = "none";
                        eventRegistered.style.display = "block";
                    }
                });
            });

            edit.addEventListener("click", function () {
                form.style.display = "block";
                showCard.style.display = "none";
                console.log(active.value);
            });
            save.addEventListener("click", function () {
                form.style.display = "none";
                showCard.style.display = "block";
            });

            $(document).ready(function () {
            $("#calendar").evoCalendar(
            {
            theme: "Orange Coral",
                    calendarEvents: [
                    {
                    id: "bHay68s", // Event's ID (required)
                            name: "New Year", // Event name (required)
                            date: "September/9/2021", // Event date (required)
                            type: "holiday", // Event type (required)
                            everyYear: true, // Same event every year (optional)

                        },
            <c:forEach var="event" items="${eventRegisterList}">
                        {
                            id: "${event.eventID}",
                            name: "${event.eventName}",
                            badge: "Taking place", // Event badge (optional)
                            date: ["${event.startDate}", "${event.endDate}"], // Date range
                            description: "You register this event!!", // Event description (optional)
                            type: "event",
                            color: "#63d867", // Event custom color (optional)
                        },
            </c:forEach>

                    ],
            }
            );
            }
            );
        </script>
    </body>
</html>
