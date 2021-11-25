<!DOCTYPE html>
<html lang="en">
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core"
                  prefix="c"%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" type="text/css" href="./asset/css/evo-calendar.css" />
        <link
            rel="stylesheet"
            type="text/css"
            href="./asset/css/evo-calendar.orange-coral.css"
            />
    </head>
    <body>
        <header class="fixed-top">
            <div class="header-area">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-3 col-6 d-flex align-items-center">
                            <div class="logo">
                                <a href="home">
                                    <img src="./asset/img/FPTU_EVENT.png" />
                                </a>
                            </div>
                        </div>
                        <div class="col-md-9 col-6">
                            <div class="header-right">
                                <div class="header-icon">
                                    <div class="search">
                                        <div class="search-icon">
                                            <i class="far fa-search"></i>
                                        </div>
                                        <div class="pc-search-input">
                                            <form action="SearchEventController">
                                                <input
                                                    class="search-input"
                                                    type="text"
                                                    placeholder="Search"
                                                    name="eventName"
                                                    />
                                            </form>
                                        </div>
                                        <span class="clear"><i class="fal fa-times"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="header-text">
                                <nav class="pc-header">
                                    <ul>
                                        <li class="header-item">
                                            <a href="home"><i class="fa fa-home" aria-hidden="true"></i> home</a>
                                        </li>
                                        <li class="header-item">
                                            <a href="SearchEventController"><i class="fa fa-calendar" aria-hidden="true"></i> event</a>
                                        </li>
                                        <c:if test="${empty sessionScope.email}">
                                            <li class="header-item">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                                                    <i class="fa fa-sign-in" aria-hidden="true"></i>
                                                    login
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.email}">
                                            <li class="header-item">
                                                <a href="logout">
                                                    <i class="fa fa-sign-out" aria-hidden="true"></i>
                                                    logout
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                            <div class="mobile-btn"><i class="fas fa-bars"></i></div>
                            <div class="header-overlay"></div>
                            <nav class="mobile-header">
                                <div class="mobile-header-title">
                                    <div class="logo">
                                        <a href="home">
                                            <img src="./asset/img/FPTU_EVENT.png" />
                                        </a>
                                    </div>
                                    <div class="mobile-header-close">
                                        <i class="fal fa-times"></i>
                                    </div>
                                </div>

                                <ul>
                                    <li class="header-mobile-item">
                                        <a href="home"><i class="fa fa-home" aria-hidden="true"></i> home</a>
                                    </li>
                                    <li class="header-mobile-item">
                                        <a href="SearchEventController"><i class="fa fa-calendar" aria-hidden="true"></i> event</a>
                                    </li>
                                    <c:if test="${empty sessionScope.email}">
                                        <li class="header-item">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                                                <i class="fa fa-sign-in" aria-hidden="true"></i> 
                                                login
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${sessionScope.email}">
                                        <li class="header-item">
                                            <a href="logout">
                                                <i class="fa fa-sign-out" aria-hidden="true"></i>
                                                logout
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                        <div class="col-12">
                            <div class="mobile-search">
                                <div class="search-icon">
                                    <i class="far fa-search"></i>
                                </div>
                                <div class="mobile-search-input">
                                    <form action="SearchEventController">
                                        <input
                                            class="search-input"
                                            type="text"
                                            placeholder="Search"
                                            name="eventName"
                                            />
                                    </form>
                                </div>
                                <span class="clear"><i class="fal fa-times"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="profile-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="widget">
                            <div class="widget-title">
                                <h3>Profile</h3>
                            </div>
                        </div>
                        <div class="profile-avatar">
                            <img src="${sessionScope.avatar}" />
                        </div>
                        <div class="view-info">
                            <ul class="info">
                                <div class="edit">
                                    <span><i class="fas fa-edit"></i> Edit</span>
                                </div>
                                <li>
                                    <div class="info-icon"><i class="far fa-signature"></i></div>
                                    <div class="info-text">
                                        <h4>Full Name</h4>
                                        <p>${user.name}</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-envelope"></i></div>
                                    <div class="info-text">
                                        <h4>Email</h4>
                                        <p>${sessionScope.email}</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-birthday-cake"></i></div>
                                    <div class="info-text">
                                        <h4>D.O.B</h4>
                                        <p>${user.dayOfBirth}</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-venus-mars"></i></div>
                                    <div class="info-text">
                                        <h4>Gender</h4>
                                        <c:if test="${user.gender}">
                                            <p>Male</p>
                                        </c:if>
                                        <c:if test="${not user.gender}">
                                            <p>Female</p>
                                        </c:if>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-phone-volume"></i></div>
                                    <div class="info-text">
                                        <h4>Phone Number</h4>
                                        <p>${user.phoneNumber}</p>
                                    </div> 
                                </li>
                            </ul>
                        </div>

                        <form action="profile" class="edit-info" method="POST">
                            <ul class="info">
                                <span class="save">
                                    <i class="fas fa-save"></i>
                                    <input type="submit" value="Save" />
                                </span>
                                <li>
                                    <div class="info-icon"><i class="far fa-signature"></i></div>
                                    <div class="info-text">
                                        <h4>Full Name</h4>
                                        <div class="text-field">
                                            <input autocomplete="off" type="text" placeholder="Enter your full name" id="fullname" name="txtUsername" value="${user.name}"/>
                                            <label for="fullname">Full name</label>
                                            <c:if test="${not empty txtUsernameError}">
                                                <h5 class="text-danger">*${txtUsernameError}</h5>
                                            </c:if>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-envelope"></i></div>
                                    <div class="info-text">
                                        <h4>Email</h4>
                                        <div class="text-field">
                                            <input autocomplete="off" type="email" placeholder="Enter your email" 
                                                   id="email" name="txtEmail" value="${sessionScope.email}" disabled/>
                                            <label for="email">Email</label>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-birthday-cake"></i></div>
                                    <div class="info-text">
                                        <h4>D.O.B</h4>
                                        <div class="text-field">
                                            <input autocomplete="off" type="date" placeholder="Enter your day of birth" id="dob" name="txtDate"/>
                                            <label for="dob">D.O.B</label>

                                        </div>
                                        <c:if test="${not empty txtDateError}">
                                            <h5 class="text-danger">*${txtDateError}</h5>
                                        </c:if>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-venus-mars"></i></div>
                                    <div class="info-text">
                                        <h4>Gender</h4>
                                        <input type="radio" id="male" class="radio-input" name="gender" value="1"
                                               <c:if test="${user.gender}">
                                                   checked
                                               </c:if>
                                               />
                                        <label for="male" class="radio-label"></label>
                                        <span class="radio-name">Male</span>
                                        <input type="radio" id="fmale" class="radio-input" name="gender" value="0"
                                               <c:if test="${not user.gender}">
                                                   checked
                                               </c:if>/>
                                        <label for="fmale" class="radio-label"></label>
                                        <span class="radio-name">Female</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="info-icon"><i class="far fa-phone-volume"></i></div>
                                    <div class="info-text">
                                        <h4>Phone Number</h4>
                                        <div class="text-field">
                                            <input autocomplete="off" type="text" placeholder="Enter your phone number" id="phone" name="txtPhoneNumber" value="${user.phoneNumber}"/>
                                            <label for="phone">Phone Number</label>
                                        </div>
                                        <c:if test="${not empty txtPhoneNumberError}">
                                            <h5 class="text-danger">*${txtPhoneNumberError}</h5>
                                        </c:if>
                                    </div>
                                </li>
                            </ul>
                        </form>
                    </div>

                    <div class="col-lg-9">
                        <div class="card card-custom">
                            <div class="card-header">
                                <div class="card-toolbar">
                                    <ul class="nav nav-tabs nav-bold nav-tabs-line">
                                        <li class="nav-item">
                                            <a
                                                class="nav-link active"
                                                data-bs-toggle="tab"
                                                role="tab"
                                                href="#schedule"
                                                >
                                                <span class="nav-icon"
                                                      ><i class="fas fa-users"></i
                                                    ></span>
                                                <span class="nav-text">Calendar</span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a
                                                class="nav-link"
                                                data-bs-toggle="tab"
                                                role="tab"
                                                href="#attended"
                                                >
                                                <span class="nav-icon"
                                                      ><i class="fas fa-chart-line"></i
                                                    ></span>
                                                <span class="nav-text">Feedback</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="tab-content">
                                    <div
                                        class="tab-pane fade show active"
                                        id="schedule"
                                        role="tabpanel"
                                        aria-labelledby="schedule"
                                        >
                                        <div id="calendar"></div>
                                    </div>
                                    <div
                                        class="tab-pane fade"
                                        id="attended"
                                        role="tabpanel"
                                        aria-labelledby="attended"
                                        >
                                        <c:if test="${not empty error}">
                                            <div class="text-center mt-5">
                                                <h5>${error}</h5>
                                            </div>
                                        </c:if>
                                        <c:if test="${empty error}">
                                            <div class="table-header">
                                                <h3 class="p-3 mx-auto">ATTENDED EVENT LIST</h3>
                                            </div>
                                            <div class="table-body">
                                                <div class="table-responsive">
                                                    <table
                                                        id="attended-table"
                                                        class="table table-bordered table-hover dtr-inline"
                                                        >
                                                        <thead>
                                                            <tr>
                                                                <th>Name</th>
                                                                <th>Organize Date</th>
                                                                <th>Location</th>
                                                                <th>Category</th>
                                                                <th>Fee</th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="event" items="${attendedEventList}">
                                                                <tr>
                                                                    <td>${event.eventName}</td>
                                                                    <td>${event.startDate} - ${event.endDate}</td>
                                                                    <td>
                                                                        <c:forEach var="location" items="${locationList}">
                                                                            <c:if test="${event.locationID eq location.locationID}">
                                                                                ${location.locationName}
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </td>
                                                                    <td>
                                                                        <c:forEach var="category" items="${categoryList}">
                                                                            <c:if test="${event.categoryID eq category.categoryID}">
                                                                                ${category.categoryName}
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </td>
                                                                    <td>
                                                                        <c:if test="${event.ticketFee eq 0}">
                                                                            Free
                                                                        </c:if>
                                                                        <c:if test="${event.ticketFee gt 0}">
                                                                            ${event.ticketFee} VND
                                                                        </c:if>
                                                                    </td>
                                                                    <td>
                                                                        <a href="feedback?action=rate&eventID=${event.eventID}" class="btn-icon" data-tooltip="tooltip" title="Give feedback">
                                                                            <i class="fa fa-comments" aria-hidden="true"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
                crossorigin="anonymous"
            ></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script src="./asset/js/evo-calendar.js"></script>
            <script
                type="text/javascript"
                src="https://cdn.datatables.net/v/bs5/dt-1.11.3/datatables.min.js"
            ></script>
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

            <script src="./asset/js/main.js"></script>

            <script>
                $(document).ready(function () {
                    $("#attended-table").DataTable();
                });

                $(document).ready(function () {
                    $('[data-tooltip="tooltip"]').tooltip();
                });
            </script>
        <c:if test="${param.message eq 'Update successfully'}">
            <script>
                Swal.fire(
                        'Success!',
                        'You updated your profile successfully!',
                        'success'
                        );
            </script>
        </c:if>
        <c:if test="${param.rating eq 'success'}">
            <script>
                Swal.fire(
                        'Success!',
                        'Your feedback have been sent successfully!',
                        'success'
                        );
            </script>
        </c:if>
        <c:if test="${requestScope.message eq 'Update failed'}">
            <script>
                Swal.fire(
                        'Fail!',
                        'There are some error happen when you update!',
                        'error'
                        );
            </script>
        </c:if>
        <c:if test="${param.feedback eq 'fail'}">
            <script>
                Swal.fire(
                        'Fail!',
                        'You have feedbacked this event already!',
                        'error'
                        );
            </script>
        </c:if>
        <script>
            var form = document.querySelector(".edit-info");
            var view = document.querySelector(".view-info");
            var edit = document.querySelector(".edit");
            var save = document.querySelector('.save input[type="submit"]');
            edit.addEventListener("click", function () {
                form.style.display = "block";
                view.style.display = "none";
                console.log(active.value);
            });
            save.addEventListener("click", function () {
                form.style.display = "none";
                view.style.display = "block";
            });
            $(document).ready(function () {
            $("#calendar").evoCalendar({
            theme: "Orange Coral",
                    calendarEvents: [
                    {
                    id: "bHay68s", // Event's ID (required)
                            name: "New Year", // Event name (required)
                            date: "September/9/2021", // Event date (required)
                            type: "holiday", // Event type (required)
                            everyYear: true, // Same event every year (optional)
                    },
            <c:forEach var="register" items="${eventRegisterList}">
                    {
                    id: "${register.eventID}",
                            name: "${register.eventName}",
                            badge: "${register.startDate} - ${register.endDate}", // Event badge (optional)
                                                date: ["${register.startDate}", "${register.endDate}"], // Date range
                                                description: "You register this event!!", // Event description (optional)
                                                type: "registration",
                                                color: "#63d867", // Event custom color (optional)
                                        },
            </c:forEach>
            <c:forEach var="follow" items="${eventFollowedList}">
                                        {
                                        id: "${follow.eventID}",
                                                name: "${follow.eventName}",
                                                badge: "${follow.startDate} - ${follow.endDate}", // Event badge (optional)
                                                                    date: ["${follow.startDate}", "${follow.endDate}"], // Date range
                                                                    description: "You follow this event!!", // Event description (optional)
                                                                    type: "follow",
                                                                    color: "#5DADE2", // Event custom color (optional)
                                                            },
            </c:forEach>
                                                            ],
                                                    });
                                                    }
                                                    );
        </script>
    </body>
</html>
