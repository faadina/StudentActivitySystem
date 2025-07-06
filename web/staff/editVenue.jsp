<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Venue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 p-0">
            <jsp:include page="staffSidebar.jsp">
                <jsp:param name="active" value="venueManagement"/>
            </jsp:include>
        </div>
        <div class="col-md-10 py-4 px-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Edit Venue: ${venue.venueName}</h2>
                <a href="staff?action=venueManagement" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Back to List
                </a>
            </div>
            
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <form action="staff" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="updateVenue">
                        <input type="hidden" name="venueID" value="${venue.venueID}">
                        <input type="hidden" name="imageUrl" value="${venue.imageUrl}">
                        
                        <div class="row g-3">
                            <!-- Basic Information -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label required-field">Venue Name</label>
                                    <input type="text" class="form-control" name="venueName" 
                                           value="${venue.venueName}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label required-field">Building</label>
                                    <input type="text" class="form-control" name="building" 
                                           value="${venue.building}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Floor</label>
                                    <input type="text" class="form-control" name="floor" 
                                           value="${venue.floor}">
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label required-field">Venue Type</label>
                                    <select class="form-select" name="venueType" required>
                                        <option value="Hall" ${venue.venueType eq 'Hall' ? 'selected' : ''}>Hall</option>
                                        <option value="Room" ${venue.venueType eq 'Room' ? 'selected' : ''}>Room</option>
                                        <option value="Auditorium" ${venue.venueType eq 'Auditorium' ? 'selected' : ''}>Auditorium</option>
                                        <option value="Lab" ${venue.venueType eq 'Lab' ? 'selected' : ''}>Lab</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label required-field">Capacity</label>
                                    <input type="number" class="form-control" name="capacity" 
                                           value="${venue.capacity}" min="1" required>
                                     <div class="invalid-feedback">Please enter a valid capacity (minimum 1)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label required-field">Price (RM)</label>
                                    <input type="number" step="0.01" class="form-control" name="price" 
                                           value="${venue.price}" min="0" required>
                                     <div class="invalid-feedback">Please enter a valid price</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3">${venue.description}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Facilities</label>
                            <input type="text" class="form-control" name="facilities" 
                                   value="${fn:join(venue.facilities, ', ')}">
                            <div class="form-text">Separate multiple facilities with commas (e.g., Projector, WiFi, Whiteboard)</div>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label">Venue Image</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*">
                            <c:if test="${not empty venue.imageUrl}">
                                <div class="mt-2">
                                    <img src="${pageContext.request.contextPath}/${venue.imageUrl}" 
                                         alt="Current Venue Image" class="img-thumbnail" style="max-height: 150px;">
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Availability</label>
                            <select class="form-select" name="availability">
                                <option value="available" ${venue.availability eq 'available' ? 'selected' : ''}>Available</option>
                                <option value="unavailable" ${venue.availability eq 'unavailable' ? 'selected' : ''}>Unavailable</option>
                                <option value="maintenance" ${venue.availability eq 'maintenance' ? 'selected' : ''}>Under Maintenance</option>
                            </select>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" 
                                    data-bs-target="#deleteModal">
                                Delete Venue
                            </button>
                            <div>
                                <a href="staff?action=venueManagement" class="btn btn-secondary me-2">Cancel</a>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this venue? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="staff" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="deleteVenue">
                    <input type="hidden" name="venueId" value="${venue.venueID}">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">
                        // Client-side form validation
document.querySelector('form').addEventListener('submit', function(event) {
    const form = event.target;
    const capacity = form.elements['capacity'].value;
    const price = form.elements['price'].value;
    
    if (!capacity || !price) {
        event.preventDefault();
        alert('Please fill all required fields');
        return false;
    }
    
    if (isNaN(capacity) || capacity < 1) {
        event.preventDefault();
        alert('Capacity must be at least 1');
        return false;
    }
    
    if (isNaN(price) || price < 0) {
        event.preventDefault();
        alert('Price must be a positive number');
        return false;
    }
});
</script>
</body>
</html>