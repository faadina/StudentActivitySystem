<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details #${booking.bookingID}</title>
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
        .details-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            margin-bottom: 25px;
        }
        .details-card .card-header {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .details-list { list-style: none; padding-left: 0; }
        .details-list li {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f1f1;
        }
        .details-list li:last-child { border-bottom: none; }
        .details-list .label { color: #6c757d; }
        .details-list .value { font-weight: 500; text-align: right; }
        .status-badge {
            font-size: 1rem;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 8px;
        }
        .status-confirmed { background-color: #d4edda; color: #155724; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; }
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
                                <i class="fas fa-file-invoice me-2 text-primary"></i>
                                Booking Details
                            </h2>
                            <p class="text-muted mb-0">Booking ID: <strong>#${booking.bookingID}</strong></p>
                        </div>
                        <div class="col-auto">
                           <button class="btn btn-outline-secondary" onclick="history.back()">
                               <i class="fas fa-arrow-left me-2"></i>Go Back
                           </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <c:if test="${not empty booking}">
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="card details-card">
                                <div class="card-header">Booking Information</div>
                                <div class="card-body">
                                    <ul class="details-list">
                                        <li><span class="label">Venue Name</span> <span class="value">${booking.venueName}</span></li>
                                        <li><span class="label">Event Type</span> <span class="value">${booking.eventType}</span></li>
                                        <li><span class="label">Booking Date</span> <span class="value"><fmt:formatDate value="${booking.bookingDate}" pattern="EEEE, dd MMMM yyyy"/></span></li>
                                        <li><span class="label">Time</span> <span class="value"><fmt:formatDate value="${booking.startTime}" pattern="hh:mm a"/> - <fmt:formatDate value="${booking.endTime}" pattern="hh:mm a"/></span></li>
                                        <li><span class="label">Attendees</span> <span class="value">${booking.expectedAttendees} people</span></li>
                                    </ul>
                                </div>
                            </div>
                             <div class="card details-card">
                                <div class="card-header">Purpose of Booking</div>
                                <div class="card-body">
                                    <p class="text-muted">${booking.purpose}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <div class="card details-card">
                                <div class="card-header">Status & Payment</div>
                                <div class="card-body text-center">
                                    <p class="mb-2">Booking Status:</p>
                                    <h4 class="mb-3"><span class="status-badge status-${booking.status}">${booking.status}</span></h4>
                                    <hr>
                                    <p class="mb-2">Total Amount:</p>
                                    <h4 class="text-success">RM <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00"/></h4>
                                </div>
                            </div>
                            <div class="card details-card">
                                <div class="card-header">Booking History</div>
                                <div class="card-body">
                                     <ul class="details-list">
                                        <li><span class="label">Booked By</span> <span class="value">${booking.userName}</span></li>
                                        <li><span class="label">Booking Created</span> <span class="value"><fmt:formatDate value="${booking.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></span></li>
                                        <c:if test="${not empty booking.approvedBy}">
                                            <li><span class="label">Approved By</span> <span class="value">${booking.approvedBy}</span></li>
                                            <li><span class="label">Approved At</span> <span class="value"><fmt:formatDate value="${booking.approvedAt}" pattern="dd MMM yyyy, hh:mm a"/></span></li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty booking}">
                    <div class="alert alert-danger text-center">
                        <h4>Booking Not Found</h4>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>