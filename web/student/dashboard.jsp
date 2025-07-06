<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); }
        .stat-card { color: #fff; }
        .stat-card-blue { background: linear-gradient(45deg, #007bff, #0056b3); }
        .stat-card-green { background: linear-gradient(45deg, #28a745, #20c997); }
        .stat-card-purple { background: linear-gradient(45deg, #6f42c1, #483d8b); }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="studentSidebar.jsp"><jsp:param name="active" value="dashboard"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="mb-1">Dashboard</h2>
                    <p class="text-muted">Welcome back, ${sessionScope.userName}!</p>
                </div>
            </div>
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="success" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <div class="row g-4 mb-4">
                <div class="col-md-4"><div class="card stat-card stat-card-blue"><div class="card-body text-center p-4"><i class="fas fa-calendar-check fa-2x mb-2"></i><h3>${registeredEventsCount}</h3><p class="mb-0">Registered Events</p></div></div></div>
                <div class="col-md-4"><div class="card stat-card stat-card-green"><div class="card-body text-center p-4"><i class="fas fa-check-circle fa-2x mb-2"></i><h3>${completedEventsCount}</h3><p class="mb-0">Completed Events</p></div></div></div>
                <div class="col-md-4"><div class="card stat-card stat-card-purple"><div class="card-body text-center p-4"><i class="fas fa-award fa-2x mb-2"></i><h3>0</h3><p class="mb-0">Certificates</p></div></div></div>
            </div>
            <div class="card">
                <div class="card-header bg-white">
                    <h5><i class="fas fa-calendar-alt me-2"></i>Upcoming Events</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <c:if test="${empty upcomingEvents}"><p class="text-center p-3 text-muted">No upcoming events available.</p></c:if>
                        <c:forEach var="event" items="${upcomingEvents}">
                            <a href="student?action=viewEvent&eventId=${event.eventID}" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">${event.eventTitle}</h6>
                                    <small><fmt:formatDate value="${event.eventDate}" pattern="dd MMM, yyyy"/></small>
                                </div>
                                <p class="mb-1 text-muted">${event.eventLocation}</p>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <a href="${pageContext.request.contextPath}/student?action=events" class="btn btn-outline-primary">View All Events</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>