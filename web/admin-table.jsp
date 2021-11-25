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
            <jsp:include page="includes/admin-sidebar.jsp">
                <jsp:param name="active" value="user"/>
            </jsp:include>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="User list"/>
                        <jsp:param name="avatar" value="${sessionScope.avatar}"/>
                    </jsp:include>
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
                <jsp:include page="includes/admin-footer.jsp"/>
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