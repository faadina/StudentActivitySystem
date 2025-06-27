<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .card-header { background-color: #fff; border-bottom: 1px solid #e3e6f0; }
        .nav-tabs .nav-link { color: #5a5c69; border-bottom: 2px solid transparent; }
        .nav-tabs .nav-link:hover { border-color: #e9ecef; }
        .nav-tabs .nav-link.active { color: #0d6efd; border-color: #0d6efd; font-weight: 600; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="events"/>
                </jsp:include>
            </div>

            <div class="col-md-10 main-content">
                <div class="p-4">
                    <h2 class="mb-4">Event Management</h2>

                    <div class="card shadow-sm">
                        <div class="card-header">
                            <ul class="nav nav-tabs card-header-tabs">
                                <li class="nav-item">
                                    <a class="nav-link ${param.filter == 'pending' or empty param.filter ? 'active' : ''}" href="admin?action=events&filter=pending">Pending</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${param.filter == 'approved' ? 'active' : ''}" href="admin?action=events&filter=approved">Approved</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${param.filter == 'rejected' ? 'active' : ''}" href="admin?action=events&filter=rejected">Rejected</a>
                                </li>
                                 <li class="nav-item">
                                    <a class="nav-link ${param.filter == 'all' ? 'active' : ''}" href="admin?action=events&filter=all">All Events</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>Event Title</th>
                                            <th>Organization</th>
                                            <th>Date & Location</th>
                                            <th>Participants</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty events}">
                                            <tr><td colspan="6" class="text-center py-4">No events found for this filter.</td></tr>
                                        </c:if>
                                        <c:forEach var="event" items="${events}">
                                            <tr>
                                                <td>
                                                    <strong>${event.eventTitle}</strong><br>
                                                    <small class="text-muted">${event.eventCategory}</small>
                                                </td>
                                                <td>${event.organizationID}</td>
                                                <td>
                                                    <fmt:formatDate value="${event.eventDate}" pattern="dd MMM, yyyy"/> at <fmt:formatDate value="${event.eventTime}" pattern="h:mm a"/><br>
                                                    <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i>${event.eventLocation}</small>
                                                </td>
                                                <td>${event.registeredCount} / ${event.participantLimit > 0 ? event.participantLimit : '∞'}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${event.eventStatus == 'approved'}"><span class="badge bg-success">Approved</span></c:when>
                                                        <c:when test="${event.eventStatus == 'pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                                        <c:when test="${event.eventStatus == 'rejected'}"><span class="badge bg-danger">Rejected</span></c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="admin?action=viewEvent&eventId=${event.eventID}" class="btn btn-sm btn-outline-primary" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${event.eventStatus == 'pending'}">
                                                        <form action="admin" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to approve this event?');">
                                                            <input type="hidden" name="action" value="approveEvent">
                                                            <input type="hidden" name="eventId" value="${event.eventID}">
                                                            <button type="submit" class="btn btn-sm btn-success" title="Approve"><i class="fas fa-check"></i></button>
                                                        </form>
                                                        <form action="admin" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to reject this event?');">
                                                            <input type="hidden" name="action" value="rejectEvent">
                                                            <input type="hidden" name="eventId" value="${event.eventID}">
                                                            <button type="submit" class="btn btn-sm btn-danger" title="Reject"><i class="fas fa-times"></i></button>
                                                        </form>
                                                    </c:if>
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
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>