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
                <jsp:param name="active" value="club"/>
            </jsp:include>
            <!-- End of Sidebar -->

            <div id="content-wrapper" class="d-flex flex-column">

                <div id="content">
                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="Club management"/>
                        <jsp:param name="avatar" value="${sessionScope.avatar}"/>
                    </jsp:include>
                    <!-- End of Topbar -->

                    <div class="container-fluid col-lg-8">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Add new club</h3>
                            </div>
                            <div class="card-body">
                                <form action="admin-club" method="POST" class="needs-validation" novalidate>
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
                                    <input type="hidden" name="action" value="add"/>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Change club leader email</h3>
                            </div>
                            <div class="card-body">
                                <form action="admin-club" method="POST" class="needs-validation" novalidate>
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
                                        <label for="userEmail" class="font-weight-bold">Email:</label>
                                        <input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Enter the new email" required/>
                                        <div class="valid-feedback">Valid</div>
                                        <div class="invalid-feedback">Please fill out this field</div>
                                    </div>
                                    <input type="hidden" name="action" value="change" />
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h3 class="m-0 font-weight-bold text-primary text-center">Club list</h3>
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
        <script>
            <c:if test="${param.add eq 'success'}">
            Swal.fire(
                    'Success!',
                    'Add new club successfully!',
                    'success'
                    );
            </c:if>
            <c:if test="${param.change eq 'success'}">
            Swal.fire(
                    'Success!',
                    'Change club leader email successfully!',
                    'success'
                    );
            </c:if>
            <c:if test="${not empty requestScope.error}">
            Swal.fire(
                    'Success!',
                    '${error}',
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
        <script src="./asset/js/demo/datatables-demo.js"></script>
    </body>
</html>
