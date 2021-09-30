<%@page import="utils.GetParam"%>
<%@page import="dtos.UserDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Profile</title>
        <link rel="stylesheet" href="./asset/css/reset.css" />
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/profile.css" />
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
        <c:set var="user" value="${requestScope.user}"/>
        <div class="container">
            <div class="square"></div>
            <div class="square"></div>
            <div class="square"></div>
            <div class="square"></div>
            <div class="square"></div>
            <div class="row">
                <div class="left col-md-4">
                    <div class="img">
                        <img src="./asset/img/trungthu.png" />
                    </div>
                    <div class="nav">
                        <a class="item nav-link" href="#">view schedule</a>
                        <a class="item nav-link" href="#">view followed events</a>
                        <a class="item nav-link" href="#">view registered events</a>
                    </div>
                </div>
                <div class="right col-md-8">
                    <div class="info-card">
                        <h3 class="info">Profile Card</h3>
                        <h3 class="school">FPT University</h3>
                        <img src="./asset/img/fu.png" class="logo" />

                        <div class="show-card">
                            <div class="edit">
                                <a href="#"><i class="fal fa-edit"></i> Edit</a>
                            </div>
                            <c:choose>
                                <c:when test="${not empty user.phoneNumber}">
                                    <h3 class="phone-number">${user.phoneNumber}</h3>
                                </c:when>
                                <c:otherwise>
                                    <h3 class="phone-number">Your phone number</h3>
                                </c:otherwise>
                            </c:choose>
                            <h5 class="dob">
                                <span>Day Of <br/>Birth </span>
                                    <c:choose>
                                        <c:when test="${not empty user.dayOfBirth}">
                                        <span>${user.dayOfBirth}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>DD/MM/YYYY</span>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <c:choose>
                                <c:when test="${not empty user.name}">
                                    <h5 class="fullname">${user.name}</h5>
                                </c:when>
                                <c:otherwise>
                                    <h5 class="fullname">Your name</h5>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${user.gender}">
                                    <h5 class="gender"><i class="fal fa-venus"></i></h5>
                                </c:when>
                                <c:otherwise>
                                    <h5 class="gender"><i class="fal fa-mars"></i></h5>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <form action="UpdateController" method="POST">
                            <div class="save">
                                <i class="fal fa-save"></i>
                                <input type="submit" value="Save" />
                            </div>
                            <h3 class="phone-number">
                                <input type="tel" name="txtPhoneNumber" value="${user.phoneNumber}" placeholder="Phone number"/>
                            </h3>
                            <h5 class="dob">
                                <span>Day Of <br/>Birth </span>
                                <span><input type="date" name="txtDate" value="${user.dayOfBirth}" placeholder="DD/MM/YYYY"/></span>
                            </h5>
                            <h5 class="fullname">
                                <input type="text" value="${user.name}" name="txtUserName" placeholder="Your name"/>
                            </h5>
                            <h5 class="gender">
                                <c:choose>
                                    <c:when test="${user.gender}">
                                        <label class="male">
                                            <input type="radio" name="gender" value="1" checked/>
                                            <i class="fal fa-venus"></i>
                                        </label>
                                        <label class="female">
                                            <input type="radio" name="gender" value="0"/>
                                            <i class="fal fa-mars"></i>
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="male">
                                            <input type="radio" name="gender" value="1"/>
                                            <i class="fal fa-venus"></i>
                                        </label>
                                        <label class="female">
                                            <input type="radio" name="gender" value="0" checked/>
                                            <i class="fal fa-mars"></i>
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                        </form>
                    </div>
                    <div class="info-card"></div>
                </div>
            </div>
        </div>
        <script>
            var form = document.querySelector("form");
            var showCard = document.querySelector(".show-card");
            var edit = document.querySelector(".edit");
            var save = document.querySelector('.save input[type="submit"]');

            edit.addEventListener("click", function () {
                form.style.display = "block";
                showCard.style.display = "none";
            });
            save.addEventListener("click", function () {
                form.style.display = "none";
                showCard.style.display = "block";
            });
        </script>
    </body>
</html>
