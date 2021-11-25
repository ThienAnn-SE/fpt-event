<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Feedback</title>
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
                                            id="attended-table"
                                            class="table table-bordered table-hover dtr-inline"
                                            >
                                            <thead>
                                                <tr>
                                                    <th>
                                                        No.
                                                    </th>
                                                    <th>
                                                        From
                                                    </th>
                                                    <th>
                                                        Feedback
                                                    </th>
                                                    <th>
                                                        Rating
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${feedbackList}" varStatus="counter">
                                                    <tr>
                                                        <td>
                                                            ${counter.count}
                                                        </td>
                                                        <td>
                                                            ${item.email}
                                                        </td>
                                                        <td>
                                                            ${item.feedback}
                                                        </td>
                                                        <td>
                                                            ${item.vote}<span><i class="fa fa-star" aria-hidden="true"></i></span>
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

        <script src="./asset/js/main.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
            crossorigin="anonymous"
        ></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
            type="text/javascript"
            src="https://cdn.datatables.net/v/bs5/dt-1.11.3/datatables.min.js"
        ></script>
        <script>
            $(document).ready(function () {
                $('#attended-table').DataTable();
            });
        </script>



    </body>
</html>
