<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); }
        .stat-card { color: #fff; }
        .stat-card-orange { background: linear-gradient(45deg, #fd7e14, #ffc107); }
        .stat-card-purple { background: linear-gradient(45deg, #6D5BBA, #8E44AD); }
        .stat-card-teal { background: linear-gradient(45deg, #48D1CC, #20C997); }
        .nav-pills .nav-link.active { background-color: #6D5BBA; color: white; }
        .list-group-item-action:hover { background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="dashboard"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="mb-1">Dashboard</h2>
                    <p class="text-muted">Welcome back, ${sessionScope.userName}!</p>
                </div>
            </div>
            <div class="row g-4 mb-4">
                <div class="col-md-4"><div class="card stat-card stat-card-orange"><div class="card-body text-center p-4"><i class="fas fa-hourglass-half fa-2x mb-2"></i><h3>${pendingApprovals}</h3><p class="mb-0">Pending Approvals</p></div></div></div>
                <div class="col-md-4"><div class="card stat-card stat-card-purple"><div class="card-body text-center p-4"><i class="fas fa-building fa-2x mb-2"></i><h3>${totalVenues}</h3><p class="mb-0">Venues Managed</p></div></div></div>
                <div class="col-md-4"><div class="card stat-card stat-card-teal"><div class="card-body text-center p-4"><i class="fas fa-box fa-2x mb-2"></i><h3>${totalResources}</h3><p class="mb-0">Resources Managed</p></div></div></div>
            </div>
            <div class="card">
                <div class="card-header bg-white">
                    <ul class="nav nav-pills"><li class="nav-item"><button class="nav-link active" data-bs-toggle="pill" data-bs-target="#pills-venue">Venue Bookings (${pendingVenueBookings.size()})</button></li><li class="nav-item"><button class="nav-link" data-bs-toggle="pill" data-bs-target="#pills-resource">Resource Bookings (${pendingResourceBookings.size()})</button></li></ul>
                </div>
                <div class="card-body"><div class="tab-content">
                    <div class="tab-pane fade show active" id="pills-venue"><div class="list-group list-group-flush">
                        <c:if test="${empty pendingVenueBookings}"><p class="text-center p-3 text-muted">No pending venue bookings.</p></c:if>
                        <c:forEach var="b" items="${pendingVenueBookings}"><a href="staff?action=venueBookings" class="list-group-item list-group-item-action">${b.venueName} <span class="small text-muted">- by ${b.userName}</span></a></c:forEach>
                    </div></div>
                    <div class="tab-pane fade" id="pills-resource"><div class="list-group list-group-flush">
                        <c:if test="${empty pendingResourceBookings}"><p class="text-center p-3 text-muted">No pending resource bookings.</p></c:if>
                        <c:forEach var="b" items="${pendingResourceBookings}"><a href="staff?action=resourceBookings" class="list-group-item list-group-item-action">${b.resourceName} (x${b.quantity}) <span class="small text-muted">- by ${b.userName}</span></a></c:forEach>
                    </div></div>
                </div></div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>