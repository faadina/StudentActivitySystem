<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Resource Management - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .resource-card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: all 0.3s ease; border: none; overflow: hidden; }
        .resource-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .resource-image { height: 180px; background-size: cover; background-position: center; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="resourceManagement"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Resource Management</h2>
                <a href="staff?action=showAddResourceForm" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add New Resource</a>
            </div>
            
            <c:if test="${not empty sessionScope.success}"><div class="alert alert-success alert-dismissible">${sessionScope.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="success" scope="session" /></c:if>
            <c:if test="${not empty sessionScope.error}"><div class="alert alert-danger alert-dismissible">${sessionScope.error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><c:remove var="error" scope="session" /></c:if>

            <div class="row">
                <c:if test="${empty resources}"><div class="col-12 text-center p-5"><p>No resources found.</p></div></c:if>
                <c:forEach var="res" items="${resources}">
                    <div class="col-lg-6 col-xl-4 mb-4">
                        <div class="resource-card">
                            <div class="resource-image" style="background-image: url('${not empty res.imageUrl ? res.imageUrl : 'https://via.placeholder.com/400x250.png?text=No+Image'}')"></div>
                            <div class="card-body">
                                <h5 class="card-title">${res.resourceName}</h5>
                                <p class="text-muted small mb-2"><i class="fas fa-tag me-2"></i>${res.category}</p>
                                <div class="d-flex justify-content-between text-muted mb-3">
                                    <span><i class="fas fa-boxes me-1"></i> ${res.availableQuantity} / ${res.totalQuantity} Available</span>
                                    <span><span class="badge ${res.condition == 'Good' ? 'bg-success' : 'bg-warning'}">${res.condition}</span></span>
                                </div>
                                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                    <a href="staff?action=showEditResourceForm&resourceId=${res.resourceID}" class="btn btn-outline-primary btn-sm"><i class="fas fa-pencil-alt me-1"></i>Edit</a>
                                    <form action="staff" method="post" onsubmit="return confirm('Delete this resource?');" class="d-inline w-100">
                                        <input type="hidden" name="action" value="deleteResource">
                                        <input type="hidden" name="resourceId" value="${res.resourceID}">
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