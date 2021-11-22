<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event management</title>
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
        <link
            rel="stylesheet"
            type="text/css"
            href="https://cdn.datatables.net/v/bs5/dt-1.11.3/datatables.min.css"
            />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <div class="leader">
            <div class="text-center">
                <h1 class="p-3">EVENT MANAGEMENT</h1>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card card-custom">
                            <div class="card-header">
                                <div class="card-toolbar">
                                    <ul class="nav nav-tabs nav-bold nav-tabs-line">
                                        <li class="nav-item">
                                            <a
                                                class="nav-link active"
                                                data-bs-toggle="tab"
                                                role="tab"
                                                href="#event"
                                                >
                                                <span class="nav-icon"
                                                      ><i class="fas fa-calendar-star"></i
                                                    ></span>
                                                <span class="nav-text">Event Created</span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a
                                                class="nav-link"
                                                data-bs-toggle="tab"
                                                role="tab"
                                                href="#statistics"
                                                >
                                                <span class="nav-icon"
                                                      ><i class="fas fa-chart-line"></i
                                                    ></span>
                                                <span class="nav-text">Statistics</span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a
                                                class="nav-link"
                                                data-bs-toggle="tab"
                                                role="tab"
                                                href="#user"
                                                >
                                                <span class="nav-icon"
                                                      ><i class="fas fa-users"></i
                                                    ></span>
                                                <span class="nav-text">Event Payment</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="tab-content">
                                    <div
                                        class="tab-pane fade"
                                        id="user"
                                        role="tabpanel"
                                        aria-labelledby="user"
                                        >
                                        <div class="table-responsive">
                                            <table
                                                id="user-table"
                                                class="table table-bordered table-hover dtr-inline"
                                                >
                                                <thead>
                                                    <tr>
                                                        <th>Payment Description</th>
                                                        <th>Payment Date</th>
                                                        <th>Payment Method</th>
                                                        <th>Total</th>
                                                        <th>Payment Status</th>
                                                        <th>Edit Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="payment" items="${paymentList}">
                                                        <tr>
                                                            <td>${payment.paymentDescription}</td>
                                                            <td>${payment.paymentDate}</td>
                                                            <td>${payment.paymentMethod}</td>
                                                            <td>${payment.paymentTotal}</td>
                                                            <c:if test="${payment.statusDescription eq 'pending'}">
                                                                <td>
                                                                    <span class="label-item warning label-dot mr-2"></span>
                                                                    <span>Pending</span>
                                                                </td>
                                                                <td>
                                                                    <a href="#" class="btn-icon" data-href="ChangePaymentStatusController?registerID=${payment.registerID}" data-toggle="modal" data-target="#confirm-edit">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${payment.statusDescription eq 'paid'}">
                                                                <td>
                                                                    <span class="label-item success label-dot mr-2"></span>
                                                                    <span>Paid</span>
                                                                </td>
                                                                <td>
                                                                    <a href="#" class="btn-icon disabled">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div
                                        class="tab-pane fade show active"
                                        id="event"
                                        role="tabpanel"
                                        aria-labelledby="event"
                                        >
                                        <div class="table-header">
                                            <a href="event-add" class="btn">
                                                <span class="btn-text">create an event</span>
                                                <span class="btn-border"></span>
                                            </a>
                                        </div>
                                        <div class="table-body">
                                            <c:if test="${param.success}">
                                                <div class="alert alert-success alert-dismissible fade show">
                                                    <strong>Success!</strong> Add new event successfully
                                                </div>  
                                            </c:if>
                                            <div class="table table-responsive">
                                                <table
                                                    id="event-table"
                                                    class="
                                                    table table-bordered table-hover
                                                    dtr-inline
                                                    "
                                                    >
                                                    <thead>
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Create Date</th>
                                                            <th>Registration End Date</th>
                                                            <th>Organize Date</th>
                                                            <th>Location</th>
                                                            <th>Category</th>
                                                            <th>Slot</th>
                                                            <th>Fee</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="event" items="${eventList}">
                                                            <tr>
                                                                <td><h6>${event.eventName}</h6></td>
                                                                <td>${event.createDate}</td>
                                                                <td>${event.registerEndDate}</td>
                                                                <td>${event.startDate} ~ ${event.endDate}</td>
                                                                <td>
                                                                    <c:forEach var="location" items="${locationList}">
                                                                        <c:if test="${event.locationID eq location.locationID}">
                                                                            ${location.locationName}
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                                <td>
                                                                    <c:forEach var="category" items="${categoryList}">
                                                                        <c:if test="${event.categoryID eq  category.categoryID}">
                                                                            ${category.categoryName}
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                                <td>
                                                                    <c:set var="num" value="0"/>
                                                                    <c:forEach var="registerNum" items="${registerNumList}">
                                                                        <c:if test="${event.eventID eq registerNum.eventID}">
                                                                            <c:set var="num" value="${registerNum.registerNum}"/>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    ${num}/${event.slot}
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
                                                                    <div class="label status">
                                                                        <c:if test="${event.statusID eq 300}">
                                                                            <span class="label-item info"
                                                                                  >not start</span
                                                                            >
                                                                        </c:if>
                                                                        <c:if test="${event.statusID eq 500 or event.statusID eq 530 or event.statusID eq 550}">
                                                                            <span class="label-item success"
                                                                                  >ongoing</span
                                                                            >
                                                                        </c:if>
                                                                        <c:if test="${event.statusID eq 570}">
                                                                            <span class="label-item warning"
                                                                                  >closed</span
                                                                            >
                                                                        </c:if>
                                                                        <c:if test="${event.statusID eq 400}">
                                                                            <span class="label-item danger"
                                                                                  >cancel</span
                                                                            >
                                                                        </c:if>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <form action="UpdateEventController" method="POST" id="update-form">
                                                                        <a href="ViewEventController?eventID=${event.eventID}" class="btn-icon active" data-tooltip="tooltip" title="View event detail">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <a href="leader-registrationList?eventID=${event.eventID}" class="btn-icon" data-tooltip="tooltip"  title="View registration">
                                                                            <i class="fa fa-users"></i>
                                                                        </a>
                                                                        <c:if test="${event.statusID eq 500 or event.statusID eq 530 or event.statusID eq 550}">
                                                                            <a href="UpdateEventController?eventID=${event.eventID}" class="btn-icon" data-tooltip="tooltip" title="Edit event">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${ event.statusID  ne 400 and event.statusID ne 550 and event.statusID ne 570}">
                                                                            <a  href="#confirm-cancel" class="btn-icon" id="cancel-link" data-tooltip="tooltip" title="Cancel event" data-toggle="modal" data-id="${event.eventID}">
                                                                                <i class="fas fa-trash-alt"></i>
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${event.statusID eq 570}">
                                                                            <a href="feedback?action=view&eventID=${event.eventID}" class="btn-icon" data-tooltip="tooltip" title="View feedback">
                                                                                <i class="fa fa-comments" aria-hidden="true"></i>
                                                                            </a>
                                                                        </c:if>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>                                  

                                    <div
                                        class="tab-pane fade"
                                        id="statistics"
                                        role="tabpanel"
                                        aria-labelledby="statistics"
                                        >
                                        <div id="statistics">
                                            <div>
                                                <select id="days">
                                                    <option value="7">the past 7 days</option>
                                                    <option value="30">the past 30 days</option>
                                                </select>
                                            </div>
                                            <div>
                                                <canvas id="lineChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="confirm-cancel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="UpdateEventController" method="POST" id="update-form">
                        <div class="modal-header">
                            <h3 class="m-1 font-weight-bold">Cancel event confirmation</h3>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to <strong>cancel</strong> this event?
                                Cancelled event will not be viewed or interacted by any one except you!</p>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="btAction" value="cancel"/>
                            <input type="hidden" name="eventID" id="eventID" value=""/>
                            <div class="form-btn">
                                <button type="button" id="cancel" data-dismiss="modal">Cancel</button>
                                <button type="submit" id="confirm">Confirm</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="confirm-edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        Change payment status
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to change this payment status into <strong>paid</strong>?<p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-danger btn-ok">Edit</a>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="./includes/footer.jsp"></jsp:include>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="./asset/js/main.js"></script>
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
                crossorigin="anonymous"
            ></script>
            <script
                type="text/javascript"
                src="https://cdn.datatables.net/v/bs5/dt-1.11.3/datatables.min.js"
            ></script>
            <script>
                $('#cancel-link').click(function (){
                    $('#eventID').val($('a[href="#confirm-cancel"]').data('id'));
                });
            </script>
            <script>
                $(".alert-dismissible").fadeTo(4000, 1000).slideUp(1000, function () {
                    $(".alert-dismissible").alert('close');
                });
            </script>
            <script>
                $(document).ready(function () {
                    $('[data-tooltip="tooltip"]').tooltip();
                });

                $('#confirm-edit').on('show.bs.modal', function (e) {
                    $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
                });
            </script>

            <script>
                $(document).ready(function () {
                    $("#event-table").DataTable();
                    $("#user-table").DataTable();
                });

                var days = document.getElementById("days");
                var chart = document.getElementById("lineChart");
                var array = [],
                        dayShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                        monthsShort = [
                            "Jan",
                            "Feb",
                            "Mar",
                            "Apr",
                            "May",
                            "Jun",
                            "Jul",
                            "Aug",
                            "Sep",
                            "Oct",
                            "Nov",
                            "Dec",
                        ],
                        dataFollowList = [
            <c:forEach var="follow" items="${dataFollowList}">
                ${follow},
            </c:forEach>
                        ],
                        dataRegisterList = [
            <c:forEach var="register" items="${dataRegisterList}">
                ${register},
            </c:forEach>
                        ];
                array = getDates();
                function getDates() {
                    var dateArray = [];
                    var currentDate = new Date();
                    for (var i = 0; i < days.value; i++) {
                        var temp = [
                            dayShort[currentDate.getDay()],
                            monthsShort[currentDate.getMonth()] + " " + currentDate.getDate(),
                            currentDate.getFullYear(),
                        ];
                        dateArray.push(temp);
                        currentDate.setDate(currentDate.getDate() - 1);
                    }
                    return dateArray;
                }
                function getFollowData() {
                    var data = [];
                    for (var i = 0; i < days.value; i++) {
                        data.push(dataFollowList[i]);
                    }
                    return data;
                }
                function getRegisterData() {
                    var data = [];
                    for (var i = 0; i < days.value; i++) {
                        data.push(dataRegisterList[i]);
                    }
                    return data;
                }

                days.onchange = () => {
                    array = getDates();
                    lineChart.config.data.labels = array.reverse();
                    lineChart.config.data.datasets[0].data = getFollowData().reverse();
                    lineChart.config.data.datasets[1].data = getRegisterData().reverse();
                    lineChart.update();
                };
                var lineChart = new Chart(chart, {
                    type: "line",
                    data: {
                        labels: array.reverse(),
                        datasets: [
                            {
                                label: "Students Followed",
                                backgroundColor: "rgb(255, 99, 132)",
                                borderColor: "rgb(255, 99, 132)",
                                data: getFollowData().reverse(),
                            },
                            {
                                label: "Students Registered",
                                backgroundColor: "rgb(75, 192, 192)",
                                borderColor: "rgb(75, 192, 192)",
                                data: getRegisterData().reverse(),
                            },
                        ],
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: "Number of students registered and followed",
                            },
                            tooltip: {
                                callbacks: {
                                    title: (context) => {
                                        return context[0].label.replaceAll(",", " ");
                                    },
                                },
                            },
                        },
                    },
                });
                Chart.defaults.font.size = 14;
        </script>
    </body>
</html>
