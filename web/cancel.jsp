<%-- 
    Document   : cancel
    Created on : Oct 29, 2021, 4:10:47 PM
    Author     : thien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cancel event</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Club Leader</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
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
    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>

            <div class="leader">
                <div class="text-center">
                    <h1>CANCEL EVENT</h1>
                </div>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card card-custom">
                                <div class="card-header">
                                    <div class="p-3">
                                        <a href="EventManagementController" class="btn">
                                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                                            <span class="btn-text">Back</span>
                                        </a>
                                    </div>
                                </div>
                                <div  class="card-body"> 
                                    <div class="text-center">
                                        <h3 class="p-3">${event.eventName}Event name here</h3>
                                </div>
                                <div class="col-lg-8 mx-auto">
                                    <form action="CancelEventController" accept-charset="utf-8">
                                        <p>
                                            Are you sure that you want to cancel this event?
                                        </p>
                                        <p>
                                            If yes, please fill out the reason bellow then click the "Confirm" button, there will be an email sent to the user who followed this event.
                                        </p>
                                        <p>
                                            Otherwise, click the "Back" button to go back to event management page.
                                        </p>
                                        <div class="form-group">
                                            <label for="reason">Reason:</label>
                                            <textarea class="form-control" rows="5" id="reason" name="reason"></textarea>
                                        </div>
                                        <div class="event-submit mt-5">
                                            <input type="hidden" name="clubID" value="${clubID}"/>
                                            <input class="btn" type="submit" value="Post Event" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                                            
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
                crossorigin="anonymous"
            ></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script src="https://cdn.tiny.cloud/1/hquj2y89l4x5vq47fqu28inr9lvl3vk9mytjhor0j85uu14t/tinymce/5/tinymce.min.js"></script>
            <script src="./asset/js/main.js"></script>
    </body>
</html>
