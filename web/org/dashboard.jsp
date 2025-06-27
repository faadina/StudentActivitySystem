<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organization Dashboard - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .stat-card-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }
        .stat-card-warning {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            color: white;
        }
        .stat-card-info {
            background: linear-gradient(135deg, #17a2b8 0%, #007bff 100%);
            color: white;
        }
        .event-card {
            border-left: 4px solid #667eea;
        }
        .navbar-brand {
            font-weight: bold;
            color: #667eea !important;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="organizationSidebar.jsp" />
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
                <div class="container-fluid">
                    <h5 class="mb-0">
                        <i class="fas fa-tachometer-alt me-2 text-primary"></i>
                        Organization Dashboard
                    </h5>
                    <div class="navbar-nav ms-auto">
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" 
                               id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-2"></i>
                                ${sessionScope.userName}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/organization?action=profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="?action=logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Dashboard Content -->
            <div class="container-fluid">
                <!-- Statistics Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-calendar-check fa-2x mb-3"></i>
                                <h3 class="mb-1">${activeEvents}</h3>
                                <p class="mb-0">Active Events</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card-warning">
                            <div class="card-body text-center">
                                <i class="fas fa-clock fa-2x mb-3"></i>
                                <h3 class="mb-1">${pendingEvents}</h3>
                                <p class="mb-0">Pending Approval</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card-success">
                            <div class="card-body text-center">
                                <i class="fas fa-users fa-2x mb-3"></i>
                                <h3 class="mb-1">${totalParticipants}</h3>
                                <p class="mb-0">Total Participants</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card-info">
                            <div class="card-body text-center">
                                <i class="fas fa-chart-line fa-2x mb-3"></i>
                                <h3 class="mb-1">4.8</h3>
                                <p class="mb-0">Avg Rating</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Notifications Replacing Quick Actions -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h6 class="mb-0"><i class="fas fa-bell me-2"></i>Notifications</h6>
                            </div>
                            <div class="card-body">
                                <div class="list-group list-group-flush">
                                    <c:forEach var="note" items="${notifications}">
                                        <div class="list-group-item d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-info-circle text-primary"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <p class="mb-0">${note}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- My Events -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h6 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>My Recent Events</h6>
                                <a href="${pageContext.request.contextPath}/organization?action=events" class="btn btn-primary btn-sm">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <c:choose>
                                    <c:when test="${not empty myEvents}">
                                        <div class="list-group list-group-flush">
                                            <c:forEach var="event" items="${myEvents}" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <div class="list-group-item event-card">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1">${event.eventTitle}</h6>
                                                                <p class="mb-1 text-muted">
                                                                    <i class="fas fa-calendar me-2"></i>${event.eventDate}
                                                                    <i class="fas fa-clock ms-3 me-2"></i>${event.eventTime}
                                                                </p>
                                                                <p class="mb-1 text-muted">
                                                                    <i class="fas fa-map-marker-alt me-2"></i>${event.eventLocation}
                                                                </p>
                                                            </div>
                                                            <div class="text-end">
                                                                <c:choose>
                                                                    <c:when test="${event.eventStatus == 'approved'}">
                                                                        <span class="badge bg-success">Approved</span>
                                                                    </c:when>
                                                                    <c:when test="${event.eventStatus == 'pending'}">
                                                                        <span class="badge bg-warning">Pending</span>
                                                                    </c:when>
                                                                    <c:when test="${event.eventStatus == 'rejected'}">
                                                                        <span class="badge bg-danger">Rejected</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${event.eventStatus}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <div class="btn-group mt-2" role="group">
                                                                    <a href="${pageContext.request.contextPath}/organization?action=eventParticipants&eventID=${event.eventID}" 
                                                                       class="btn btn-outline-primary btn-sm"><i class="fas fa-users"></i></a>
                                                                    <a href="${pageContext.request.contextPath}/organization?action=editEvent&eventID=${event.eventID}" 
                                                                       class="btn btn-outline-secondary btn-sm"><i class="fas fa-edit"></i></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <i class="fas fa-calendar-plus fa-3x text-muted mb-3"></i>
                                            <h6 class="text-muted">No events yet</h6>
                                            <p class="text-muted">Create your first event to get started!</p>
                                            <a href="${pageContext.request.contextPath}/org/createEvent.jsp" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Create Event</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /.row -->
</div> <!-- /.container -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>