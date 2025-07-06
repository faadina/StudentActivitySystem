<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="studentSidebar.jsp"><jsp:param name="active" value="events"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <c:if test="${not empty event}">
                <div class="card">
                    <div class="card-header">
                        <h2>${event.eventTitle}</h2>
                        <p class="text-muted">Organized by: ${organization.userName}</p>
                    </div>
                    <div class="card-body">
                        <p><strong>Description:</strong> ${event.eventDescription}</p>
                        <hr>
                        <h5>Details:</h5>
                        <ul>
                            <li><strong>Date & Time:</strong> <fmt:formatDate value="${event.eventDate}" pattern="EEEE, dd MMMM yyyy"/>, <fmt:formatDate value="${event.eventTime}" pattern="h:mm a"/></li>
                            <li><strong>Location:</strong> ${event.eventLocation}</li>
                            <li><strong>Category:</strong> ${event.eventCategory}</li>
                            <li><strong>Participants:</strong> ${event.registeredCount} / ${event.participantLimit > 0 ? event.participantLimit : 'Unlimited'}</li>
                            <li><strong>Registration Fee:</strong> RM <fmt:formatNumber value="${event.registrationFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></li>
                            <li><strong>Registration Deadline:</strong> <fmt:formatDate value="${event.registrationDeadline}" pattern="dd MMMM yyyy"/></li>
                        </ul>
                        <hr>
                        <c:choose>
                            <c:when test="${isRegistered}">
                                <div class="alert alert-success"><i class="fas fa-check-circle me-2"></i>You are already registered for this event.</div>
                                <a href="${pageContext.request.contextPath}/student?action=myEvents" class="btn btn-secondary">View My Registrations</a>
                            </c:when>
                            <c:when test="${isFull}">
                                <div class="alert alert-warning"><i class="fas fa-exclamation-circle me-2"></i>This event is full. Registration is closed.</div>
                                <button type="button" class="btn btn-success" disabled>Register for this Event</button>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/student" method="post" onsubmit="return confirm('Are you sure you want to register for this event?');">
                                    <input type="hidden" name="action" value="registerEvent">
                                    <input type="hidden" name="eventId" value="${event.eventID}">
                                    <button type="submit" class="btn btn-success"><i class="fas fa-edit me-2"></i>Register for this Event</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty event}">
                <div class="alert alert-danger">Event not found.</div>
            </c:if>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>