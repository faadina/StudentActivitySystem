<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Activity Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.2s ease-in-out;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .stat-card.success {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        .stat-card.warning {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }
        .stat-card.info {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #333;
        }
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .recent-activity {
            max-height: 400px;
            overflow-y: auto;
        }
        .activity-item {
            border-left: 4px solid #3498db;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .activity-item.user {
            border-left-color: #2ecc71;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="dashboard"/>
                </jsp:include>
            </div>
            
            <div class="col-md-10 main-content">
                <div class="p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="mb-1">Welcome back, ${sessionScope.userName}!</h2>
                            <p class="text-muted mb-0">Here's what's happening with your system today.</p>
                        </div>
                        <div class="text-end">
                            <small class="text-muted">Last update: </small>
                            <small class="fw-bold"><fmt:formatDate value="${user.updatedAt}" pattern="MMM dd, yyyy HH:mm"/></small>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="row mb-4">
                        <div class="col-md-4 mb-3">
                            <div class="card dashboard-card stat-card">
                                <div class="card-body text-center">
                                    <i class="fas fa-users fa-2x mb-3"></i>
                                    <h3 class="mb-1">${totalUsers}</h3>
                                    <p class="mb-0">Total Users</p>
                                    <small class="opacity-75">
                                        <i class="fas fa-user-graduate"></i> ${totalStudents} Students |
                                        <i class="fas fa-user-tie"></i> ${totalStaff} Staff |
                                        <i class="fas fa-building"></i> ${totalOrganizations} Orgs
                                    </small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <div class="card dashboard-card stat-card success">
                                <div class="card-body text-center">
                                    <i class="fas fa-calendar-check fa-2x mb-3"></i>
                                    <h3 class="mb-1">${totalEvents}</h3>
                                    <p class="mb-0">Total Events</p>
                                    <small class="opacity-75">
                                        <c:if test="${pendingApprovals > 0}">
                                            <i class="fas fa-clock text-warning"></i> ${pendingApprovals} Pending
                                        </c:if>
                                        <c:if test="${pendingApprovals == 0}">
                                            <i class="fas fa-check"></i> All Approved
                                        </c:if>
                                    </small>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-md-4 mb-3">
                            <div class="card dashboard-card stat-card info">
                                <div class="card-body text-center">
                                    <i class="fas fa-exclamation-circle fa-2x mb-3"></i>
                                    <h3 class="mb-1">${pendingApprovals}</h3>
                                    <p class="mb-0">Pending Approvals</p>
                                    <small>
                                        <c:if test="${pendingApprovals > 0}">
                                            <i class="fas fa-arrow-right"></i> 
                                            <a href="admin?action=events&status=pending" class="text-decoration-none">
                                                Review Now
                                            </a>
                                        </c:if>
                                        <c:if test="${pendingApprovals == 0}">
                                            <i class="fas fa-check text-success"></i> All Clear
                                        </c:if>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8 mb-4">
                            <div class="card dashboard-card">
                                <div class="card-header bg-white">
                                    <h5 class="card-title mb-0">
                                        <i class="fas fa-calendar-alt me-2"></i>Recent Events
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty recentEvents}">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Event Name</th>
                                                        <th>Date</th>
                                                        <th>Status</th>
                                                        <th>Registrations</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="event" items="${recentEvents}">
                                                        <tr>
                                                            <td>
                                                                <strong>${event.eventTitle}</strong>
                                                                <br><small class="text-muted">${event.eventCategory}</small>
                                                            </td>
                                                            <td>
                                                                <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy"/>
                                                                <br><small class="text-muted">
                                                                    <fmt:formatDate value="${event.eventTime}" pattern="HH:mm"/>
                                                                </small>
                                                            </td>
                                                            <td>
                                                                <span class="badge bg-success">${event.eventStatus}</span>
                                                            </td>
                                                            <td>
                                                                <span class="badge bg-info">${event.registeredCount}/${event.participantLimit}</span>
                                                            </td>
                                                            <td>
                                                                <div class="btn-group btn-group-sm">
                                                                    <button class="btn btn-outline-primary btn-sm" onclick="viewEvent('${event.eventID}')">
                                                                        <i class="fas fa-eye"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-4">
                            <div class="card dashboard-card">
                                <div class="card-header bg-white">
                                    <h5 class="card-title mb-0">
                                        <i class="fas fa-user-plus me-2"></i>Recent Users
                                    </h5>
                                </div>
                                <div class="card-body recent-activity">
                                    <c:if test="${not empty recentUsers}">
                                        <c:forEach var="user" items="${recentUsers}">
                                            <div class="activity-item user">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-1">${user.userName}</h6>
                                                        <p class="mb-1 text-muted small">${user.userEmail}</p>
                                                        <span class="badge badge-sm bg-${user.userRole == 'student' ? 'info' : user.userRole == 'staff' ? 'success' : 'warning'}">
                                                            ${user.userRole}
                                                        </span>
                                                    </div>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${user.createdAt}" pattern="MMM dd"/>
                                                    </small>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewEvent(eventId) {
            window.location.href = 'admin?action=viewEvent&eventId=' + eventId;
        }

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>