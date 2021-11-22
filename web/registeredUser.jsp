<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Club Leader</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
            integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            type="text/css"
            href="https://cdn.datatables.net/v/bs5/dt-1.11.3/datatables.min.css"
            />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="./asset/css/style.css" />

    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>
            <div class="leader">
                <div class="text-center">
                    <h1>${event.eventName}</h1>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card card-custom">
                            <div class="card-header">
                            </div>
                            <div class="card-body">
                                <div class="table-header">
                                    <a href="EventManagementController" class="btn">
                                        <i class="fa fa-arrow-left" aria-hidden="true"></i>
                                        <span class="btn-text">Back</span>
                                    </a>
                                </div>
                                <div class="table-body">
                                    <h3 class="text-center">Event registration</h3>
                                    <div class="table table-responsive">
                                        <table
                                            id="feedback-table"
                                            class="table table-bordered table-hover dtr-inline"
                                            >
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Name
                                                    </th>
                                                    <th>
                                                        Email
                                                    </th>
                                                    <th>
                                                        Phone number
                                                    </th>
                                                    <th>
                                                        Action
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${registeredUserList}">
                                                    <tr>
                                                        <td>
                                                            ${user.name}
                                                        </td>
                                                        <td>
                                                            ${user.email}
                                                        </td>
                                                        <td>
                                                            ${user.phoneNumber}
                                                        </td>
                                                        <td>
                                                            <div class="form-btn">
                                                                <button type="button" id="report" data-id="${user.email}" data-toggle="modal" data-target="#confirm-report" onclick="rely_click($(this).data('id'))">Report</button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="confirm-report" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="user-ban" method="POST" id="update-form">
                        <div class="modal-header">
                            <h3 class="m-2 font-weight-bold mx-auto">User report confirmation</h3>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to report user <strong id="email-text"></strong>?</p>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="btAction" value="report"/>
                            <input type="hidden" name="eventID" id="eventID" value="${event.eventID}"/>
                            <input type="hidden" name="email" id="email" value="" />
                            <div class="form-btn">
                                <button type="button" id="cancel" data-dismiss="modal">Cancel</button>
                                <button type="submit" id="confirm">Confirm</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="./asset/js/main.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
            crossorigin="anonymous"
        ></script>

        <script type="text/javascript">
                                                                    function rely_click(clicked_id)
                                                                    {
                                                                        $('#email-text').text(clicked_id);
                                                                        $('#email').val(clicked_id);
                                                                    }
                                                                    ;
        </script>

        <script>
            $(document).ready(function () {
                $("#feedback-table").DataTable();
            });
        </script>


    </body>
</html>
