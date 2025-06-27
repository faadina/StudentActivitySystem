<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Venue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid"><div class="row">
    <div class="col-md-2 p-0">
        <jsp:include page="staffSidebar.jsp">
            <jsp:param name="active" value="venueManagement"/>
        </jsp:include>
    </div>
    <div class="col-md-10" style="padding: 2rem;">
        <h2 class="mb-4">Edit Venue: ${venue.venueName}</h2>
        <div class="card"><div class="card-body p-4">
            <form action="staff" method="post">
                <input type="hidden" name="action" value="updateVenue">
                <input type="hidden" name="venueID" value="${venue.venueID}">
                <div class="mb-3">
                    <label class="form-label">Venue Name</label>
                    <input type="text" class="form-control" name="venueName" value="${venue.venueName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Building</label>
                    <input type="text" class="form-control" name="building" value="${venue.building}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Capacity</label>
                    <input type="number" class="form-control" name="capacity" value="${venue.capacity}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Facilities</label>
                    <input type="text" class="form-control" name="facilities" value="${fn:join(venue.facilities, ', ')}">
                    <%-- Text has been translated to English below --%>
                    <div class="form-text">Use a comma to separate (e.g., Projector, WiFi).</div>
                </div>
                <div class="mt-4 text-end">
                    <a href="staff?action=venueManagement" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div></div>
    </div>
</div></div>
</body>
</html>