<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Event - ${event.eventTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .main-content { min-height: 100vh; }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="organizationSidebar.jsp" />

        <div class="col-md-9 col-lg-10 main-content">
            <div class="container-fluid py-4">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="card">
                            <div class="card-header bg-white pb-0">
                                <h4 class="mb-0">
                                    <i class="fas fa-edit me-2 text-primary"></i> Edit Event
                                </h4>
                                <p class="text-muted">Update the details for your event: ${event.eventTitle}</p>
                            </div>
                            <div class="card-body p-4">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/organization" method="post">
                                    
                                    <input type="hidden" name="action" value="updateEvent">
                                    <input type="hidden" name="eventId" value="${event.eventID}">

                                    <h5 class="mb-3">Basic Information</h5>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="eventTitle" class="form-label">Event Title</label>
                                            <input type="text" class="form-control" id="eventTitle" name="eventTitle" value="${event.eventTitle}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="eventDate" class="form-label">Event Date</label>
                                            <input type="date" class="form-control" id="eventDate" name="eventDate" value="<fmt:formatDate value="${event.eventDate}" pattern="yyyy-MM-dd"/>" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="eventTime" class="form-label">Event Time</label>
                                            <input type="time" class="form-control" id="eventTime" name="eventTime" value="<fmt:formatDate value="${event.eventTime}" pattern="HH:mm"/>" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="eventDescription" class="form-label">Event Description</label>
                                            <textarea class="form-control" id="eventDescription" name="eventDescription" rows="4" required>${event.eventDescription}</textarea>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <h5 class="mb-3">Details & Registration</h5>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="eventLocation" class="form-label">Event Location</label>
                                            <input type="text" class="form-control" id="eventLocation" name="eventLocation" value="${event.eventLocation}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="eventCategory" class="form-label">Event Category</label>
                                            <select class="form-select" id="eventCategory" name="eventCategory">
                                                <option value="academic" ${event.eventCategory == 'academic' ? 'selected' : ''}>Academic</option>
                                                <option value="sports" ${event.eventCategory == 'sports' ? 'selected' : ''}>Sports</option>
                                                <option value="cultural" ${event.eventCategory == 'cultural' ? 'selected' : ''}>Cultural</option>
                                                <option value="general" ${event.eventCategory == 'general' ? 'selected' : ''}>General</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="participantLimit" class="form-label">Participant Limit</label>
                                            <input type="number" class="form-control" id="participantLimit" name="participantLimit" value="${event.participantLimit}" min="0">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="registrationDeadline" class="form-label">Registration Deadline</label>
                                            <input type="date" class="form-control" id="registrationDeadline" name="registrationDeadline" value="<fmt:formatDate value="${event.registrationDeadline}" pattern="yyyy-MM-dd"/>">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="registrationFee" class="form-label">Registration Fee (RM)</label>
                                            <input type="number" class="form-control" id="registrationFee" name="registrationFee" value="${event.registrationFee}" min="0" step="0.01">
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <h5 class="mb-3">Contact Information</h5>
                                     <div class="row g-3">
                                         <div class="col-md-4">
                                             <label for="contactPerson" class="form-label">Contact Person</label>
                                             <input type="text" class="form-control" id="contactPerson" name="contactPerson" value="${event.contactPerson}">
                                         </div>
                                         <div class="col-md-4">
                                             <label for="contactEmail" class="form-label">Contact Email</label>
                                             <input type="email" class="form-control" id="contactEmail" name="contactEmail" value="${event.contactEmail}">
                                         </div>
                                         <div class="col-md-4">
                                             <label for="contactPhone" class="form-label">Contact Phone</label>
                                             <input type="tel" class="form-control" id="contactPhone" name="contactPhone" value="${event.contactPhone}">
                                         </div>
                                     </div>
                                    
                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-primary px-5">
                                            <i class="fas fa-save me-2"></i>Update Event
                                        </button>
                                        <a href="${pageContext.request.contextPath}/organization?action=viewEvent&id=${event.eventID}" class="btn btn-outline-secondary">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>