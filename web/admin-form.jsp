<!DOCTYPE html>
<html lang="vi-VN">
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core"
                  prefix="c"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Admin form</title>

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
                <jsp:param name="active" value="ban"/>
            </jsp:include>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="Ban user request"/>
                        <jsp:param name="avatar" value="${sessionScope.avatar}"/>
                    </jsp:include>
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
                            </div>
                            <div class="card-body">
                                <!-- start of form -->
                                <form action="admin-form" method="POST" id="banning_form" class="needs-validation" novalidate>
                                    <div class="form-group">
                                        <label for="email">User email:</label>
                                        <input type="text" class="form-control" id="email" placeholder="Enter user email" name="email" value="" required>
                                        <div class="valid-feedback">Valid.</div>
                                        <div class="invalid-feedback">Please fill out this field.</div>
                                        <c:if test="${not empty emailError}">
                                            <div class="text-danger">${emailError}</div>
                                        </c:if>
                                    </div>
                                    <div class="form-group">
                                        <label for="btAction">Select action:</label>
                                        <select class="form-control" id="btAction" name="btAction" required>
                                            <option value="" disabled selected hidden>---Choose action---</option>
                                            <option value="ban">Ban user temporary</option>
                                            <option value="invalid">Invalid user from system</option>
                                        </select>
                                        <div class="valid-feedback">Valid.</div>
                                        <div class="invalid-feedback">Please choose action to do.</div>
                                        <c:if test="${not empty btActionError}">
                                            <div class="text-danger">${btActionError}</div>
                                        </c:if>
                                    </div>
                                    <div class="form-group">
                                        <label for="reason">Reason:</label>
                                        <textarea class="form-control" rows="4" id="reason" name="reason" placeholder="Maximum 100 characters..." required></textarea>
                                        <div class="valid-feedback">Valid.</div>
                                        <div class="invalid-feedback">Please fill out this field.</div>
                                        <c:if test="${not empty reasonError}">
                                            <div class="text-danger">${reasonError}</div>
                                        </c:if>
                                    </div>
                                    <button type="submit" name="action" value="ban" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h5 class="m-0 font-weight-bold text-primary">Club banning request</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty banRequestList}">
                                    <h4 class="text-center">There are no request at the moment</h4>
                                </c:if>
                                <c:if test="${not empty banRequestList}">
                                    <div class="table table-responsive">
                                        <table class="table table-bordered" id="request-table" width="100%" cellspacing="0">
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
                                                <c:forEach var="request" items="${banRequestList}">
                                                    <tr>                                              
                                                        <td>
                                                            <c:forEach var="club" items="${clubList}">
                                                                <c:if test="${request.clubID eq club.clubID}">
                                                                    <p>${club.clubName}</p>
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <p>${request.userEmail}</p>
                                                        </td>
                                                        <td>
                                                            <p>${request.sendDate}</p>
                                                        </td>
                                                        <td>
                                                            <c:if test="${request.requestStatus}">
                                                                <button class="btn btn-success" disabled>
                                                                    Processed
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${not request.requestStatus}">
                                                                <button class="btn btn-warning" disabled>
                                                                    Pending
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <input type="button" name="btn" value="Ban" onclick="clicked($(this).data('email'))"  data-email="${request.userEmail}" class="btn btn-danger" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>                                   
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h5 class="m-0 font-weight-bold text-primary">Banned user list</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty userBanList}">
                                    <h4 class="text-center">There are no banned user at the moment</h4>
                                </c:if>
                                <c:if test="${not empty userBanList}">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="ban-table" width="100%" cellspacing="0">
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
                                                        <td>
                                                            <p>${user.email}</p>
                                                        </td>
                                                        <td>
                                                            <c:if test="${empty user.name}">
                                                                <p class="text-danger">missing</p>   
                                                            </c:if>
                                                            <p> ${user.name}</p>
                                                        </td>                                                   
                                                        <td>
                                                            <p>
                                                                <c:choose>
                                                                    <c:when test="${user.status eq 400}">
                                                                        <span class="badge badge-pill badge-danger p-2">Invalid</span>
                                                                    </c:when>
                                                                    <c:when test="${user.status eq 450}">
                                                                        <span class="badge badge-pill badge-warning p-2">Ban</span>
                                                                    </c:when>
                                                                </c:choose> 
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <button type="button" onclick="cancel_click($(this).data('email'), $(this).data('name'), $(this).data('status'))" data-email="${user.email}" data-name="${user.name}" data-status="${user.status}" data-toggle="modal" data-target="#confirm-submit" class="btn badge-danger">Cancel</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>                                   
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- container-fluid -->
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

        <div class="modal fade" id="confirm-submit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form action="admin-form" method="POST">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Comment report</h2>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true"><strong>X</strong></span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Please check the information again before approving the cancellation</p>
                            <!-- We display the details entered by the user here -->
                            <table class="table">
                                <tr>
                                    <th>User name:</th>
                                    <td id="user-name"></td>
                                </tr>
                                <tr>
                                    <th>Email:</th>
                                    <td id="user-email"></td>
                                </tr>
                                <tr>
                                    <th>Status:</th>
                                    <td id="user-status"></td>
                                </tr>
                            </table>
                        </div>
                        <input type="hidden" id="userEmail" name="userEmail" value=""/>
                        <div class="modal-footer">
                            <button type="button" data-dismiss="modal" class="btn btn-primary">Close</button>
                            <button type="submit" name="action" value="cancel" class="btn btn-danger danger">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
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
                $('#ban-table').DataTable();
                $('#request-table').DataTable();
            });
        </script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <c:if test="${param.report eq 'success'}">
            <script>
            Swal.fire(
                    'Success!',
                    'Ban user successfully!',
                    'success'
                    );
            </script>
        </c:if>
        <c:if test="${param.cancel eq 'success'}">
            <script>
                Swal.fire(
                        'Success!',
                        'Cancel banning successfully!',
                        'success'
                        );
            </script>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <script>
                Swal.fire(
                        'Error!',
                        '${requestScope.error}',
                        'error'
                        );
            </script>
        </c:if>
        <script>
            function clicked(email) {
                $('#email').val(email);
                document.getElementById('email').focus();
            }
            ;

            function cancel_click(email, name, status) {
                $('#user-email').text(email);
                $('#user-name').text(name);
                if (status === 400) {
                    $('#user-status').text("Invalid");
                } else {
                    $('#user-status').text("Ban");
                }
                $('#userEmail').val(email);
            }
            ;
        </script>
    </body>

</html>