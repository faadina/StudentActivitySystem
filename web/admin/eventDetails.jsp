<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .details-card {
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .details-header {
            background-color: #6c757d;
            color: white;
            padding: 1rem 1.5rem;
            border-top-left-radius: 0.5rem;
            border-top-right-radius: 0.5rem;
        }
        .details-list dt { font-weight: 600; color: #495057; }
        .details-list dd { color: #6c757d; }
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
                    <div class="d-flex align-items-center mb-4">
                        <a href="admin?action=events" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
                        <div>
                            <h2 class="mb-0">Event Details</h2>
                            <p class="text-muted mb-0">Read-only view of the event.</p>
                        </div>
                    </div>

                    <div class="card details-card">
                        <div class="details-header">
                            <h4 class="mb-0">${event.eventTitle}</h4>
                            <p class="mb-0 small">by ${organization.userName}</p>
                        </div>
                        <div class="card-body p-4">
                            <div class="row">
                                <div class="col-md-8">
                                    <h5>Event Information</h5>
                                    <dl class="row details-list">
                                        <dt class="col-sm-4">Event ID</dt><dd class="col-sm-8">${event.eventID}</dd>
                                        <dt class="col-sm-4">Category</dt><dd class="col-sm-8">${event.eventCategory}</dd>
                                        <dt class="col-sm-4">Date & Time</dt><dd class="col-sm-8"><fmt:formatDate value="${event.eventDate}" pattern="EEEE, dd MMMM yyyy"/>, <fmt:formatDate value="${event.eventTime}" pattern="h:mm a"/></dd>
                                        <dt class="col-sm-4">Location</dt><dd class="col-sm-8">${event.eventLocation}</dd>
                                        <dt class="col-sm-4">Description</dt><dd class="col-sm-8">${event.eventDescription}</dd>
                                        <dt class="col-sm-4">Requirements</dt><dd class="col-sm-8">${not empty event.requirements ? event.requirements : "None"}</dd>
                                        <dt class="col-sm-4">Instructions</dt><dd class="col-sm-8">${not empty event.specialInstructions ? event.specialInstructions : "None"}</dd>
                                    </dl>
                                </div>
                                <div class="col-md-4">
                                    <h5>Registration & Status</h5>
                                     <dl class="row details-list">
                                        <dt class="col-sm-6">Status</dt>
                                        <dd class="col-sm-6">
                                            <c:choose>
                                                <c:when test="${event.eventStatus == 'approved'}"><span class="badge bg-success">Approved</span></c:when>
                                                <c:when test="${event.eventStatus == 'pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                                <c:when test="${event.eventStatus == 'rejected'}"><span class="badge bg-danger">Rejected</span></c:when>
                                            </c:choose>
                                        </dd>
                                        <dt class="col-sm-6">Participants</dt><dd class="col-sm-6">${event.registeredCount} / ${event.participantLimit > 0 ? event.participantLimit : 'Unlimited'}</dd>
                                        <dt class="col-sm-6">Registration Fee</dt><dd class="col-sm-6">RM <fmt:formatNumber value="${event.registrationFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></dd>
                                        <dt class="col-sm-6">Deadline</dt><dd class="col-sm-6"><fmt:formatDate value="${event.registrationDeadline}" pattern="dd MMM yyyy"/></dd>
                                    </dl>
                                    <hr>
                                    <h5>Contact Person</h5>
                                    <dl class="row details-list">
                                        <dt class="col-sm-4">Name</dt><dd class="col-sm-8">${event.contactPerson}</dd>
                                        <dt class="col-sm-4">Email</dt><dd class="col-sm-8">${event.contactEmail}</dd>
                                        <dt class="col-sm-4">Phone</dt><dd class="col-sm-8">${event.contactPhone}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>