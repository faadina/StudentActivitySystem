<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule for ${venue.venueName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .main-content { min-height: 100vh; }
        .page-header {
            background: white;
            border-bottom: 1px solid #dee2e6;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
        }
        .table thead th {
            background-color: #f8f9fa;
        }
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-confirmed { background-color: #d4edda; color: #155724; }
        .status-pending { background-color: #fff3cd; color: #856404; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="organizationSidebar.jsp" />

        <div class="col-md-9 col-lg-10 main-content">
            <div class="page-header">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col">
                            <h2 class="mb-1">
                                <i class="fas fa-calendar-alt me-2 text-primary"></i>
                                Venue Schedule
                            </h2>
                            <p class="text-muted mb-0">Viewing schedule for: <strong>${venue.venueName}</strong></p>
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/organization?action=venues" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Venues
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h5>Booking List for ${venue.venueName}</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty bookings}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Booking ID</th>
                                                <th>Date</th>
                                                <th>Time Slot</th>
                                                <th>Booked For</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="booking" items="${bookings}">
                                                <tr>
                                                    <td>#${booking.bookingID}</td>
                                                    <td><fmt:formatDate value="${booking.bookingDate}" pattern="dd MMM, yyyy"/></td>
                                                    <td>
                                                        <fmt:formatDate value="${booking.startTime}" pattern="hh:mm a"/> - 
                                                        <fmt:formatDate value="${booking.endTime}" pattern="hh:mm a"/>
                                                    </td>
                                                    <td>${booking.eventType}</td>
                                                    <td>
                                                        <span class="status-badge status-${booking.status}">${booking.status}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-calendar-check fa-3x text-muted mb-3"></i>
                                    <h4>No Bookings Found</h4>
                                    <p class="text-muted">This venue has no upcoming bookings.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>