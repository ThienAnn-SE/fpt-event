<!DOCTYPE html>
<html lang="en">
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"
              prefix="c"%>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event</title>
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

    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>
            <section class="event-area">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-9">
                        <c:if test="${not empty requestScope.error}">
                            <h4 class="text-center py-5">${error}</h4>
                        </c:if>
                        <c:if test="${empty requestScope.error}">
                            <div class="container">
                                <div class="row">
                                    <%-- start content --%>
                                    <c:forEach var="event" items="${eventList}">
                                        <div class="col-lg-4 text-truncate">
                                            <div class="upcoming-event-wrapper">
                                                <div class="upcoming-event-img">
                                                    <a href="ViewEventController?eventID=${event.eventID}">
                                                        <img src="${event.imageURL}" />
                                                    </a>
                                                    <c:if test="${event.statusID ne 570}">
                                                        <div class="price">
                                                            <c:if test="${event.ticketFee eq 0}">
                                                                <span>Free</span>
                                                            </c:if>
                                                            <c:if test="${event.ticketFee gt 0}">
                                                                <span>${event.ticketFee} VND</span>
                                                            </c:if>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="upcoming-event-text">
                                                    <h3><a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a></h3>
                                                    <div class="event-meta">
                                                        <span>
                                                            <i class="far fa-calendar-alt"></i>
                                                            ${event.startDate}
                                                        </span>
                                                        <span><i class="fal fa-folder"></i> 
                                                            <c:forEach var="category" items="${categoryList}">
                                                                <c:if test="${event.categoryID eq category.categoryID}">
                                                                    ${category.categoryName}
                                                                </c:if>
                                                            </c:forEach>
                                                            <br/>
                                                        </span>
                                                        <span> 
                                                            <c:set var="num" value="0"/>
                                                            <i class="fal fa-comments"></i> 
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
                                                    <c:if test="${event.statusID ne 570}">
                                                        <a href="RegisterEventController?eventID=${event.eventID}" class="btn">
                                                            <span class="btn-text">book ticket</span>
                                                            <span class="btn-border"></span>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${event.statusID eq 570}">
                                                        <a class="btn btn-closed">
                                                            <span class="btn-text">Closed</span>
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <c:if test="${not empty page}">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item">
                                        <a class="page-link" href="SearchEventController?page=${page == 1 ? 1 : page - 1}&${lastSearch}">Previous</a>
                                    </li>
                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <li class="page-item ${page == i ? "active" : ""}">
                                            <a class="page-link" href="SearchEventController?page=${i}&${lastSearch}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="page-link" href="SearchEventController?page=${page < endPage ? page +1 : endPage}&${lastSearch}">Next</a>
                                    </li>
                                </ul>
                            </c:if>
                        </c:if>
                    </div>
                    <div class="col-lg-3">
                        <div class="widget_search">
                            <div class="widget">
                                <div class="widget-title">
                                    <h3>Search Events</h3>
                                </div>
                            </div>
                            <div class="search-form">
                                <div class="text-danger">${priceError}</div>
                                <form action="SearchEventController" id="price">
                                    <button class="btn" type="submit" name="btAction" value="price"><i class="far fa-search"></i></button>
                                    <div class="text-field">
                                        <input autocomplete="off" type="number" id="min" name="minPrice" placeholder="VND"/>
                                        <label for="min">Min Price</label>
                                        <div class="text-danger">${minPriceError}</div>
                                    </div>
                                    <div class="text-field">
                                        <input autocomplete="off" type="number" id="max" name="maxPrice" placeholder="VND" />
                                        <label for="max">Max Price</label>
                                        <div class="text-danger">${minPriceError}</div>
                                    </div>

                                </form>
                            </div>
                            <div class="search-form">
                                <div class="text-danger">${dateError}</div>
                                <form action="SearchEventController" id="date">
                                    <button class="btn" type="submit" name="btAction" value="date"><i class="far fa-search"></i></button>
                                    <div class="text-field">
                                        <input autocomplete="off" type="date" id="start" name="startDate"/>
                                        <label for="start">Start Date</label>
                                        <div class="text-danger">${startDateError}</div>
                                    </div>
                                    <div class="text-field">
                                        <input autocomplete="off" type="date" id="end" name="endDate"/>
                                        <label for="end">End Date</label>
                                        <div class="text-danger">${endDateError}</div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="widget_categories">
                            <div class="widget">
                                <div class="widget-title">
                                    <h3>Categories</h3>
                                </div>
                            </div>
                            <ul>
                                <li class="category-item">
                                    <a href="SearchEventController?btAction=category&categoryID=20">Learning</a>
                                </li>
                                <li class="category-item">
                                    <a href="SearchEventController?btAction=category&categoryID=15">Entertainment</a>
                                </li>
                                <li class="category-item">
                                    <a href="SearchEventController?btAction=category&categoryID=10">Seminar</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${param.success}">
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                            <!-- Modal Header -->
                            <div class="modal-header py-3">
                                <h2 class="modal-title">Notification</h2>
                            </div>

                            <!-- Modal body -->
                            <div class="modal-body py-3">
                                <p class="font-weight-bold text-center"><strong class="text-success">You register this event successfully !!!</strong> </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <!-- Modal Header -->
                            <div class="modal-header py-3">
                                <h2 class="modal-title">Notification</h2>
                            </div>
                            <!-- Modal body -->
                            <div class="modal-body py-3">
                                <p class="font-weight-bold text-center"><strong class="text-danger">${errorMessage}!!!</strong> </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </section>
        <jsp:include page="./includes/footer.jsp"></jsp:include>

        <script src="./asset/js/main.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                // Show the Modal on load
                $("#myModal").modal("show");
            });
        </script>
        <script>
        </script>
    </body>
</html>
