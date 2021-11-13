<%-- 
    Document   : admin-category
    Created on : Nov 1, 2021, 10:30:04 AM
    Author     : thien
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi-VN">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Category management</title>
        <link href="./asset/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="./asset/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="./asset/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>
    <body id="page-top">
        <div id="wrapper">
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="AdminDashboardController">
                    <div class="sidebar-brand-icon">
                        <image src="./asset/img/FPTU_EVENT.png" style="width:  100px"/>
                    </div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item">
                    <a class="nav-link" href="AdminDashboardController">
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
                <li class="nav-item">
                    <a class="nav-link" href="UserManagementController">
                        <i class="fa fa-user-circle"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="AdminClubManagementController">
                        <i class="fa fa-users"></i>
                        <span>Club</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="AdminCategoryController">
                        <i class="fa fa-list"></i>
                        <span>Category</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdminLocationController">
                        <i class="fa fa-location-arrow"></i>
                        <span>Location</span>
                    </a>
                </li>

                <hr class="sidebar-divider">

                <div class="sidebar-heading">
                    Process
                </div>

                <li class="nav-item">
                    <a class="nav-link" href="AdminFormController">
                        <i class="fa fa-exclamation-circle"></i>
                        <span>Ban user request</span></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">
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

            <div id="content-wrapper" class="d-flex flex-column">

                <div id="content">
                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                        <!-- Topbar Navbar -->
                        <ul class="navbar-nav ml-auto">

                            <div class="topbar-divider d-none d-sm-block"></div>

                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">${email}</span>
                                    <img class="img-profile rounded-circle"
                                         src="${avatar}">
                                </a>
                                <!-- Dropdown - User Information -->
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Logout
                                    </a>
                                </div>
                            </li>

                        </ul>

                    </nav>

                    <div class="container-fluid col-lg-8">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Add new club</h3>
                            </div>
                            <div class="card-body">
                                <form action="AdminClubManagementController" method="POST" class="needs-validation" novalidate>
                                    <div class="form-group">
                                        <label for="clubName" class="font-weight-bold">Club name:</label>
                                        <input type="text" class="form-control" id="clubName" name="clubName" placeholder="Enter the club name" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="clubDescription" class="font-weight-bold">Club description:</label>
                                        <input type="text" class="form-control" id="clubDescription" name="clubDescription" placeholder="Enter the club description" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="createDate" class="font-weight-bold">Club create date:</label>
                                        <input type="date" class="form-control" id="createDate" name="createDate" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please choose a date</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="clubEmail" class="font-weight-bold">Club Email:</label>
                                        <input type="text" class="form-control" id="clubEmail" name="clubEmail" placeholder="Enter the club email" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="clubPhoneNumber" class="font-weight-bold">Club phone number:</label>
                                        <input type="tel" class="form-control" id="clubPhoneNumber" name="clubPhoneNumber" placeholder="Enter the club phone number" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="userEmail" class="font-weight-bold">Club leader email:</label>
                                        <input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Enter the club leader email" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Change club leader email</h3>
                            </div>
                            <div class="card-body">
                                <form action="AdminClubManagementController" method="POST" class="needs-validation" novalidate>
                                    <div class="form-group">
                                        <label for="clubID" class="font-weight-bold">Select club:</label>
                                        <select class="form-control" id="clubID" name="clubID" required>
                                            <option value="" disabled selected hidden>---Choose club---</option>
                                            <c:forEach var="club" items="${clubList}">
                                                <option value="${club.clubID}">${club.clubName}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="valid-feedback">Valid.</div>
                                        <div class="invalid-feedback">Please choose action to do.</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="categoryName" class="font-weight-bold">Email:</label>
                                        <input type="text" class="form-control" id="categoryName" name="userEmail" placeholder="Enter the new email" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h5 class="m-0 font-weight-bold text-primary">Club list</h5>
                            </div>
                            <div class="card-body">
                                <div class="table table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Club name</th>
                                                <th>Club email</th>
                                                <th>Club phone number</th>
                                                <th>Club description</th>
                                                <th>Club create date</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Club name</th>
                                                <th>Club email</th>
                                                <th>Club phone number</th>
                                                <th>Club description</th>
                                                <th>Club create date</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="club" items="${clubList}">
                                                <tr>
                                                    <td>${club.clubName}</td>
                                                    <td>${club.clubEmail}</td>
                                                    <td>${club.clubPhoneNumber}</td>
                                                    <td>${club.clubDescription}</td>
                                                    <td>${club.createDate}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Footer -->
                    <footer class="sticky-footer bg-white">
                        <div class="container my-auto">
                            <div class="copyright text-center my-auto">
                                <span>Copyright &copy; Your Website 2020</span>
                            </div>
                        </div>
                    </footer>
                    <!-- End of Footer -->
                </div>
            </div>

        </div>
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true"><strong>X</strong></span>
                        </button>
                    </div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-primary" href="login.html">Logout</a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Disable form submissions if there are invalid fields
            (function () {
                'use strict';
                window.addEventListener('load', function () {
                    // Get the forms we want to add validation styles to
                    var forms = document.getElementsByClassName('needs-validation');
                    // Loop over them and prevent submission
                    var validation = Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>
        <!-- Bootstrap core JavaScript-->
        <script src="./asset/vendor/jquery/jquery.min.js"></script>
        <script src="./asset/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="./asset/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="./asset/js/sb-admin-2.min.js"></script>
        <!-- Page level plugins -->
        <script src="./asset/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="./asset/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <script src="./asset/js/demo/datatables-demo.js"></script>
    </body>
</html>
