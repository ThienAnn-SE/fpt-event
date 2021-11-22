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
        <link rel="stylesheet" href="./asset/css/style.css" />

    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>
            <div class="leader">
                <div class="text-center">
                    <h1 class="p-3">EVENT FEEDBACK FORM</h1>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card card-custom">
                                <div class="card-header bg-success">
                                    <h3 class="text-white" id="feedback-name">${eventName}</h3>                           
                                </div>
                                <div class="card-body">
                                    <div class="rate">
                                        <form action="feedback" class="needs-validation" novalidate>
                                            <h2 class="text-center m-3">YOUR FEEDBACK</h2>
                                            <hr>
                                            <div class="form-group form-check" id="feedback">
                                                <p>We would like your feedback to improve our event.</p>
                                                <p>What is your opinion about our event?</p>
                                                <label class="form-check-label">                                             
                                                    <div class="star-icon">
                                                        <input type="radio" name="rate" id="rate-5" value="5" required/>
                                                        <label for="rate-5" class="fas fa-star"></label>
                                                        <input type="radio" name="rate" id="rate-4" value="4" required/>
                                                        <label for="rate-4" class="fas fa-star"></label>
                                                        <input type="radio" name="rate" id="rate-3" value="3" required/>
                                                        <label for="rate-3" class="fas fa-star"></label>
                                                        <input type="radio" name="rate" id="rate-2" value="2" required/>
                                                        <label for="rate-2" class="fas fa-star"></label>
                                                        <input type="radio" name="rate" id="rate-1" value="1" required/>
                                                        <label for="rate-1" class="fas fa-star"></label>
                                                        <div class="pt-5" id="title"></div>
                                                        <div class="valid-feedback pt-1">Valid.</div>
                                                        <div class="invalid-feedback pt-1">Rate a star to continue.</div>
                                                    </div>
                                                </label>
                                            </div>
                                            <hr>
                                            <div class="form-group">
                                                <p>Please leave your feedback below:</p>
                                                <textarea rows="5" placeholder="Add your feedback here" name="feedback" required></textarea>
                                                <div class="valid-feedback pt-1">Valid.</div>
                                                <div class="invalid-feedback pt-1">Leave a comment to continue.</div>
                                            </div>
                                            <div class="form-btn">
                                                <button class="mx-5" type="submit">Send</button>
                                                <a class="mx-3" href="profile">Cancel</a>
                                            </div>
                                            <input type="hidden" name="registerID" value="${registerID}"/>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>

        <script src="./asset/js/main.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
            crossorigin="anonymous"
        ></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
        <script>
            document.querySelectorAll("input[type=radio]").forEach((item) => {
                item.addEventListener("click", function () {
                    document.querySelector(".container form").style.display = "block";
                    if (document.getElementById("rate-5").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/256/4860/4860942.png" />';
                    else if (document.getElementById("rate-4").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://cdn-icons-png.flaticon.com/512/4860/4860844.png" />';
                    else if (document.getElementById("rate-3").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/512/4860/4860934.png" />';
                    else if (document.getElementById("rate-2").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/256/4860/4860859.png" />';
                    else if (document.getElementById("rate-1").checked)
                        document.querySelector("#title").innerHTML =
                                '<img src="https://image.flaticon.com/icons/png/512/4860/4860811.png" />';
                });
            });
        </script>
    </body>
</html>
