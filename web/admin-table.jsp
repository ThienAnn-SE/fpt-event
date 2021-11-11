<!DOCTYPE html>
<html lang="vi-VN">
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"
              prefix="c"%>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>User data-tables</title>

        <!-- Custom fonts for this template -->
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

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
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
                <li class="nav-item active">
                    <a class="nav-link" href="UserManagementController">
                        <i class="fa fa-user-circle"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li class="nav-item">
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
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
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
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.email}</span>
                                    <img class="img-profile rounded-circle"
                                         src="${sessionScope.avatar}">
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
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->

                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">User data-tables</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Email</th>
                                                <th>Name</th>
                                                <th>Day of birth</th>
                                                <th>Gender</th>
                                                <th>Phone number</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Email</th>
                                                <th>Name</th>
                                                <th>Day of birth</th>
                                                <th>Gender</th>
                                                <th>Phone number</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="user" items="${userList}">
                                                <tr>                                              
                                                    <td><p>${user.email}</p></td>
                                                    <td>
                                                        <c:if test="${empty user.name}">
                                                            <p class="text-danger">missing</p>   
                                                        </c:if>
                                                        <p> ${user.name}</p>
                                                    </td>
                                                    <td>
                                                        <c:if test="${empty user.dayOfBirth}">
                                                            <p class="text-danger">missing</p>   
                                                        </c:if>
                                                        <p> ${user.dayOfBirth}</p>
                                                    </td>
                                                    <c:choose>
                                                        <c:when test="${user.gender}">
                                                            <td><p>Male</p></td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td><p>Female</p></td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <c:if test="${empty user.phoneNumber}">
                                                            <p class="text-danger">missing</p>   
                                                        </c:if>
                                                        ${user.phoneNumber}
                                                    </td>
                                                    <td>
                                                        <p>
                                                            <c:choose>
                                                                <c:when test="${user.role eq 1}">
                                                                    Student
                                                                </c:when>
                                                                <c:when test="${user.role eq 2}">
                                                                    Lecture
                                                                </c:when>
                                                                <c:when test="${user.role eq 3}">
                                                                    Mentor
                                                                </c:when>
                                                                <c:when test="${user.role eq 4}">
                                                                    Club leader
                                                                </c:when>
                                                                <c:when test="${user.role eq 5}">
                                                                    Department leader
                                                                </c:when>
                                                            </c:choose>
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <p>
                                                            <c:choose>
                                                                <c:when test="${user.status eq 300}">
                                                                    <span class="badge badge-pill badge-primary">New</span>
                                                                </c:when>
                                                                <c:when test="${user.status eq 400}">
                                                                    <span class="badge badge-pill badge-danger">Invalid</span>
                                                                </c:when>
                                                                <c:when test="${user.status eq 450}">
                                                                    <span class="badge badge-pill badge-warning">Ban</span>
                                                                </c:when>
                                                                <c:when test="${user.status eq 500}">
                                                                    <span class="badge badge-pill badge-success">Active</span>
                                                                </c:when>
                                                            </c:choose> 
                                                        </p>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>                                   
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->

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
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Logout Modal-->
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

        <!-- Page level custom scripts -->
        <script src="./asset/js/demo/datatables-demo.js"></script>

    </body>

</html>