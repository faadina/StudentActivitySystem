<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .card-header { background-color: #fff; border-bottom: 1px solid #e3e6f0; }
        .table-hover tbody tr:hover { background-color: #f2f2f2; }
        .badge-status { font-size: 0.8rem; padding: 0.4em 0.7em; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="users"/>
                </jsp:include>
            </div>

            <div class="col-md-10 main-content">
                <div class="p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="mb-0">User Management (Staff & Organizations)</h2>
                        <a href="admin?action=addUser" class="btn btn-primary">
                            <i class="fas fa-user-plus me-2"></i>Add New User
                        </a>
                    </div>
                    
                     <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>

                    <div class="card shadow-sm">
                        <div class="card-header"><h5 class="mb-0">System Users</h5></div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>User ID</th>
                                            <th>Name</th>
                                            <th>Contact</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Joined On</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${users}">
                                            <tr>
                                                <td><span class="font-monospace">${user.userID}</span></td>
                                                <td><strong>${user.userName}</strong></td>
                                                <td>
                                                    <c:out value="${user.userEmail}"/><br>
                                                    <small class="text-muted">${user.userPhoneNo}</small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.userRole == 'organization'}"><span class="badge bg-warning text-dark">Organization</span></c:when>
                                                        <c:when test="${user.userRole == 'staff'}"><span class="badge bg-success">Staff</span></c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.userStatus == 'active'}"><span class="badge badge-status bg-light text-success border border-success">Active</span></c:when>
                                                        <c:otherwise><span class="badge badge-status bg-light text-danger border border-danger">Inactive</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><fmt:formatDate value="${user.createdAt}" pattern="dd MMM, yyyy"/></td>
                                                <td>
                                                     <form action="admin" method="post" onsubmit="return confirm('Are you sure you want to change this user\'s status?');" class="d-inline">
                                                        <input type="hidden" name="action" value="updateUserStatus">
                                                        <input type="hidden" name="userIdToUpdate" value="${user.userID}">
                                                        <c:choose>
                                                            <c:when test="${user.userStatus == 'active'}">
                                                                <input type="hidden" name="newStatus" value="inactive">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Deactivate User"><i class="fas fa-toggle-off"></i> Deactivate</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="hidden" name="newStatus" value="active">
                                                                <button type="submit" class="btn btn-sm btn-outline-success" title="Activate User"><i class="fas fa-toggle-on"></i> Activate</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty users}">
                                            <tr><td colspan="7" class="text-center">No staff or organization users found.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>