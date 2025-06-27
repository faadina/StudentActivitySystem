<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resource Bookings - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: none; }
        .nav-pills .nav-link.active { background-color: #6D5BBA; color: white; }
        .table-hover tbody tr:hover { background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="resourceBookings"/></jsp:include>
        </div>

        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <h2 class="mb-4">Manage Resource Bookings</h2>
            
            <c:if test="${not empty sessionScope.success}"><div class="alert alert-success alert-dismissible fade show">${sessionScope.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="success" scope="session" /></c:if>
            <c:if test="${not empty sessionScope.error}"><div class="alert alert-danger alert-dismissible fade show">${sessionScope.error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="error" scope="session" /></c:if>

            <div class="card">
                <div class="card-header bg-white">
                    <ul class="nav nav-pills">
                        <li class="nav-item"><a class="nav-link ${empty param.filter || param.filter == 'pending' ? 'active' : ''}" href="staff?action=resourceBookings&filter=pending">Pending</a></li>
                        <li class="nav-item"><a class="nav-link ${param.filter == 'confirmed' ? 'active' : ''}" href="staff?action=resourceBookings&filter=confirmed">Confirmed</a></li>
                        <li class="nav-item"><a class="nav-link ${param.filter == 'rejected' ? 'active' : ''}" href="staff?action=resourceBookings&filter=rejected">Rejected</a></li>
                        <li class="nav-item"><a class="nav-link ${param.filter == 'returned' ? 'active' : ''}" href="staff?action=resourceBookings&filter=returned">Returned</a></li>
                    </ul>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Resource (Qty)</th>
                                    <th>Event</th>
                                    <th>Booked By</th>
                                    <th>Borrow Date</th>
                                    <th>Return Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty bookings}"><td colspan="8" class="text-center p-4 text-muted">No resource bookings for this status.</td></c:if>
                                <c:forEach var="b" items="${bookings}">
                                    <tr>
                                        <td>#${b.bookingID}</td>
                                        <td><strong>${b.resourceName}</strong> (x${b.quantity})</td>
                                        <td>${b.eventName}</td>
                                        <td>${b.userName}</td>
                                        <td><fmt:formatDate value="${b.borrowDate}" pattern="dd MMM, yyyy"/></td>
                                        <td><fmt:formatDate value="${b.returnDate}" pattern="dd MMM, yyyy"/></td>
                                        <td><span class="badge ${b.status == 'confirmed' ? 'bg-success' : b.status == 'pending' ? 'bg-warning text-dark' : 'bg-danger'}">${b.status}</span></td>
                                        <td>
                                            <c:if test="${b.status == 'pending'}">
                                                <div class="btn-group btn-group-sm">
                                                    <form method="POST" action="staff" class="d-inline" onsubmit="return confirm('Approve this booking?');">
                                                        <input type="hidden" name="action" value="approveResourceBooking">
                                                        <input type="hidden" name="bookingId" value="${b.bookingID}">
                                                        <input type="hidden" name="currentFilter" value="${currentFilter}">
                                                        <button type="submit" class="btn btn-success" title="Approve"><i class="fas fa-check"></i></button>
                                                    </form>
                                                    <button class="btn btn-danger" title="Reject" onclick="openRejectModal(${b.bookingID})"><i class="fas fa-times"></i></button>
                                                </div>
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

<div class="modal fade" id="rejectModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="rejectForm" method="post" action="staff">
                <div class="modal-header"><h5 class="modal-title">Reason for Rejection</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="rejectResourceBooking">
                    <input type="hidden" name="bookingId" id="rejectBookingId">
                    <input type="hidden" name="currentFilter" value="${currentFilter}">
                    <textarea class="form-control" name="reason" placeholder="Please provide a reason for rejection..." required></textarea>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><button type="submit" class="btn btn-danger">Confirm Rejection</button></div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openRejectModal(bookingId) {
        document.getElementById('rejectBookingId').value = bookingId;
        new bootstrap.Modal(document.getElementById('rejectModal')).show();
    }
</script>
</body>
</html>