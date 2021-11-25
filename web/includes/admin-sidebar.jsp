<%-- 
    Document   : admin-sidebar
    Created on : Nov 19, 2021, 12:17:55 AM
    Author     : thien
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin-dashboard">
        <div class="sidebar-brand-icon">
            <image src="./asset/img/FPTU_EVENT.png" style="width:  100px"/>
        </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item <c:if test="${param.active eq 'dashboard'}">active</c:if>">
        <a class="nav-link" href="admin-dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Management
    </div>

    <!-- Nav Item - Tables -->
    <li class="nav-item <c:if test="${param.active eq 'user'}">active</c:if>">
        <a class="nav-link" href="admin-user">
            <i class="fa fa-user-circle"></i>
            <span>Users</span>
        </a>
    </li>
    <li class="nav-item <c:if test="${param.active eq 'club'}">active</c:if>">
        <a class="nav-link" href="admin-club">
            <i class="fa fa-users"></i>
            <span>Club</span>
        </a>
    </li>

    <li class="nav-item  <c:if test="${param.active eq 'category'}">active</c:if>">
        <a class="nav-link" href="admin-category">
            <i class="fa fa-list"></i>
            <span>Category</span>
        </a>
    </li>
    <li class="nav-item <c:if test="${param.active eq 'location'}">active</c:if>">
        <a class="nav-link" href="admin-location">
            <i class="fa fa-location-arrow"></i>
            <span>Location</span>
        </a>
    </li>

    <hr class="sidebar-divider">

    <div class="sidebar-heading">
        Process
    </div>

    <li class="nav-item  <c:if test="${param.active eq 'ban'}">active</c:if>">
        <a class="nav-link" href="admin-form">
            <i class="fa fa-exclamation-circle"></i>
            <span>Ban user request</span></a>
    </li>

    <li class="nav-item <c:if test="${param.active eq 'report'}">active</c:if>">
        <a class="nav-link" href="admin-request">
            <i class="fa fa-comment"></i>
            <span>Comment report</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
