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

        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </head>
    <body id="page-top">
        <div id="wrapper">
            <!-- Sidebar -->
            <jsp:include page="includes/admin-sidebar.jsp">
                <jsp:param name="active" value="category"/>
            </jsp:include>
            <!-- End of Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">

                <div id="content">
                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="Category management"/>
                        <jsp:param name="avatar" value="${sessionScope.avatar}"/>
                    </jsp:include>
                    <!-- End of Topbar -->

                    <div class="container-fluid col-lg-8">
                        <c:if test="${not empty param.rs}">
                            <div class="alert alert-success alert-dismissible fade show">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Success!</strong> Add new category successfully
                            </div>
                        </c:if>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Add new category</h3>
                            </div>
                            <div class="card-body">
                                <form action="admin-category" method="POST" class="needs-validation" novalidate>
                                    <div class="form-group">
                                        <label for="categoryName" class="font-weight-bold">Category name:</label>
                                        <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="Enter the category name" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                        <c:if test="${not empty categoryNameError}">
                                            <div class="text-danger">${categoryNameError}</div>
                                        </c:if>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h5 class="m-0 font-weight-bold text-primary">Category list</h5>
                            </div>
                            <div class="card-body">
                                <div class="table table-responsive">
                                    <table class="table table-bordered" id="category-table" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>Category name</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>No.</th>
                                                <th>Category name</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="category" items="${categoryList}" varStatus="counter">
                                                <tr>
                                                    <td>${counter.count}</td>
                                                    <td>${category.categoryName}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Footer -->
                    <jsp:include page="includes/admin-footer.jsp"/>
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
            <c:if test="${param.result eq 'success'}">
            Swal.fire(
                    'Success!',
                    'Add new category successfully!',
                    'success'
                    );
            </c:if>
            <c:if test="${not empty requestScope.error}">
            Swal.fire(
                    'Error!',
                    '${requestScope.error}',
                    'error'
                    );
            </c:if>
        </script>
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
        <script>
            $(document).ready(function () {
                $('#category-table').DataTable();
            });
        </script>
    </body>
</html>
