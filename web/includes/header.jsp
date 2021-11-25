<%-- 
    Document   : header
    Created on : Jul 7, 2021, 4:33:17 PM
    Author     : ASUS
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/login&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                                            <i class="fa fa-sign-in" aria-hidden="true"></i>
                                            login
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${not empty sessionScope.email}"> 
                                    <c:if test="${sessionScope.role eq 1 or sessionScope.role eq 2 or sessionScope.role eq 3}">
                                        <li class="header-item">
                                            <a href="profile">
                                                <i class="fa fa-user" aria-hidden="true"></i>
                                                profile
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${sessionScope.role eq 5 or sessionScope.role eq 4}">
                                        <li class="header-item">
                                            <a href="EventManagementController">
                                                <i class="fa fa-bars" aria-hidden="true"></i>
                                                management
                                            </a>
                                        </li>
                                    </c:if>
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
                                <li class="header-mobile-item">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/login&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                                        <i class="fa fa-sign-in" aria-hidden="true"></i>
                                        login
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${not empty sessionScope.email}">
                                <c:if test="${sessionScope.role eq 1 or sessionScope.role eq 2 or sessionScope.role eq 3}">
                                    <li class="header-mobile-item">
                                        <a href="profile">
                                            <i class="fa fa-user" aria-hidden="true"></i>
                                            profile
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.role eq 5or sessionScope.role eq 4}">
                                    <li class="header-mobile-item">
                                        <a href="EventManagementController">
                                            <i class="fa fa-bars" aria-hidden="true"></i>
                                            management
                                        </a>
                                    </li>
                                </c:if>
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
