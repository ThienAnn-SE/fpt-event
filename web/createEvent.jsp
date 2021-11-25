<!DOCTYPE html>
<html lang="en">
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core"
                  prefix="c"%>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Create Event</title>
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
    </head>
    <body>
        <jsp:include page="./includes/header.jsp"></jsp:include>

            <div class="create-area">
                <div class="container">
                    <form action="event-add" method="POST" enctype='multipart/form-data' accept-charset="utf-8" id="form">
                        <div class="pb-3">
                            <h1 class="text-center font-weight-bold">CREATE EVENT</h1>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="img-upload">
                                    <input
                                        id="upload"
                                        type="file"
                                        accept=".png, .jpeg, .jpg"
                                        name="imageURL"
                                        hidden
                                        />
                                    <label for="upload">
                                        <i class="fas fa-cloud-upload"></i>
                                    </label>
                                    <p>No image chosen.</p>
                                <c:if test="${not empty imageURLError}">
                                    <p class="text text-danger">${imageURLError}</p>
                                </c:if>
                                <div class="img"></div>
                                <div class="cancel-upload"><i class="fas fa-times"></i></div>
                                <div class="file-name">File Name Here</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="create-detail">
                                <div class="card card-custom">
                                    <div class="card-header">
                                        <h1 class="card-title p-3">Event content</h1>
                                    </div>
                                    <c:if test="${not empty contentError}">
                                        <p class="text text-danger px-3">*${contentError}</p>
                                    </c:if>
                                    <div class="card-body">
                                        <textarea id="tinymce" name="content"></textarea>
                                        <p class="font-weight-lighter">Tip: you can click the "<i class="fa fa-eye" aria-hidden="true"></i>" icon to preview the content!!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="event-info-content">
                                <h1>Event Info</h1>
                                <ul>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="text" id="name" name="eventName"/>
                                            <label for="name">Event Name</label>
                                            <c:if test="${not empty eventNameError}">
                                                <p class="text text-danger">*${eventNameError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="datetime-local" id="start" name="startDate" value="2021-01-01T12:00:00"/>
                                            <label for="start">Start Date</label>
                                            <c:if test="${not empty startDateError}">
                                                <p class="text text-danger">*${startDateError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="datetime-local" id="end" name="endDate" value="2021-01-01T12:00:00"/>
                                            <label for="end">End Date</label>
                                            <c:if test="${not empty endDateError}">
                                                <p class="text text-danger">*${endDateError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="date" id="registration" name="registerEndDate">
                                            <label for="registration">Registration End Date</label>
                                            <c:if test="${not empty registerEndDateError}">
                                                <p class="text text-danger">*${registerEndDateError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="number" id="slot" name="slot"/>
                                            <label for="slot">Number of slot</label>
                                            <c:if test="${not empty slotError}">
                                                <p class="text text-danger">*${slotError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="text-field">
                                            <input autocomplete="off" type="number" id="fee" name="ticketFee"/>
                                            <label for="fee">Fee</label>
                                            <c:if test="${not empty ticketFeeError}">
                                                <p class="text text-danger">${ticketFeeError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                            <label for="location">Location</label>
                                            <select class="form-control" id="location" name="locationID">
                                                <option disabled hidden selected>Choose the location</option>
                                                <c:forEach var="location" items="${locationList}">
                                                    <option value="${location.locationID}">${location.locationName} (Max slot: ${location.locationCapacity})</option>
                                                </c:forEach>
                                            </select>
                                            <c:if test="${not empty locationIDError}">
                                                <p class="text text-danger">*${locationIDError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                            <label for="category">Category</label>
                                            <select class="form-control" id="category" name="categoryID">
                                                <option disabled hidden selected>Choose the event category</option>
                                                <c:forEach var="category" items="${categoryList}">
                                                    <option value="${category.categoryID}">${category.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                            <c:if test="${not empty categoryIDError}">
                                                <p class="text text-danger">*${categoryIDError}</p>
                                            </c:if>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="event-submit">
                                            <input type="hidden" name="clubID" value="${clubID}"/>
                                            <input class="btn btn-new" type="submit" value="Post Event" />
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div id="data"></div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>

            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ"
                crossorigin="anonymous"
            ></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script src="https://cdn.tiny.cloud/1/hquj2y89l4x5vq47fqu28inr9lvl3vk9mytjhor0j85uu14t/tinymce/5/tinymce.min.js"></script>
            <script src="./asset/js/main.js"></script>
        <c:if test="${requestScope.result eq 'fail'}">
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                Swal.fire(
                        'Failed!',
                        'Add new event failed!',
                        'error'
                        );
            </script>
        </c:if>
        <script>
            var upload = document.getElementById("upload");
            var fileName = document.querySelector(".img-upload .file-name");
            var cancelUpload = document.querySelector(".img-upload .cancel-upload");
            var imgContainer = document.querySelector(".img-upload .img");
            upload.addEventListener("change", function preview() {
                var file = this.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function () {
                        var result = reader.result;
                        var img = document.createElement("img");
                        img.setAttribute("src", result);
                        imgContainer.appendChild(img);
                        imgContainer.style.zIndex = "2";
                        imgContainer.parentElement.classList.add("active");
                    };
                    reader.readAsDataURL(file);
                }
                if (this.value) {
                    fileName.textContent = file.name;
                }
            });
            cancelUpload.addEventListener("click", () => {
                imgContainer.style.zIndex = "1";
                imgContainer.removeChild(imgContainer.firstChild);
                imgContainer.parentElement.classList.remove("active");
            });

            tinymce.init({
                selector: "textarea#tinymce",
                height: 680,
                menubar: false,
                statusbar: false,
                plugins: [
                    "advlist autolink lists link imagetools image charmap print preview anchor",
                    "searchreplace visualblocks code fullscreen",
                    "insertdatetime media table paste code wordcount",
                ],
                toolbar: [
                    "styleselect fontselect fontsizeselect",
                    "undo redo | bold italic | alignleft aligncenter " +
                            "alignright alignjustify | link media | bullist numlist | outdent indent preview"],
            });

            window.addEventListener("load", function () {
                const dropdownItems = document.querySelectorAll(
                        "#category .dropdown-item"
                        );
                const dropdownSelect = document.querySelector(
                        "#category .dropdown-select"
                        );
                const dropdownSelectText = document.querySelector(
                        "#category .dropdown-selected"
                        );
                const dropdownList = document.querySelector(
                        "#category .dropdown-list"
                        );
                const dropdownCaret = document.querySelector(
                        "#category .dropdown-caret"
                        );

                dropdownSelect.addEventListener("click", function () {
                    dropdownList.classList.toggle("show");
                    dropdownCaret.classList.toggle("fa-angle-up");
                });

                function handleSelectDropdown(e) {
                    const {value} = e.target.dataset;
                    dropdownSelectText.textContent = value;
                    dropdownList.classList.remove("show");
                    dropdownCaret.classList.remove("fa-angle-up");
                }

                dropdownItems.forEach((el) =>
                    el.addEventListener("click", handleSelectDropdown)
                );
            });
            // $(document).ready(function() {
            //   $("#form").submit(function(e){
            //     var content = tinymce.get("tinymce").getContent();
            //     $("#data").html(content);
            //     return false;
            //   });
            // });
        </script>
    </body>
</html>
