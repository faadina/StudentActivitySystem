<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resource Booking - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .page-header { background: white; border-bottom: 1px solid #dee2e6; padding: 20px 0; margin-bottom: 30px; }
        .resource-card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: all 0.3s ease; border: none; overflow: hidden; display: flex; flex-direction: column; }
        .resource-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .resource-card .card-body { flex-grow: 1; display: flex; flex-direction: column; }
        .resource-card .card-footer { background-color: #f8f9fa; }
        .resource-image { height: 180px; background-size: cover; background-position: center; }
        .booking-history-card { background: #fff; border-radius: 8px; padding: 15px; margin-bottom: 10px; border-left: 4px solid #0dcaf0; }
        .status-badge { padding: 4px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; text-transform: capitalize;}
        .status-confirmed, .status-borrowed { background-color: #d1e7dd; color: #0f5132; }
        .status-pending { background-color: #fff3cd; color: #664d03; }
        .status-returned { background-color: #cfe2ff; color: #084298; }
        .status-overdue { background-color: #f8d7da; color: #842029; }
        .status-cancelled { background-color: #e2e3e5; color: #41464b; }
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
                            <div class="col"><h2 class="mb-0"><i class="fas fa-boxes me-2 text-primary"></i> Resource Booking</h2><p class="text-muted mb-0">Book equipment and resources</p></div>
                            <div class="col-auto"><button class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#bookingHistoryModal"><i class="fas fa-history me-2"></i>My Bookings</button></div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty resources}">
                                <c:forEach var="resource" items="${resources}">
                                    <div class="col-lg-4 col-md-6 mb-4">
                                        <div class="resource-card h-100">
                                            <div class="resource-image" style="background-image: url('${not empty resource.imageUrl ? resource.imageUrl : 'https://via.placeholder.com/400x250.png?text=Resource'}')"></div>
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between">
                                                    <h5 class="card-title mb-1">${resource.resourceName}</h5>
                                                    <span class="badge bg-secondary">${resource.category}</span>
                                                </div>
                                                <p class="card-text text-muted small mb-3">${resource.location}</p>
                                                <p class="card-text flex-grow-1">${fn:substring(resource.description, 0, 100)}${fn:length(resource.description) > 100 ? '...' : ''}</p>
                                                <div class="d-flex justify-content-between fw-bold">
                                                    <span class="text-success"><i class="fas fa-check-circle me-1"></i>${resource.availableQuantity} Available</span>
                                                    <span class="text-muted">${resource.totalQuantity} Total</span>
                                                </div>
                                            </div>
                                            <div class="card-footer d-grid">
                                                <button class="btn btn-primary" onclick="bookResource(${resource.resourceID}, '${resource.resourceName}')">
                                                    <i class="fas fa-plus me-2"></i>Book This Resource
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise><div class="col-12 text-center py-5"><h4>No Resources Found</h4></div></c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="bookingHistoryModal" tabindex="-1"><div class="modal-dialog modal-xl"><div class="modal-content"><div class="modal-header"><h5 class="modal-title"><i class="fas fa-history me-2"></i>My Resource Bookings</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body"><c:choose><c:when test="${not empty resourceBookings}"><div class="table-responsive"><table class="table table-hover"><thead><tr><th>Resource</th><th>Event</th><th>Borrow Date</th><th>Return Date</th><th>Status</th><th>Actions</th></tr></thead><tbody><c:forEach var="booking" items="${resourceBookings}"><tr><td><strong>${booking.resourceName}</strong></td><td>${booking.eventName}</td><td><fmt:formatDate value="${booking.borrowDate}" pattern="dd MMM yyyy"/></td><td><fmt:formatDate value="${booking.returnDate}" pattern="dd MMM yyyy"/></td><td><span class="status-badge status-${fn:toLowerCase(booking.status)}">${booking.status}</span></td><td><c:if test="${booking.status == 'pending' || booking.status == 'confirmed'}"><button class="btn btn-outline-danger btn-sm" onclick="cancelBooking(${booking.bookingID})">Cancel</button></c:if></td></tr></c:forEach></tbody></table></div></c:when><c:otherwise><div class="text-center py-5"><h5>No booking history found.</h5></div></c:otherwise></c:choose></div></div></div></div>

    <div class="modal fade" id="resourceBookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resourceBookModalTitle">Book Resource</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="resourceBookForm" method="POST" action="${pageContext.request.contextPath}/organization">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="bookResource">
                        <%-- ID Sumber akan dimasukkan oleh JavaScript --%>
                        <input type="hidden" id="modal_resourceId" name="resourceIds">

                        <div class="mb-3">
                            <label for="modal_eventName" class="form-label">Event/Activity Name *</label>
                            <input type="text" class="form-control" id="modal_eventName" name="eventName" required>
                        </div>
                         <div class="mb-3">
                            <label for="modal_eventLocation" class="form-label">Event Location *</label>
                            <input type="text" class="form-control" id="modal_eventLocation" name="eventLocation" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="modal_borrowDate" class="form-label">Borrow Date *</label>
                                <input type="date" class="form-control" id="modal_borrowDate" name="borrowDate" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="modal_returnDate" class="form-label">Return Date *</label>
                                <input type="date" class="form-control" id="modal_returnDate" name="returnDate" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="modal_purpose" class="form-label">Purpose of Booking *</label>
                            <textarea class="form-control" id="modal_purpose" name="purpose" rows="3" required></textarea>
                        </div>
                         <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="modal_contactPerson" class="form-label">Contact Person *</label>
                                <input type="text" class="form-control" id="modal_contactPerson" name="contactPerson" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="modal_contactPhone" class="form-label">Contact Phone *</label>
                                <input type="tel" class="form-control" id="modal_contactPhone" name="contactPhone" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-check me-2"></i>Submit Booking</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055"><div id="alertContainer"></div></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // KOD JAVASCRIPT BARU: Fungsi untuk membuka modal tempahan sumber
        function bookResource(resourceId, resourceName) {
            // Set ID sumber dalam borang modal
            document.getElementById('modal_resourceId').value = resourceId;
            // Set tajuk modal
            document.getElementById('resourceBookModalTitle').innerText = 'Book: ' + resourceName;
            
            // Set tarikh minimum
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('modal_borrowDate').min = today;
            document.getElementById('modal_returnDate').min = today;

            // Buka modal
            const bookingModal = new bootstrap.Modal(document.getElementById('resourceBookModal'));
            bookingModal.show();
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this resource booking?')) {
                const formData = new FormData();
                formData.append('bookingId', bookingId);
                formData.append('type', 'resource');

                fetch('${pageContext.request.contextPath}/organization?action=cancelBooking', { method: 'POST', body: formData })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            showAlert(data.message || 'Booking cancelled.', 'success');
                            setTimeout(() => location.reload(), 1500);
                        } else {
                            showAlert(data.message || 'Failed to cancel.', 'danger');
                        }
                    }).catch(err => showAlert('An error occurred.', 'danger'));
            }
        }
        
        function showAlert(message, type = 'info') {
            const wrapper = document.createElement('div');
            wrapper.innerHTML = \`<div class="alert alert-\${type} alert-dismissible fade show" role="alert">\${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>\`;
            document.getElementById('alertContainer').append(wrapper);
            setTimeout(() => { wrapper.remove(); }, 5000);
        }
    </script>
</body>
</html>