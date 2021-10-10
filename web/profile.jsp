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
        <header>
            <nav class="navbar navbar-expand-lg">
                <div class="navbar-header container-fluid fixed-top">
                    <a class="navbar-brand" href="homePage.html">
                        <img class="nav logo" src="./asset/img/fu.png" />
                    </a>
                    <button class="navbar-toggler">
                        <i id="toggle" class="fas fa-bars"></i>
                    </button>
                    <div class="collapse navbar-collapse">
                        <div class="navbar-nav">
                            <a class="item nav-link active" href="homePage.html">home</a>
                            <a class="item nav-link" href="event.html">event</a>
                            <a class="item nav-link" href="#">club</a>
                            <a
                                class="nav-link"
                                href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force"
                                >
                                <button class="button">
                                    <i class="fab fa-google"></i>
                                    Login
                                </button>
                            </a>
                        </div>
                    </div>
                    <div class="theme-switch">
                        <i class="far fa-moon"></i>
                    </div>
                    <div class="search">
                        <div class="search-icon">
                            <i class="far fa-search"></i>
                        </div>
                        <div class="search-input">
                            <input id="search" type="text" placeholder="Search" />
                        </div>
                        <span class="clear"><i class="fal fa-times"></i></span>
                    </div>
                </div>
            </nav>
        </header>

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
                                    <c:when test="${user.gender}">
                                        <i class="fal fa-mars"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fal fa-venus"></i>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                        </div>

                        <form action="UpdateController">
                            <div class="save">
                                <i class="fal fa-save"></i>
                                <input type="submit" value="Save" />
                            </div>
                            <h3 class="phone-number">
                                <input type="tel" name="txtPhoneNumber" value="012 3456 789" />
                            </h3>
                            <h5 class="dob">
                                <span>D.O.B </span>
                                <span
                                    ><input
                                        type="date"
                                        name="txtDate"
                                        value="2000-09-17" />
                                </span>
                            </h5>
                            <h5 class="fullname">
                                <input
                                    type="text"
                                    value="nguyen thi hoang dung"
                                    name="txtUsername"
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
                        <a class="nav-link schedular active" href="#">view schedular</a>
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

                            <div class="text-bottom">
                                <div class="total-follow">
                                    <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" />
                                    <span>100</span>
                                </div>
                                <div class="slot">
                                    <p>Available slots: <span>50/100</span></p> 
                                </div>
                            </div>
                            <div class="footer"></div>
                        </div>
                    </div>
                    <!-- end of followed event -->

                    <!-- registered event -->
                    <div id="event-registered">
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
                                <img src="./assset/img/event.png" class="col-md-4"/>
                                <img src="./asset/img/event.png" class="col-md-4"/>
                                <img src="./asset/img/event.png" class="col-md-4"/>
                            </div>
                            <div class="text-bottom">
                                <div class="total-follow">
                                    <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" />
                                    <span>100</span>
                                </div>
                                <div class="slot">
                                    <p>Available slots: <span>50/100</span></p> 
                                </div>
                            </div>
                            <div class="footer"></div>
                        </div>
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
            <%-- event register list for calendar --%>
            <c:forEach var="event" items="${eventRegisterList}">
                    {
                    id: "${event.eventID}",
                            name: "${event.eventName}",
                            date: ["${event.startDate}", "${event.endDate}"], // Date range
                            description: "Vacation leave for 3 days.", // Event description (optional)
                            type: "event",
                            color: "#63d867", // Event custom color (optional)
                    },
            </c:forEach>
            <%-- end of list --%>
                    ],
            }
            );
            }
            );
        </script>
    </body>
</html>
