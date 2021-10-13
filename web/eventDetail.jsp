<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event Detail</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/eventDetail.css" />
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
            <div class="container">
                <div class="card row">
                    <div class="event-imgs col-md-6">
                        <div id="img" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-indicators">
                                <button
                                    type="button"
                                    data-bs-target="#img"
                                    data-bs-slide-to="0"
                                    class="active"
                                    aria-current="true"
                                    aria-label="Slide 1"
                                    ></button>
                                <button
                                    type="button"
                                    data-bs-target="#img"
                                    data-bs-slide-to="1"
                                    aria-label="Slide 2"
                                    ></button>
                                <button
                                    type="button"
                                    data-bs-target="#img"
                                    data-bs-slide-to="2"
                                    aria-label="Slide 3"
                                    ></button>
                            </div>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="./asset/img/event.png" />
                                </div>
                                <div class="carousel-item">
                                    <img src="./asset/img/trungthu.png" />
                                </div>
                                <div class="carousel-item">
                                    <img src="./asset/img/event.png" />
                                </div>
                            </div>
                            <button
                                class="carousel-control-prev"
                                data-bs-target="#img"
                                data-bs-slide="prev"
                                >
                                <span
                                    class="carousel-control-prev-icon"
                                    aria-hidden="true"
                                    ></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button
                                class="carousel-control-next"
                                data-bs-target="#img"
                                data-bs-slide="next"
                                >
                                <span
                                    class="carousel-control-next-icon"
                                    aria-hidden="true"
                                    ></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <div class="event-content col-md-6">
                        <h2 class="event-title">
                            <a href="#">${clubName}</a><i class="fas fa-caret-right"></i>
                        <a href="#">${event.eventName}</a>
                    </h2>
                    <div class="event-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span>${event.avgVote}</span>
                        <!-- nếu chưa diễn ra thì ko có -->
                    </div>
                    <div class="event-price">
                        <c:choose>
                            <c:when test="${event.ticketFee eq 0}">
                                <span>Free</span>
                            </c:when>
                            <c:otherwise>
                                <span>${event.ticketFee}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="event-detail">
                        <h2>about this event:</h2>
                        <p>
                            ${event.content}
                        </p>
                        <ul>
                            <li>Category: <span>${catetoryName}</span></li>
                            <li>Location: <span>${locationName}</span></li>
                            <li>From: <span>${event.startDate}</span> To: <span>${event.endDate}</span></li>
                            <li>Status: <span>${statusDescription}</span></li>
                            <li>Available slots: <span>${registerNum}/${event.slot}</span></li>
                        </ul>
                    </div>
                    <div class="event-register">
                        <div class="num">
                            <input type="number" value="1" readonly />
                        </div>
                        <button>Register</button>
                    </div>
                    <c:if test="${event.statusID eq 550}">
                        <div class="rate">
                            <div class="post">
                                <span>Thanks for rating!</span>
                                <div class="edit">Edit</div>
                            </div>
                            <div class="star-icon">
                                <span>Vote & Send feedback</span><br/>
                                <input type="radio" name="rate" id="rate-5" value="5"/>
                                <label form="myForm" for="rate-5" class="fas fa-star"></label>
                                <input type="radio" name="rate" id="rate-4" value="4"/>
                                <label form="myForm" for="rate-4" class="fas fa-star"></label>
                                <input type="radio" name="rate" id="rate-3" value="3"/>
                                <label form="myForm" for="rate-3" class="fas fa-star"></label>
                                <input type="radio" name="rate" id="rate-2" value="2"/>
                                <label form="myForm" for="rate-2" class="fas fa-star"></label>
                                <input type="radio" name="rate" id="rate-1" value="1"/>
                                <label form="myForm" for="rate-1" class="fas fa-star"></label>
                            </div>
                            <form id="myForm" action="FeedbackController">
                                <div id="title"></div>
                                <textarea placeholder="Add your feedback here" name="feedback"></textarea>
                                <div class="characters">
                                    <span class="signal_num">0</span>
                                    <span class="limit_num">/100</span>
                                </div>
                                <input type="hidden" value="${event.eventID}" name="eventID"/>
                                <div class="btn">
                                    <button type="submit">Send</button>
                                </div>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>
        <script src="./asset/js/main.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
            crossorigin="anonymous">
        </script>
        <script>
            let form = document.querySelector(".container form"),
                    textarea = document.querySelector("form textarea"),
                    signal_num = document.querySelector(".signal_num"),
                    submit = document.querySelector("button[type=submit]");

            textarea.addEventListener("keyup", () => {
                let length = textarea.value.length;
                signal_num.innerText = length;

                if (length > 0)
                    form.classList.add("active");
                else
                    form.classList.remove("active");
                if (length > 100) {
                    form.classList.add("error");
                    submit.disabled = true;
                } else {
                    form.classList.remove("error");
                    submit.disabled = false;
                }
            });

            document.querySelectorAll("input[type=radio]").forEach((item) => {
                item.addEventListener("click", function () {
                    document.querySelector(".container form").style.display = "block";
                    if (document.getElementById("rate-5").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/256/4860/4860942.png" />';
                    else if (document.getElementById("rate-4").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://cdn-icons-png.flaticon.com/512/4860/4860844.png" />';
                    else if (document.getElementById("rate-3").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/512/4860/4860934.png" />';
                    else if (document.getElementById("rate-2").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/256/4860/4860859.png" />';
                    else if (document.getElementById("rate-1").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/512/4860/4860811.png" />';
                });
            });

            submit.addEventListener("click", function () {
                form.style.display = "none";
                document.querySelector(".star-icon").style.display = "none";
                document.querySelector(".post").style.display = "block";
            });

            document.querySelector(".edit").addEventListener("click", function () {
                form.style.display = "block";
                document.querySelector(".star-icon").style.display = "block";
                document.querySelector(".post").style.display = "none";
            });
        </script>
    </body>
</html>
