<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Resource - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="resourceManagement"/></jsp:include>
        </div>

        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex align-items-center mb-4">
                <a href="staff?action=resourceManagement" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
                <h2 class="mb-0">Edit Resource: ${resource.resourceName}</h2>
            </div>

            <div class="card">
                <div class="card-body p-4">
                    <form action="staff" method="post">
                        <input type="hidden" name="action" value="updateResource">
                        <input type="hidden" name="resourceID" value="${resource.resourceID}">

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label for="resourceName" class="form-label">Resource Name*</label>
                                <input type="text" class="form-control" id="resourceName" name="resourceName" value="${resource.resourceName}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="category" class="form-label">Category*</label>
                                <input type="text" class="form-control" id="category" name="category" value="${resource.category}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="location" class="form-label">Location*</label>
                                <input type="text" class="form-control" id="location" name="location" value="${resource.location}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="totalQuantity" class="form-label">Total Quantity*</label>
                                <input type="number" class="form-control" id="totalQuantity" name="totalQuantity" value="${resource.totalQuantity}" required min="1">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="condition" class="form-label">Condition*</label>
                                <select class="form-select" id="condition" name="condition" required>
                                    <option value="Good" ${resource.condition == 'Good' ? 'selected' : ''}>Good</option>
                                    <option value="Fair" ${resource.condition == 'Fair' ? 'selected' : ''}>Fair</option>
                                    <option value="Damaged" ${resource.condition == 'Damaged' ? 'selected' : ''}>Damaged</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="depositRequired" class="form-label">Deposit Required (RM)</label>
                                <input type="number" class="form-control" id="depositRequired" name="depositRequired" value="${resource.depositRequired}" step="0.01" min="0">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3">${resource.description}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="usageInstructions" class="form-label">Usage Instructions</label>
                            <textarea class="form-control" id="usageInstructions" name="usageInstructions" rows="3">${resource.usageInstructions}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="imageUrl" class="form-label">Image URL</label>
                            <input type="url" class="form-control" id="imageUrl" name="imageUrl" value="${resource.imageUrl}">
                        </div>

                        <div class="mt-4 text-end">
                            <a href="staff?action=resourceManagement" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>