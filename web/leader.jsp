<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Club Leader</title>
        <link rel="stylesheet" href="./asset/css/style.css" />
        <link rel="stylesheet" href="./asset/css/clubLeader.css" />
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
            <div class="container-fluid">
                <div class="row">
                    <div class="left col-md-3">
                        <div class="img">
                            <img src="./asset/img/trungthu.png" class="avatar" />
                        </div>
                        <div class="nav">
                            <a class="nav-link event active" href="clubLeader.html">manage events</a>
                        </div>
                    </div>
                    <div class="right col-md-9">
                        <div class="right-title">
                            <div class="row">
                                <div class="col-md-6">
                                    <button>
                                        <a
                                            href="#addEvent"
                                            data-bs-toggle="modal"
                                            data-bs-target="#addEvent"
                                            >
                                            <i class="fal fa-plus-circle"></i>
                                            <span>Add Event</span>
                                        </a>
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <div class="search-box">
                                        <i class="far fa-search"></i>
                                        <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Search..."
                                            />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <div class="table-wrapper">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Create Date</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Location</th>
                                            <th>Category</th>
                                            <th>Slot</th>
                                            <th>Fee</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="event" items="${eventList}">
                                        <tr>
                                            <td><span>${event.eventName}</span></td>
                                            <th>${event.createDate}</th>
                                            <th>${event.startDate}</th>
                                            <th>${event.endDate}</th>
                                                <c:forEach var="location" items="${locationList}">
                                                    <c:if test="${event.locationID eq location.locationID}">
                                                    <th>${location.locationName}</th>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach var="catetory" items="${catetoryList}">
                                                    <c:if test="${event.catetoryID eq catetory.catetoryID}">
                                                    <th>${catetory.catetoryName}</th>
                                                    </c:if>
                                                </c:forEach>
                                                <c:set  var="registerNum" value="${0}"/>
                                                <c:forEach var="register" items="${registerNumList}">
                                                    <c:if test="${event.eventID eq register.eventID}">
                                                        <c:set var="registerNum" value="${register.registerNum}"/>
                                                    </c:if>
                                                </c:forEach>
                                            <th>${registerNum}/${event.slot}</th>
                                            <th>${event.fee}</th>
                                            <th>
                                                <c:choose>
                                                    <c:when test="${event.statusID eq 500}">
                                                        <div class="status active">not-start</div>                                                      
                                                    </c:when>
                                                    <c:when test="${event.statusID eq 550}">
                                                        <div class="status ongoing">on-going</div>
                                                    </c:when>
                                                    <c:when test="${event.statusID eq 570}">
                                                        <div class="status closed">closed</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="status cancel">cancel</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </th>
                                            <td>
                                                <a href="#" class="view" data-toggle="tooltip" title="View event detail" data-placement="top">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="#" class="users" data-toggle="tooltip" title="View registered user" data-placement="top">
                                                    <i class="fas fa-users"></i>
                                                </a>
                                                <a
                                                    href="#edit"
                                                    class="edit"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#edit"
                                                    data-toggle="tooltip" title="Edit event" data-placement="top"
                                                    >
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${event.statusID ne 400}">
                                                    <a href="#" class="delete" data-toggle="tooltip" title="Cancel event" data-placement="top"><i class="fas fa-trash-alt"></i></a>
                                                    </c:if>                                   
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="clearfix">
                                <div class="hint-text">
                                    Showing <b>${eventNum}</b> out of <b>${eventNumList}</b> entries
                                </div>
                                <ul class="pagination">
                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <c:choose>
                                            <c:when test="${i eq page}">
                                                <li class="page-item active"><a class="page-link" href="EventManagementController?page=${i}">${i}</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                <li class="page-item"><a class="page-link" href="EventManagementController?page=${i}">${i}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="addEvent" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form>
                                <div class="modal-header">
                                    <h4 class="modal-title">Add Event</h4>
                                    <i
                                        class="fal fa-times close"
                                        data-bs-dismiss="modal"
                                        aria-hidden="true"
                                        ></i>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>Start Date</label>
                                        <input type="date" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>End Date</label>
                                        <input type="date" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea class="form-control"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Category</label>
                                        <select class="form-control" name="catetory">
                                            <c:forEach var="catetory" items="${catetoryList}">
                                                <option value="${catetory.catetoryID}">${catetory.catetoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Location</label>
                                        <select class="form-control" name="location">
                                            <c:forEach var="location" items="${locationList}">
                                                <option value="${location.locationID}">${location.locationName} (available slot: ${location.locationCapacity})</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>fee</label>
                                        <input type="text" class="form-control" placeholder="ex: 40000"/>
                                    </div>
                                    <div class="img form-group">
                                        <input
                                            id="addImg"
                                            type="file"
                                            class="form-control"
                                            accept=".png, .jpeg, .jpg"
                                            multiple
                                            />
                                        <label for="addImg"
                                               ><i class="fas fa-upload"></i> Choose Images</label
                                        >
                                        <p class="num-of-imgs">No File Chosen</p>
                                        <div class="imgs"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input
                                        type="button"
                                        class="btn btn-default"
                                        data-bs-dismiss="modal"
                                        value="Cancel"
                                        />
                                    <input type="submit" class="btn btn-info" value="Add" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div id="edit" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form>
                                <div class="modal-header">
                                    <h4 class="modal-title">Edit Event</h4>
                                    <i
                                        class="fal fa-times close"
                                        data-bs-dismiss="modal"
                                        aria-hidden="true"
                                        ></i>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>Start Date</label>
                                        <input type="date" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>End Date</label>
                                        <input type="date" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea class="form-control"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Category</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>Location</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>fee</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                    <div class="img form-group">
                                        <input
                                            id="EditImg"
                                            type="file"
                                            class="form-control"
                                            accept=".png, .jpeg, .jpg"
                                            multiple
                                            />
                                        <label for="EditImg"
                                               ><i class="fas fa-upload"></i> Choose Images</label
                                        >
                                        <p class="num-of-imgs">No File Chosen</p>
                                        <div class="imgs"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input
                                        type="button"
                                        class="btn btn-default"
                                        data-bs-dismiss="modal"
                                        value="Cancel"
                                        />
                                    <input type="submit" class="btn btn-info" value="Save" />
                                </div>
                            </form>
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
        <script>
            var fileInputs = document.querySelectorAll('input[type="file"]');

            fileInputs.forEach((item) => {
                item.addEventListener("change", function preview() {
                    var imgContainer = item.parentElement;
                    var imgs = imgContainer.children[3];
                    imgs.innerHTML = "";
                    imgContainer.children[2].textContent = `\${item.files.length} Images Selected.`;
                    if (item.files.length > 3) {
                        imgContainer.children[2].textContent += " You can upload maximum 3 images";
                        // imgContainer.parentElement.querySelector('input[type="submit"]').disabled = true;
                    } else {
                        for (i of item.files) {
                            let reader = new FileReader();
                            let figure = document.createElement("figure");
                            let figCap = document.createElement("figcaption");
                            figCap.innerText = i.name;
                            figure.appendChild(figCap);
                            reader.addEventListener("load", (e) => {
                                let img = document.createElement("img");
                                img.setAttribute("src", e.target.result);
                                figure.insertBefore(img, figCap);
                            });
                            imgs.appendChild(figure);
                            reader.readAsDataURL(i);
                        }
                    }
                });
            });
        </script>
    </body>
</html>
