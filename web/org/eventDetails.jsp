<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - ${event.eventTitle}</title>
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
            border-bottom: 1px solid #dee2e6;
        }
        .details-list {
            list-style: none;
            padding-left: 0;
        }
        .details-list li {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f1f1;
        }
        .details-list li:last-child {
            border-bottom: none;
        }
        .details-list .label {
            color: #6c757d;
            font-weight: 500;
        }
        .details-list .value {
            font-weight: 600;
            text-align: right;
        }
        .status-badge {
            font-size: 1rem;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 8px;
            text-transform: capitalize;
        }
        .status-approved { background-color: #d4edda; color: #155724; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-rejected { background-color: #f8d7da; color: #721c24; }
        
@media print {
    /* Hide everything except the main content */
    body * {
        visibility: hidden;
        background: white;
    }
    .main-content, .main-content * {
        visibility: visible;
    }
    
    /* Reset layout for printing */
    .main-content {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        padding: 0;
        margin: 0;
    }
    
    /* Optimize card styling for print */
    .details-card {
        page-break-inside: avoid; /* Prevent cards from splitting across pages */
        margin-bottom: 10px !important;
        box-shadow: none !important;
        border: 1px solid #ddd !important;
    }
    
    .card-header {
        background-color: white !important;
        border-bottom: 1px solid #000 !important;
        padding: 5px 10px !important;
    }
    
    .card-body {
        padding: 10px !important;
    }
    
    /* Hide unnecessary elements */
    .btn, .sidebar, .page-header {
        display: none !important;
    }
    
    /* Optimize typography */
    body {
        font-size: 12px !important;
        line-height: 1.2 !important;
    }
    
    h2 {
        font-size: 18px !important;
        margin: 5px 0 !important;
    }
    
    h4, h5, h6 {
        font-size: 14px !important;
        margin: 5px 0 !important;
    }
    
    /* Compact list items */
    .details-list li {
        padding: 4px 0 !important;
    }
    
    /* Status badge styling */
    .status-badge {
        background-color: white !important;
        border: 1px solid #000 !important;
        padding: 3px 8px !important;
        font-size: 12px !important;
    }
    
    /* Remove URL from print output */
    a[href]:after {
        content: none !important;
    }
    
    /* Page setup */
    @page {
        size: A4;
        margin: 10mm;
    }
}
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="organizationSidebar.jsp" />

            <div class="col-md-9 col-lg-10 main-content">
                
                <c:if test="${not empty event}">
                    <div class="page-header">
                        <div class="container-fluid">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h2 class="mb-1">
                                        <i class="fas fa-calendar-check me-2 text-primary"></i>
                                        Event Details
                                    </h2>
                                    <p class="text-muted mb-0">Viewing details for: <strong>${event.eventTitle}</strong></p>
                                </div>
                                <div class="col-auto">
                                    <a href="${pageContext.request.contextPath}/organization?action=events" class="btn btn-outline-secondary me-2">
                                        <i class="fas fa-arrow-left me-2"></i>Back to Events
                                    </a>
                                        <button onclick="window.print()" class="btn btn-outline-primary me-2">
        <i class="fas fa-print me-2"></i>Print
    </button>
                                    <c:if test="${event.eventStatus == 'pending' or event.eventStatus == 'rejected'}">
                                        <a href="${pageContext.request.contextPath}/organization?action=editEvent&id=${event.eventID}" class="btn btn-primary">
                                            <i class="fas fa-edit me-2"></i>Edit Event
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card details-card">
                                    <div class="card-header">
                                        <i class="fas fa-align-left me-2"></i>Event Description
                                    </div>
                                    <div class="card-body">
                                        <p>${event.eventDescription}</p>
                                    </div>
                                </div>

                                <div class="card details-card">
                                    <div class="card-header">
                                        <i class="fas fa-users me-2"></i>Registration Details
                                    </div>
                                    <div class="card-body">
                                        <ul class="details-list">
                                            <li>
                                                <span class="label">Participants</span>
                                                <span class="value">${event.registeredCount} / ${event.participantLimit == 0 ? "Unlimited" : event.participantLimit}</span>
                                            </li>
                                            <li>
                                                <span class="label">Registration Fee</span>
                                                <span class="value text-success">
                                                    <c:choose>
                                                        <c:when test="${event.registrationFee > 0}">
                                                            RM <fmt:formatNumber value="${event.registrationFee}" pattern="#,##0.00"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            FREE
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="label">Registration Deadline</span>
                                                <span class="value"><fmt:formatDate value="${event.registrationDeadline}" pattern="dd MMM yyyy"/></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="card details-card">
                                    <div class="card-header">
                                        <i class="fas fa-info-circle me-2"></i>Additional Information
                                    </div>
                                    <div class="card-body">
                                        <h6>Requirements:</h6>
                                        <p class="text-muted">${not empty event.requirements ? event.requirements : "None specified."}</p>
                                        <hr>
                                        <h6>Special Instructions:</h6>
                                        <p class="text-muted">${not empty event.specialInstructions ? event.specialInstructions : "None specified."}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="card details-card text-center">
                                    <div class="card-header">
                                        <i class="fas fa-check-circle me-2"></i>Event Status
                                    </div>
                                    <div class="card-body">
                                        <span class="status-badge status-${event.eventStatus}">${event.eventStatus}</span>
                                        <c:if test="${event.eventStatus == 'rejected'}">
                                            <p class="text-danger mt-2 mb-0">
                                                <strong>Reason:</strong> ${event.rejectionReason}
                                            </p>
                                        </c:if>
                                        <c:if test="${event.eventStatus == 'approved'}">
                                            <p class="text-muted small mt-2 mb-0">
                                                Approved by ${event.approvedBy} on <fmt:formatDate value="${event.approvedAt}" pattern="dd MMM yyyy"/>
                                            </p>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card details-card">
                                    <div class="card-header">
                                        <i class="fas fa-list-alt me-2"></i>Key Details
                                    </div>
                                    <div class="card-body">
                                        <ul class="details-list">
                                            <li>
                                                <span class="label"><i class="fas fa-calendar me-2"></i>Date</span>
                                                <span class="value"><fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy"/></span>
                                            </li>
                                            <li>
                                                <span class="label"><i class="fas fa-clock me-2"></i>Time</span>
                                                <span class="value"><fmt:formatDate value="${event.eventTime}" pattern="hh:mm a"/></span>
                                            </li>
                                            <li>
                                                <span class="label"><i class="fas fa-map-marker-alt me-2"></i>Location</span>
                                                <span class="value">${event.eventLocation}</span>
                                            </li>
                                            <li>
                                                <span class="label"><i class="fas fa-tag me-2"></i>Category</span>
                                                <span class="value">${event.eventCategory}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                
                                <div class="card details-card">
                                    <div class="card-header">
                                        <i class="fas fa-user me-2"></i>Contact Person
                                    </div>
                                    <div class="card-body">
                                        <ul class="details-list">
                                            <li>
                                                <span class="label"><i class="fas fa-user-tie me-2"></i>Name</span>
                                                <span class="value">${event.contactPerson}</span>
                                            </li>
                                            <li>
                                                <span class="label"><i class="fas fa-envelope me-2"></i>Email</span>
                                                <span class="value">${event.contactEmail}</span>
                                            </li>
                                            <li>
                                                <span class="label"><i class="fas fa-phone me-2"></i>Phone</span>
                                                <span class="value">${event.contactPhone}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty event}">
                    <div class="container-fluid">
                        <div class="alert alert-danger text-center">
                            <h4><i class="fas fa-exclamation-triangle me-2"></i>Event Not Found</h4>
                            <p>The event you are looking for does not exist or you do not have permission to view it.</p>
                            <a href="${pageContext.request.contextPath}/organization?action=events" class="btn btn-primary">Back to My Events</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>