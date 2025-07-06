<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Resource Management - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-color: #f4f7f6;
        }
        .resource-item {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 0.75rem;
            box-shadow: 0 1px 6px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>
<div class="d-flex" style="height: 100vh; overflow: hidden;">
    <div class="col-md-3 col-lg-2 p-0 h-100">
        <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="resourceManagement"/></jsp:include>
    </div>

    <div class="col-md-9 col-lg-10 p-3 overflow-auto" style="height: 100vh;">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">Resource Management</h2>
            <a href="staff?action=showAddResourceForm" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Resource
            </a>
        </div>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible">${sessionScope.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            <c:remove var="success" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible">${sessionScope.error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            <c:remove var="error" scope="session" />
        </c:if>

        <c:if test="${empty resources}">
            <p>No resources found.</p>
        </c:if>
        <c:forEach var="res" items="${resources}">
            <div class="resource-item">
                <div class="d-flex justify-content-between">
                    <div>
                        <h5>${res.resourceName}</h5>
                        <p class="text-muted small mb-1"><i class="fas fa-tag me-2"></i>${res.category}</p>
                        <p class="text-muted small mb-2">
                            <i class="fas fa-boxes me-1"></i> ${res.availableQuantity} / ${res.totalQuantity} Available
                        </p>
                        <span class="badge ${res.condition == 'Good' ? 'bg-success' : 'bg-warning'}">${res.condition}</span>
                    </div>
                    <div class="text-end">
                        <a href="staff?action=showEditResourceForm&resourceId=${res.resourceID}" class="btn btn-outline-primary btn-sm mb-2">
                            <i class="fas fa-pencil-alt me-1"></i>Edit
                        </a>
                        <form action="staff" method="post" onsubmit="return confirm('Delete this resource?');">
                            <input type="hidden" name="action" value="deleteResource">
                            <input type="hidden" name="resourceId" value="${res.resourceID}">
                            <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                                <i class="fas fa-trash me-1"></i>Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>