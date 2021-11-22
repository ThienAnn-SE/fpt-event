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

        <title>Ban request</title>

        <!-- Custom fonts for this template -->
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

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <jsp:include page="includes/admin-sidebar.jsp">
                <jsp:param name="active" value="report"/>
            </jsp:include>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="Comment report"/>
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
                        <!-- Page Body -->,
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6>  Request processing </h6>
                            </div>
                            <div class="card-body">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#comment">Comment report list</a>
                                    </li>
                                    <li>
                                        <a class="nav-link" data-toggle="tab" href="#user">Violated user</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div id="comment" class="container tab-pane active"><br/>
                                        <c:if test="${empty reportList}">
                                            <div>
                                                <h4 class="text-center">There are no request at the moment!!</h4>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty reportList}">
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                    <thead>
                                                        <tr>
                                                            <th>From</th>
                                                            <th>Reported comment</th>
                                                            <th>Send date</th>
                                                            <th>Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tfoot>
                                                        <tr>
                                                            <th>From</th>
                                                            <th>Reported comment</th>
                                                            <th>Send date</th>
                                                            <th>Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </tfoot>
                                                    <tbody>
                                                        <c:forEach var="report" items="${reportList}">
                                                            <tr>    
                                                                <td>
                                                                    <p>${report.userEmail}</p>
                                                                </td>
                                                                <td>
                                                                    <p>${report.reportedComment}</p>
                                                                </td>
                                                                <td>
                                                                    <p>${report.sendDate}</p>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${report.reportStatus eq 300}">
                                                                            <h5><span class="badge badge-primary p-2">Pending</span></h5>
                                                                        </c:when>
                                                                        <c:when test="${report.reportStatus eq 400}">
                                                                            <h5><span class="badge badge-secondary p-2">Cancel</span></h5>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <h5><span class="badge badge-danger p-2">Approved</span></h5>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:if test="${report.reportStatus eq 300}">
                                                                        <input type="button" name="btn" value="Process" onclick="clicked_btn($(this).data('email'), $(this).data('comment'), $(this).data('date'), $(this).data('id'))" id="submitBtn"  data-email="${report.userEmail}" data-date="${report.sendDate}" data-comment="${report.reportedComment}" data-id="${report.reportID}" data-toggle="modal" data-target="#confirm-submit" class="btn btn-outline-danger" />
                                                                    </c:if>
                                                                    <c:if test="${report.reportStatus ne 300}">
                                                                        <input type="button" name="btn" value="Done" id="submitBtn" class="btn btn-outline-primary" disabled="disabled"/>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>                                   
                                                </table>
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="modal fade" id="confirm-submit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <form action="admin-request" method="POST">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h2>Comment report</h2>
                                                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true"><strong>X</strong></span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Please check the information again before approving the report</p>
                                                        <!-- We display the details entered by the user here -->
                                                        <table class="table">
                                                            <tr>
                                                                <th>From:</th>
                                                                <td id="from"></td>
                                                            </tr>
                                                            <tr>
                                                                <th>Reported comment:</th>
                                                                <td id="cmt"></td>
                                                            </tr>
                                                            <tr>
                                                                <th>Send date:</th>
                                                                <td id="date"></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <input type="hidden" name="reportID" id="reportID_form" value=""/>
                                                    <div class="modal-footer">
                                                        <button type="submit" name="action" value="Cancel" class="btn btn-primary">Cancel</button>
                                                        <button type="submit" name="action" value="Approve" class="btn btn-danger danger">Approve</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div id="user" class="container tab-pane fade"><br/>
                                        <c:if test="${empty violatedUserList}">
                                            <h4 class="text-center">There are no violated user at the moment</h4>
                                        </c:if>
                                        <c:if test="${not empty violatedUserList}">
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                    <thead>
                                                        <tr>
                                                            <th>No.</th>
                                                            <th>User email</th>
                                                            <th>Times</th>
                                                        </tr>
                                                    </thead>
                                                    <tfoot>
                                                        <tr>
                                                            <th>No.</th>
                                                            <th>User email</th>
                                                            <th>Times</th>
                                                        </tr>
                                                    </tfoot>
                                                    <tbody>
                                                        <c:forEach var="user" items="${violatedUserList}" varStatus="counter">
                                                            <tr>]
                                                                <td>
                                                                    ${counter.count}
                                                                </td>
                                                                <td>
                                                                    ${user.userEmail}
                                                                </td>
                                                                <td>
                                                                    ${user.violationTimes}
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
        <script>
            <c:if test="${param.result eq 'success'}">
            Swal.fire(
                    'Success!',
                    'Your action have been done successfully!',
                    'success'
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

        <script>
            function clicked_btn(userEmail, reportedComment, date, id) {
                $('#from').text(userEmail);
                $('#cmt').text(reportedComment);
                $('#date').text(date);
                $('#reportID_form').val(id);
            }
            ;
        </script>
    </body>

</html>