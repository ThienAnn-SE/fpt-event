<!DOCTYPE html>
<html lang="en">
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core"
                  prefix="c"%>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event Detail</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
            <div class="event-detail-area">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">
                            <article class="event-box">
                                <div class="event-box__img">
                                    <img src="${event.imageURL}" />
                            </div>
                            <div class="event-box__text">
                                <div class="price">
                                    <c:if test="${event.ticketFee eq 0}">
                                        <span>
                                            Free
                                        </span>
                                    </c:if>
                                    <c:if test="${event.ticketFee gt 0}">
                                        <span>
                                            ${event.ticketFee} VND
                                        </span>
                                    </c:if>
                                </div>
                                <h3 class="event-title">${event.eventName}</h3>
                                <div class="event-meta">
                                    <span>
                                        <i class="far fa-calendar-alt"></i> 
                                        ${event.startDate} - ${event.endDate}
                                    </span>
                                    <span><i class="fal fa-folder"></i> ${categoryName} </span>
                                    <span> <i class="fal fa-comments"></i> ${commentNum} Comments</span>
                                    <span><i class="far fa-users"></i> ${registerNum}/${event.slot}</span>
                                    <c:if test="${event.statusID eq 570 and avgVote ne 0}">
                                        <span>
                                            <c:forEach begin="1" end="5" step="1"  varStatus="counter">
                                                <c:choose>
                                                    <c:when test="${counter.count <= avgVote}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${(counter.count - 1) < avgVote and counter.count > avgVote}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-star-o"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            ${avgVote}
                                            (${numOfVote})
                                        </span>
                                    </c:if>          
                                </div>
                                <div class="event-text" >
                                    <c:out value="${event.content}" escapeXml="false"/>
                                    <c:if test="${sessionScope.role eq 1}">
                                        <c:if test="${isFollowed}">
                                            <button    
                                                <c:if test="${not empty param.focus}">
                                                    autofocus
                                                </c:if>>
                                                <a href="FollowEventController?btAction=unfollow&eventID=${event.eventID}" class="btn ">
                                                    <span class="btn-text" >followed</span>
                                                    <span class="btn-border"></span>

                                                </a>
                                            </button>
                                        </c:if>
                                        <c:if test="${not isFollowed}">
                                            <button
                                                <c:if test="${not empty param.focus}">
                                                    autofocus
                                                </c:if>>
                                                <a href="FollowEventController?btAction=follow&eventID=${event.eventID}" class="btn btn-follow">
                                                    <span class="btn-text">follow event</span>
                                                    <span><i class="fa fa-heart" aria-hidden="true"></i></span>
                                                </a>
                                            </button>
                                        </c:if>
                                        <c:if test="${event.statusID ne 570}">
                                            <a href="RegisterEventController?eventID=${event.eventID}" class="btn">
                                                <span class="btn-text">book ticket</span>
                                                <span class="btn-border"></span>
                                            </a>  
                                        </c:if> 
                                    </c:if>
                                </div>
                            </div>
                            <hr>
                            <div class="event-comments">
                                <div class="comment-title">
                                    <h2>${commentNum} Comments</h2>
                                </div>
                                <div class="latest-comments">
                                    <ul>
                                        <c:forEach var="comment" items="${commentList}">
                                            <li>
                                                <div class="comment-box">
                                                    <div class="comment-avatar">
                                                        <img src="${comment.avatar}" onerror="this.onerror=null;this.src='./asset/img/avatar.png';"/>
                                                    </div>
                                                    <div class="comment-text">
                                                        <div class="avatar-name">
                                                            <h5 class="comment">${comment.email}</h5>
                                                            <span>${comment.postDate}</span>
                                                            <c:if test="${not empty sessionScope.email and (comment.email ne sessionScope.email)}">
                                                                <a href="#" data-href="comment?commentID=${comment.commentID}&eventID=${event.eventID}" class="comment-reply-link" data-target="#report"  data-toggle="modal">
                                                                    <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                                                                </a>        
                                                            </c:if>
                                                        </div>
                                                        <p>${comment.comment}</p>
                                                    </div>                                       
                                                </div>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${empty commentList}">
                                            <p>There are no comment yet, please be the first one!!</p>
                                        </c:if>
                                    </ul>
                                </div>

                                <div class="modal fade" id="report" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header m-1">
                                                <h3 class="m-1">Report this comment</h3>
                                            </div>
                                            <div class="modal-body m-3">
                                                Are you sure you want to report this comment?
                                            </div>
                                            <div class="modal-footer m-1">
                                                <a class="mx-3" data-dismiss="modal" id="cancel">
                                                    <span class="btn-text">
                                                        Cancel
                                                    </span>
                                                </a>
                                                <a class="btn-ok">
                                                    <span class="mx-3 btn-text text-danger">
                                                        Report
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="comment-form">
                                    <c:if test="${empty sessionScope.email}">
                                        Please log in to comment!!
                                    </c:if>
                                    <c:if test="${not empty sessionScope.email and sessionScope.role ne 4 and sessionScope.role ne 5}">
                                        <div class="comment-form-container">
                                            <h3 class="form-title">leave a comment</h3>
                                            <form action="comment" class="row" method="POST" enctype='multipart/form-data' accept-charset="utf-8">
                                                <div class="col-lg-12">
                                                    <div class="comment-message">
                                                        <label>Your Comments *</label>
                                                        <textarea id="comment" class="form-control" name="comment"
                                                                  <c:if test="${param.cmt eq 'success'}">
                                                                      autofocus
                                                                  </c:if>></textarea>
                                                    </div>
                                                </div>
                                                <div class="col-lg-8">
                                                    <p>You are signing in as <strong>${sessionScope.email}</strong></p>
                                                </div>
                                                <div class="col-lg-4">
                                                    <input type="hidden" name="eventID" value="${event.eventID}"/>
                                                    <p class="comment-submit">
                                                        <input class="btn" type="submit" value="Post Comment"/>
                                                    </p>
                                                </div>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </article>
                    </div>
                    <div class="col-lg-4">
                        <div class="event-sidebar">
                            <div class="widget">
                                <div class="widget-title">
                                    <h3>Recent Events</h3>
                                </div>
                                <ul class="recent-events">
                                    <c:forEach var="event" items="${recentEventList}">
                                        <c:if test="${event.eventID ne requestScope.event.eventID}">
                                            <li>
                                                <div class="widget-events-image">
                                                    <a href="ViewEventController?eventID=${event.eventID}"><img src="${event.imageURL}" /></a>
                                                </div>
                                                <div class="widget-events-body">
                                                    <h6><a href="ViewEventController?eventID=${event.eventID}">${event.eventName}</a></h6>
                                                    <div class="widget-events-meta">${event.startDate}</div>
                                                </div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="./includes/footer.jsp"></jsp:include>
            <script src="./asset/js/main.js"></script>

            <script>
                elements = document.getElementsByClassName('comment');
                for (var i = elements.length; i--; ) {
                    var email = elements[i].innerHTML;
                    if (email.includes('@fe.edu.vn') === true) {
                        elements[i].style.color = "red";
                        elements[i].innerHTML += '<span class="badge badge-pill badge-danger">  &#124; Mentor</span>';
                    }
                }

                $('#report').on('show.bs.modal', function (e) {
                    $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
                });
                $('#cancel').css('cursor', 'pointer');
            </script>
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
                crossorigin="anonymous"
            ></script>
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <c:if test="${param.report eq 'success'}">
            <script>
                Swal.fire(
                        'Success!',
                        'Your report this comment successfully!',
                        'success'
                        );
            </script>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <script>
                Swal.fire(
                        'Failed!',
                        '${requestScope.error}',
                        'error'
                        );
            </script>
        </c:if>
    </body>
</html>
