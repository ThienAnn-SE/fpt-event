<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Admin dashboard</title>

        <!-- Custom fonts for this template-->
        <link href="./asset/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

        <!-- Custom styles for this template-->
        <link href="./asset/css/sb-admin-2.min.css" rel="stylesheet">
    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <jsp:include page="includes/admin-sidebar.jsp">
                <jsp:param name="active" value="dashboard"/>
            </jsp:include>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <jsp:include page="includes/admin-topbar.jsp">
                        <jsp:param name="title" value="Dashbroad"/>
                        <jsp:param name="avatar" value="${sessionScope.avatar}"/>
                    </jsp:include>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <!-- Content Row -->
                        <div class="row">
                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Visitors (Monthly)</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${numOf30DayVisitors}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-success shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                    Visitors (Total)</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${numOfTotalVisitors}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fa fa-trophy fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-danger shadow h-100 py-2">
                                    <div class="card-body" onclick="location.href='admin-request';" style="cursor: pointer;">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                    Pending Requests</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${numOfUnreslovedRequest}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fa fa-exclamation-circle fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pending Requests Card Example -->
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body" onclick="location.href='admin-form';" style="cursor: pointer;">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                    Pending Reports</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${numOfUnprocessedReport}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-comments fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Content Row -->

                        <div class="row">

                            <!-- Area Chart -->
                            <div class="col-xl-8 col-lg-7">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Visitors overview</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div class="chart-area">
                                            <canvas id="myChart" style="width:100%;"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">
                                            <a href="admin-user">User status ratio</a>
                                        </h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div class="chart-pie pt-4 pb-2">
                                            <canvas id="myPieChart"></canvas>
                                        </div>
                                        <div class="mt-4 text-center small">
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-primary"></i> New
                                            </span>
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-success"></i> Active
                                            </span>
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-danger"></i> Inactive
                                            </span>
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-warning"></i> Ban temporary
                                            </span>
                                        </div>
                                    </div>
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

        <!-- Bootstrap core JavaScript-->
        <script src="./asset/vendor/jquery/jquery.min.js"></script>
        <script src="./asset/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="./asset/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="./asset/js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="./asset/vendor/chart.js/Chart.min.js"></script>

        <!-- Page level custom scripts -->
        <script>
            // table chart
            Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
            Chart.defaults.global.defaultFontColor = '#858796';
            function number_format(number, decimals, dec_point, thousands_sep) {
            // *     example: number_format(1234.56, 2, ',', ' ');
            // *     return: '1 234,56'
            number = (number + '').replace(',', '').replace(' ', '');
            var n = !isFinite( + number) ? 0 : + number,
                    prec = !isFinite( + decimals) ? 0 : Math.abs(decimals),
                    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
                    s = '',
                    toFixedFix = function (n, prec) {
                    var k = Math.pow(10, prec);
                    return '' + Math.round(n * k) / k;
                    };
            // Fix for IE parseFloat(0.55).toFixed(0) = 0;
            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
            if (s[0].length > 3) {
            s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
            }
            if ((s[1] || '').length < prec) {
            s[1] = s[1] || '';
            s[1] += new Array(prec - s[1].length + 1).join('0');
            }
            return s.join(dec);
            }

            var ctx = document.getElementById("myChart");
            var value = [
            <c:forEach var="item" items="${visitorList}">
                ${item},
            </c:forEach>
            ];
            var array = [],
                    dayShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                    monthsShort = [
                            "Jan",
                            "Feb",
                            "Mar",
                            "Apr",
                            "May",
                            "Jun",
                            "Jul",
                            "Aug",
                            "Sep",
                            "Oct",
                            "Nov",
                            "Dec",
                    ];
            function getDates() {
            var dateArray = [];
            var currentDate = new Date();
            for (var i = 0; i < 30; i++) {
            var temp = [
                    dayShort[currentDate.getDay()],
                    monthsShort[currentDate.getMonth()] + " " + currentDate.getDate(),
                    currentDate.getFullYear(),
            ];
            dateArray.push(temp);
            currentDate.setDate(currentDate.getDate() - 1);
            }
            return dateArray;
            }

            array = getDates();
            var myLineChart = new Chart(ctx, {
            type: 'line',
                    data: {
                    labels: array.reverse(),
                            datasets: [{
                            label: "Visitors",
                                    lineTension: 0.3,
                                    backgroundColor: "rgba(78, 115, 223, 0.05)",
                                    borderColor: "rgba(78, 115, 223, 1)",
                                    pointRadius: 3,
                                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                                    pointBorderColor: "rgba(78, 115, 223, 1)",
                                    pointHoverRadius: 3,
                                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                                    pointHitRadius: 10,
                                    pointBorderWidth: 2,
                                    //data here
                                    data: value.reverse(),
                            }],
                    },
                    options: {
                    maintainAspectRatio: false,
                            layout: {
                            padding: {
                            left: 10,
                                    right: 25,
                                    top: 25,
                                    bottom: 0
                            }
                            },
                            scales: {
                            xAxes: [{
                            time: {
                            unit: 'date'
                            },
                                    gridLines: {
                                    display: false,
                                            drawBorder: false
                                    },
                                    ticks: {
                                    maxTicksLimit: 7
                                    }
                            }],
                                    yAxes: [{
                                    ticks: {
                                    maxTicksLimit: 5,
                                            padding: 10,
                                            // Include a dollar sign in the ticks
                                            callback: function (value, index, values) {
                                            return number_format(value);
                                            }
                                    },
                                            gridLines: {
                                            color: "rgb(234, 236, 244)",
                                                    zeroLineColor: "rgb(234, 236, 244)",
                                                    drawBorder: false,
                                                    borderDash: [2],
                                                    zeroLineBorderDash: [2]
                                            }
                                    }],
                            },
                            legend: {
                            display: false
                            },
                            tooltips: {
                            backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    titleMarginBottom: 10,
                                    titleFontColor: '#6e707e',
                                    titleFontSize: 14,
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    xPadding: 15,
                                    yPadding: 15,
                                    displayColors: false,
                                    intersect: false,
                                    mode: 'index',
                                    caretPadding: 10,
                                    callbacks: {
                                    label: function (tooltipItem, chart) {
                                    var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                                    return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + ' visitors';
                                    }
                                    }
                            }
                    }
            });
        </script>
        <script>
            //pie chart
            Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
            Chart.defaults.global.defaultFontColor = '#858796';
            var ctx = document.getElementById("myPieChart");
            var myPieChart = new Chart(ctx, {
            type: 'doughnut',
                    data: {
                    labels: ["New", "Inactive", "Ban temporary", "Active"],
                            datasets: [{
                            //data here
                            data: [
            <c:forEach var="ratio" items="${userStatusRatioList}">
                ${ratio},
            </c:forEach>
                            ],
                                    backgroundColor: ['#4e73df', '#cd3333', '#eaa55d', '#1cc88a'],
                                    hoverBackgroundColor: ['#2e59d9', '#b82d2d', '#e89c4b', '#17a673'],
                                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                            }],
                    },
                    options: {
                    maintainAspectRatio: false,
                            tooltips: {
                            backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    xPadding: 15,
                                    yPadding: 15,
                                    displayColors: false,
                                    caretPadding: 10,
                            },
                            legend: {
                            display: false
                            },
                            cutoutPercentage: 80,
                    },
            });
        </script>

    </body>

</html>