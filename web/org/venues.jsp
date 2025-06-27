<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venue Booking - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .page-header { background: white; border-bottom: 1px solid #dee2e6; padding: 20px 0; margin-bottom: 30px; }
        .venue-card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: all 0.3s ease; border: none; overflow: hidden; }
        .venue-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .venue-image { height: 200px; background-size: cover; background-position: center; position: relative; }
        .venue-badge { position: absolute; top: 15px; right: 15px; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; text-transform: capitalize; }
        .available { background-color: #d1e7dd; color: #0f5132; }
        .booked { background-color: #f8d7da; color: #842029; }
        .maintenance { background-color: #fff3cd; color: #664d03; }
        .booking-status { font-size: 0.85rem; font-weight: 600; padding: 4px 12px; border-radius: 20px; text-transform: capitalize; }
        .status-confirmed { background-color: #d1e7dd; color: #0f5132; }
        .status-pending { background-color: #fff3cd; color: #664d03; }
        .status-cancelled { background-color: #f8d7da; color: #842029; }
        .filter-section { background: white; border-radius: 12px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .stats-card { background: white; border-radius: 12px; padding: 20px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .stats-number { font-size: 2rem; font-weight: bold; color: #667eea; }
        .booking-history-card { background: white; border-radius: 8px; padding: 15px; margin-bottom: 15px; border-left: 4px solid #667eea; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
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
                            <div class="col"><h2 class="mb-0"><i class="fas fa-building me-2 text-primary"></i> Venue Booking</h2><p class="text-muted mb-0">Book venues for your events and activities</p></div>
                            <div class="col-auto"><button class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#bookingHistoryModal"><i class="fas fa-history me-2"></i>Booking History</button><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#quickBookModal"><i class="fas fa-plus me-2"></i>Quick Book</button></div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3"><div class="stats-card"><div class="stats-number">${totalVenues}</div><div class="text-muted">Total Venues</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><div class="stats-number text-success">${availableVenues}</div><div class="text-muted">Available</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><div class="stats-number text-warning">${myBookings}</div><div class="text-muted">My Bookings</div></div></div>
                        <div class="col-md-3 mb-3"><div class="stats-card"><div class="stats-number text-info">${upcomingBookings}</div><div class="text-muted">Upcoming</div></div></div>
                    </div>

                    <div class="filter-section"><form method="GET" action="${pageContext.request.contextPath}/organization"><input type="hidden" name="action" value="venues"><div class="row align-items-end"><div class="col-md-3"><label for="dateFilter" class="form-label">Select Date</label><input type="date" class="form-control" id="dateFilter" name="date" value="${param.date}" onchange="this.form.submit()"></div><div class="col-md-2"><label for="capacityFilter" class="form-label">Min Capacity</label><select class="form-select" id="capacityFilter" name="capacity" onchange="this.form.submit()"><option value="">Any</option><option value="50" ${param.capacity == '50' ? 'selected' : ''}>50+</option><option value="100" ${param.capacity == '100' ? 'selected' : ''}>100+</option><option value="200" ${param.capacity == '200' ? 'selected' : ''}>200+</option><option value="500" ${param.capacity == '500' ? 'selected' : ''}>500+</option></select></div><div class="col-md-2"><label for="buildingFilter" class="form-label">Building</label><select class="form-select" id="buildingFilter" name="building" onchange="this.form.submit()"><option value="">All Buildings</option><c:forEach var="building" items="${buildings}"><option value="${building}" ${param.building == building ? 'selected' : ''}>${building}</option></c:forEach></select></div><div class="col-md-2"><label for="typeFilter" class="form-label">Venue Type</label><select class="form-select" id="typeFilter" name="type" onchange="this.form.submit()"><option value="">All Types</option><option value="Hall" ${param.type == 'Hall' ? 'selected' : ''}>Hall</option><option value="Auditorium" ${param.type == 'Auditorium' ? 'selected' : ''}>Auditorium</option><option value="Classroom" ${param.type == 'Classroom' ? 'selected' : ''}>Classroom</option><option value="Lab" ${param.type == 'Lab' ? 'selected' : ''}>Laboratory</option><option value="Sports" ${param.type == 'Sports' ? 'selected' : ''}>Sports Facility</option><option value="Outdoor" ${param.type == 'Outdoor' ? 'selected' : ''}>Outdoor Space</option></select></div><div class="col-md-2"><label for="statusFilter" class="form-label">Availability</label><select class="form-select" id="statusFilter" name="status" onchange="this.form.submit()"><option value="">All</option><option value="available" ${param.status == 'available' ? 'selected' : ''}>Available</option><option value="booked" ${param.status == 'booked' ? 'selected' : ''}>Booked</option><option value="maintenance" ${param.status == 'maintenance' ? 'selected' : ''}>Maintenance</option></select></div><div class="col-md-1"><button type="button" class="btn btn-outline-secondary" onclick="clearFilters()"><i class="fas fa-times"></i></button></div></div></form></div>

                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty venues}"><c:forEach var="venue" items="${venues}"><div class="col-lg-6 col-xl-4 mb-4"><div class="venue-card"><div class="venue-image" style="background-image: url('${not empty venue.imageUrl ? venue.imageUrl : 'https://via.placeholder.com/400x250.png?text=No+Image'}')"><span class="venue-badge ${fn:toLowerCase(venue.availability)}"><i class="fas fa-circle me-1"></i>${venue.availability}</span></div><div class="card-body p-3"><h5 class="card-title">${venue.venueName}</h5><p class="text-muted mb-2"><i class="fas fa-map-marker-alt me-2"></i>${venue.building}, ${venue.floor}</p><div class="d-flex justify-content-between text-muted mb-3"><span><i class="fas fa-users me-1"></i> ${venue.capacity} Pax</span><span><i class="fas fa-tag me-1"></i> ${venue.venueType}</span></div><div class="d-grid gap-2"><c:choose><c:when test="${venue.availability == 'Available'}"><button class="btn btn-primary" onclick="bookVenue(${venue.venueID}, '${venue.venueName}')"><i class="fas fa-calendar-plus me-2"></i>Book Now</button></c:when><c:otherwise><button class="btn btn-outline-warning" onclick="viewSchedule(${venue.venueID})"><i class="fas fa-clock me-2"></i>View Schedule</button></c:otherwise></c:choose><button class="btn btn-outline-info btn-sm" onclick="viewVenueDetails(${venue.venueID})"><i class="fas fa-info-circle me-2"></i>View Details</button></div></div></div></div></c:forEach></c:when>
                            <c:otherwise><div class="col-12"><div class="text-center py-5"><i class="fas fa-building fa-3x text-muted mb-3"></i><h4>No Venues Found</h4><p>No venues match your current filters.</p></div></div></c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="quickBookModal" tabindex="-1"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h5 class="modal-title">Quick Venue Booking</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><form id="quickBookForm" method="POST" action="${pageContext.request.contextPath}/organization?action=bookVenue"><div class="modal-body"><div class="row"><div class="col-md-6"><div class="mb-3"><label for="bookingDate" class="form-label">Date *</label><input type="date" class="form-control" id="bookingDate" name="bookingDate" required min="<fmt:formatDate value='${currentDate}' pattern='yyyy-MM-dd'/>"></div></div><div class="col-md-6"><div class="mb-3"><label for="eventType" class="form-label">Event Type *</label><select class="form-select" id="eventType" name="eventType" required><option value="">Select</option><option value="Meeting">Meeting</option><option value="Workshop">Workshop</option></select></div></div></div><div class="row"><div class="col-md-6"><div class="mb-3"><label for="startTime" class="form-label">Start Time *</label><input type="time" class="form-control" id="startTime" name="startTime" required></div></div><div class="col-md-6"><div class="mb-3"><label for="endTime" class="form-label">End Time *</label><input type="time" class="form-control" id="endTime" name="endTime" required></div></div></div><div class="mb-3"><label for="expectedAttendees" class="form-label">Expected Attendees *</label><input type="number" class="form-control" id="expectedAttendees" name="expectedAttendees" required min="1"></div><div class="mb-3"><label for="venuePreference" class="form-label">Venue Preference</label><select class="form-select" id="venuePreference" name="venueId"><option value="">Let system suggest best venue</option><c:forEach var="venue" items="${availableVenuesList}"><option value="${venue.venueID}">${venue.venueName} (${venue.capacity} capacity)</option></c:forEach></select></div><div class="mb-3"><label for="bookingPurpose" class="form-label">Purpose *</label><textarea class="form-control" id="bookingPurpose" name="purpose" rows="3" required></textarea></div></div><div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><button type="submit" class="btn btn-primary"><i class="fas fa-calendar-check me-2"></i>Submit Request</button></div></form></div></div></div>

    <div class="modal fade" id="bookingHistoryModal" tabindex="-1"><div class="modal-dialog modal-xl"><div class="modal-content"><div class="modal-header"><h5 class="modal-title"><i class="fas fa-history me-2"></i>My Booking History</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body"><div id="bookingHistoryList"><c:choose><c:when test="${not empty bookingHistory}"><c:forEach var="booking" items="${bookingHistory}"><div class="booking-history-card"><div class="row align-items-center"><div class="col-md-2 text-center"><div class="h5 mb-0"><fmt:formatDate value="${booking.bookingDate}" pattern="dd"/></div><small class="text-muted"><fmt:formatDate value="${booking.bookingDate}" pattern="MMM yyyy"/></small></div><div class="col-md-5"><h6 class="mb-1">${booking.venueName}</h6><p class="text-muted mb-0"><i class="fas fa-clock me-1"></i> <fmt:formatDate value="${booking.startTime}" pattern="hh:mm a"/> - <fmt:formatDate value="${booking.endTime}" pattern="hh:mm a"/></p></div><div class="col-md-2"><span class="booking-status status-${fn:toLowerCase(booking.status)}">${booking.status}</span></div><div class="col-md-3"><div class="d-grid gap-2 d-md-flex"><button class="btn btn-outline-primary btn-sm" onclick="viewBookingDetails(${booking.bookingID})"><i class="fas fa-eye"></i> View</button><c:if test="${booking.status == 'confirmed' && booking.bookingDate.time > currentDate.time}"><button class="btn btn-outline-danger btn-sm" onclick="cancelBooking(${booking.bookingID})"><i class="fas fa-times"></i> Cancel</button></c:if></div></div></div></div></c:forEach></c:when><c:otherwise><div class="text-center py-5"><i class="fas fa-calendar-times fa-3x text-muted mb-3"></i><h5>No Booking History</h5><p>You haven't made any venue bookings yet.</p></div></c:otherwise></c:choose></div></div></div></div></div>
    
    <div class="modal fade" id="venueDetailsModal" tabindex="-1"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h5 class="modal-title" id="venueDetailsTitle"></h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body" id="venueDetailsContent"></div><div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button><button type="button" class="btn btn-primary" id="bookFromDetailsBtn"><i class="fas fa-calendar-plus me-2"></i>Book This Venue</button></div></div></div></div>
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055"><div id="alertContainer"></div></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function clearFilters() { window.location.href = '${pageContext.request.contextPath}/organization?action=venues'; }
        function bookVenue(venueId, venueName) { document.getElementById('venuePreference').value = venueId; new bootstrap.Modal(document.getElementById('quickBookModal')).show(); }
        function viewSchedule(venueId) { window.location.href = '${pageContext.request.contextPath}/organization?action=venueSchedule&venueId=' + venueId; }
        function viewBookingDetails(bookingId) { window.location.href = '${pageContext.request.contextPath}/organization?action=viewBooking&bookingId=' + bookingId; }

        function viewVenueDetails(venueId) {
            fetch('${pageContext.request.contextPath}/organization?action=getVenueDetails&venueId=' + venueId)
                .then(response => { if (!response.ok) throw new Error('Network response was not ok'); return response.json(); })
                .then(data => {
                    document.getElementById('venueDetailsTitle').textContent = data.venueName;
                    document.getElementById('venueDetailsContent').innerHTML = generateVenueDetailsHTML(data);
                    document.getElementById('bookFromDetailsBtn').onclick = () => bookVenue(data.venueID, data.venueName);
                    new bootstrap.Modal(document.getElementById('venueDetailsModal')).show();
                }).catch(err => showAlert('Failed to load venue details.', 'danger'));
        }

        function generateVenueDetailsHTML(venue) { /* ... same as before ... */ }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                const formData = new FormData();
                formData.append('bookingId', bookingId);
                formData.append('type', 'venue');
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
            setTimeout(() => wrapper.remove(), 5000);
        }
    </script>
</body>
</html>