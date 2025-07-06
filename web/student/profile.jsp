<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="studentSidebar.jsp"><jsp:param name="active" value="profile"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <h2 class="mb-4">My Profile</h2>
             <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>
            <div class="card">
                <div class="card-body">
                    <form action="student" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="mb-3">
                            <label for="userID" class="form-label">Student ID</label>
                            <input type="text" class="form-control" id="userID" value="${user.userID}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="userName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="userEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="userPhoneNo" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="userPhoneNo" name="userPhoneNo" value="${user.userPhoneNo}">
                        </div>
                        <hr>
                        <h5>Change Password</h5>
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Current Password</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>