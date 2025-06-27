<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: none; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="profile"/></jsp:include>
        </div>

        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <h2 class="mb-4">My Profile</h2>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="success" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <form action="staff" method="post" id="profileForm">
                <input type="hidden" name="action" value="updateProfile">
                <div class="row">
                    <div class="col-lg-7 mb-4">
                        <div class="card h-100">
                            <div class="card-body p-4">
                                <h5 class="card-title">Personal Information</h5><hr>
                                <div class="mb-3">
                                    <label class="form-label">User ID</label>
                                    <input type="text" class="form-control" value="${user.userID}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" value="${user.userEmail}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label for="userName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="userPhoneNo" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="userPhoneNo" name="userPhoneNo" value="${user.userPhoneNo}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 mb-4">
                        <div class="card h-100">
                            <div class="card-body p-4">
                                <h5 class="card-title">Change Password</h5><hr>
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label">Current Password</label>
                                    <input type="password" class="form-control" name="currentPassword" id="currentPassword">
                                </div>
                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input type="password" class="form-control" name="newPassword" id="newPassword">
                                </div>
                                <p class="form-text text-muted small">Leave these fields blank if you do not wish to change your password.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <button type="submit" class="btn btn-primary px-5 py-2">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>