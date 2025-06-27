<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Venue Management - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .venue-card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: all 0.3s ease; border: none; overflow: hidden; }
        .venue-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .venue-image { height: 180px; background-size: cover; background-position: center; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="venueManagement"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Venue Management</h2>
                <a href="staff?action=showAddVenueForm" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add New Venue</a>
            </div>
            
            <c:if test="${not empty sessionScope.success}"><div class="alert alert-success alert-dismissible fade show">${sessionScope.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="success" scope="session" /></c:if>
            <c:if test="${not empty sessionScope.error}"><div class="alert alert-danger alert-dismissible fade show">${sessionScope.error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="error" scope="session" /></c:if>

            <div class="row">
                <c:if test="${empty venues}"><div class="col-12 text-center p-5"><p>No venues found. Click 'Add New Venue' to begin.</p></div></c:if>
                <c:forEach var="venue" items="${venues}">
                    <div class="col-lg-6 col-xl-4 mb-4">
                        <div class="venue-card">
                            <div class="venue-image" style="background-image: url('${not empty venue.imageUrl ? venue.imageUrl : 'https://via.placeholder.com/400x250.png?text=No+Image'}')"></div>
                            <div class="card-body">
                                <h5 class="card-title">${venue.venueName}</h5>
                                <p class="text-muted small mb-2"><i class="fas fa-map-marker-alt me-2"></i>${venue.building}, Floor ${venue.floor}</p>
                                <div class="d-flex justify-content-between text-muted mb-3">
                                    <span><i class="fas fa-users me-1"></i> ${venue.capacity} Pax</span>
                                    <span><span class="badge ${venue.availability == 'available' ? 'bg-success' : 'bg-danger'}">${venue.availability}</span></span>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="staff?action=showEditVenueForm&venueId=${venue.venueID}" class="btn btn-outline-primary btn-sm w-100"><i class="fas fa-pencil-alt me-1"></i>Edit</a>
                                    <form action="staff" method="post" onsubmit="return confirm('Are you sure you want to delete this venue?');" class="d-inline w-100">
                                        <input type="hidden" name="action" value="deleteVenue">
                                        <input type="hidden" name="venueId" value="${venue.venueID}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm w-100"><i class="fas fa-trash me-1"></i>Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>