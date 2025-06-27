<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Reports - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f0f2f5; min-height: 100vh; }
        .stat-card {
            background: white; 
            border: none; 
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-icon { font-size: 2rem; }
        .progress { height: 10px; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="systemReports"/>
                </jsp:include>
            </div>

            <div class="col-md-10 main-content">
                <div class="p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="mb-1">System Overview & Reports</h2>
                            <p class="text-muted mb-0">Live data analysis and downloadable reports.</p>
                        </div>
                        <a href="admin?action=downloadReport" class="btn btn-primary">
                            <i class="fas fa-download me-2"></i>Download Report
                        </a>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-4">
                            <div class="stat-card p-3">
                                <div class="d-flex align-items-center">
                                    <div class="stat-icon text-primary me-3"><i class="fas fa-users"></i></div>
                                    <div>
                                        <h4 class="mb-0">${totalUsers}</h4>
                                        <span class="text-muted">Total Users</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="stat-card p-3">
                                <div class="d-flex align-items-center">
                                    <div class="stat-icon text-success me-3"><i class="fas fa-calendar-check"></i></div>
                                    <div>
                                        <h4 class="mb-0">${totalEvents}</h4>
                                        <span class="text-muted">Total Events</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                             <div class="stat-card p-3">
                                <div class="d-flex align-items-center">
                                    <div class="stat-icon text-info me-3"><i class="fas fa-building"></i></div>
                                    <div>
                                        <h4 class="mb-0">${totalVenueBookings}</h4>
                                        <span class="text-muted">Venue Bookings</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="stat-card p-3">
                                <div class="d-flex align-items-center">
                                    <div class="stat-icon text-warning me-3"><i class="fas fa-box"></i></div>
                                    <div>
                                        <h4 class="mb-0">${totalResourceBookings}</h4>
                                        <span class="text-muted">Resource Bookings</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="mb-0">User Distribution</h5>
                                </div>
                                <div class="card-body">
                                    <c:forEach var="entry" items="${userRoleDistribution}">
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <span>${entry.key}</span>
                                                <span>${entry.value} users (<fmt:formatNumber value="${(entry.value / totalUsers) * 100}" maxFractionDigits="1"/>%)</span>
                                            </div>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${(entry.value / totalUsers) * 100}%" aria-valuenow="${(entry.value / totalUsers) * 100}" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 mb-4">
                             <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="mb-0">Event Categories</h5>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group list-group-flush">
                                        <c:forEach var="entry" items="${eventCategoryDistribution}">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                ${entry.key}
                                                <span class="badge bg-primary rounded-pill">${entry.value}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
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