<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upcoming Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="studentSidebar.jsp"/>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <h2 class="mb-4">Available Events</h2>
            
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Date & Time</th>
                                <th>Location</th>
                                <th>Fee (RM)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty upcomingEvents}">
                                <tr>
                                    <td colspan="6" class="text-center">No upcoming events available.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="event" items="${upcomingEvents}">
                                <tr>
                                    <td>${event.eventTitle}</td>
                                    <td>${event.eventDescription}</td>
                                    <td>
                                        <fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy"/>
                                        &nbsp;${event.eventTime}
                                    </td>
                                    <td>${event.eventLocation}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${event.registrationFee != null && event.registrationFee > 0}">
                                                RM ${event.registrationFee}
                                            </c:when>
                                            <c:otherwise>
                                                Free
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/student" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="registerEvent"/>
                                            <input type="hidden" name="eventId" value="${event.eventID}"/>
                                            <button type="submit" class="btn btn-sm btn-primary">Join</button>
                                        </form>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>