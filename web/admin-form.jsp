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

        <title>Admin dashboard</title>

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
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-laugh-wink"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">FU EVENT MANAGEMET</div>
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
                    Selections
                </div>
                <!-- Nav Item - Tables -->
                <li class="nav-item">
                    <a class="nav-link" href="UserManagementController">
                        <i class="fas fa-fw fa-table"></i>
                        <span>Tables</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="AdminFormController">
                        <i class="fa fa-list-ul"></i>
                        <span>Form</span></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="">
                        <i class="fa fa-envelope"></i>
                        <span>Request</span>
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
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid col-lg-8">
                        <!-- Page Heading -->
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>${successMessage}</strong>
                            </div>
                        </c:if>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>${errorMessage}</strong>
                            </div>
                        </c:if>
                        <!-- Page Body -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">User banning form</h3>
                                <div class="card-body">
                                    <!-- start of form -->
                                    <form action="AdminFormController" class="needs-validation" novalidate>
                                        <div class="form-group">
                                            <label for="email">User email:</label>
                                            <input type="text" class="form-control" id="email" placeholder="Enter user email" name="email" required>
                                            <div class="valid-feedback">Valid.</div>
                                            <div class="invalid-feedback">Please fill out this field.</div>
                                        </div>
                                        <div class="form-group">
                                            <label for="btAction">Select action:</label>
                                            <select class="form-control" id="btAction" name="btAction" required>
                                                <option disabled selected hidden value="">---Choose action---</option>
                                                <option value="ban">Ban user temporary</option>
                                                <option value="invalid">Invalid user from system</option>
                                            </select>
                                            <div class="valid-feedback">Valid.</div>
                                            <div class="invalid-feedback">Please choose action to do.</div>
                                        </div>
                                        <div class="form-group">
                                            <label for="reason">Reason:</label>
                                            <textarea class="form-control" rows="4" id="reason" name="reason" placeholder="Please enter the reason" required></textarea>
                                            <div class="characters">
                                                <span class="signal_num">0</span>
                                                <span class="limit_num">/100</span>
                                            </div>
                                            <div class="valid-feedback">Valid.</div>
                                            <div class="invalid-feedback">Please fill out this field.</div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                Club banning request
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>From</th>
                                                <th>User email</th>
                                                <th>Send date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>From</th>
                                                <th>User email</th>
                                                <th>Send date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <tr>                                              
                                                <td>
                                                    <p></p>
                                                </td>
                                                <td>
                                                    <p></p>
                                                </td>
                                                <td>
                                                    <p></p>
                                                </td>
                                                <td>
                                                    <p></p>
                                                </td>
                                                <td>
                                                    <p></p>
                                                </td>
                                            </tr>
                                        </tbody>                                   
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Banned user list</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Email</th>
                                                <th>Name</th>                                              
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Email</th>
                                                <th>Name</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="user" items="${userBanList}">
                                                <tr>
                                            <form action="CancelBanController">
                                                <td>
                                                    <p>${user.email}</p>
                                                    <input type="hidden" name="email" value="${user.email}"/>
                                                </td>
                                                <td>
                                                    <c:if test="${empty user.name}">
                                                        <p class="text-danger">missing</p>   
                                                    </c:if>
                                                    <p> ${user.name}</p>
                                                    <input type="hidden" name="name" value="${user.name}"/>
                                                </td>                                                   
                                                <td>
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${user.status eq 400}">
                                                                <span class="badge badge-pill badge-danger">Invalid</span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 450}">
                                                                <span class="badge badge-pill badge-warning">Ban</span>
                                                            </c:when>
                                                        </c:choose> 
                                                    </p>
                                                </td>
                                                <td>
                                                    <button type="submit" class="btn badge-danger">Cancel</button>
                                                </td>
                                            </form>
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