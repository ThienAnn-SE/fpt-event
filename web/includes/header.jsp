<%-- 
    Document   : header
    Created on : Jul 7, 2021, 4:33:17 PM
    Author     : ASUS
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <nav class="navbar navbar-expand-lg">
        <div class="navbar-header container-fluid fixed-top">
            <a class="navbar-brand" href="HomePageController">
                <img class="nav logo" src="./asset/img/fu.png" />
            </a>
            <button class="navbar-toggler">
                <i id="toggle" class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse">
                <div class="navbar-nav">
                    <a class="item nav-link active" href="HomePageController">home</a>
                    <a class="item nav-link" href="SearchEventController">event</a>
                    <a class="item nav-link" href="ViewClubController">club</a>
                    <c:if test="${empty role}">
                        <a class="nav-link" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                            <button class="button">
                                <i class="fab fa-google"></i>
                                Login
                            </button>
                        </a>
                    </c:if>
                    <c:if test="${role eq 1 or role eq 2}">
                        <a class="item nav-link" href="ViewUserController">view profile</a>
                    </c:if>
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
