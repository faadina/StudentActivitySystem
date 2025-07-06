<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organization Dashboard - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        /* Smaller Stats Cards */
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 1.5rem 1rem;
            height: 140px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255,255,255,0.1) 0%, transparent 100%);
            pointer-events: none;
        }
        
        .stat-card-warning {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            color: white;
            text-align: center;
            padding: 1.5rem 1rem;
            height: 140px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card-warning::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255,255,255,0.1) 0%, transparent 100%);
            pointer-events: none;
        }
        
        .stat-card-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            text-align: center;
            padding: 1.5rem 1rem;
            height: 140px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card-success::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255,255,255,0.1) 0%, transparent 100%);
            pointer-events: none;
        }
        
        .stat-card i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }
        
        .stat-card h2 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.25rem;
            position: relative;
            z-index: 1;
        }
        
        .stat-card p {
            font-size: 0.9rem;
            margin: 0;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }
        
        /* Events Section with Pagination */
        .events-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            height: 600px;
            display: flex;
            flex-direction: column;
        }
        
        .events-content {
            flex: 1;
            overflow-y: auto;
        }
        
        .event-item {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .event-item:hover {
            background: linear-gradient(135deg, #f8f9ff 0%, #e3f2fd 100%);
            transform: translateX(5px);
        }
        
        .event-item:last-child {
            border-bottom: none;
        }
        
        .event-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .event-detail {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.25rem;
            display: flex;
            align-items: center;
        }
        
        .event-detail i {
            width: 16px;
            text-align: center;
            margin-right: 0.5rem;
        }
        
        .badge {
            font-size: 0.75rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .dashboard-header {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .dashboard-header h1 {
            margin: 0;
            color: #333;
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .dashboard-header i {
            color: #667eea;
            margin-right: 0.5rem;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 1.5rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 1px solid #dee2e6;
            margin: 0;
        }
        
        .section-header h5 {
            margin: 0;
            font-weight: 600;
            color: #333;
        }
        
        .section-header i {
            color: #667eea;
            margin-right: 0.5rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 20px;
            padding: 0.5rem 1.25rem;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }
        
        /* Pagination Styles */
        .pagination-container {
            padding: 1rem 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: between;
            align-items: center;
        }
        
        .pagination-info {
            font-size: 0.9rem;
            color: #666;
        }
        
        .pagination {
            margin: 0;
        }
        
        .page-link {
            color: #667eea;
            border: 1px solid #dee2e6;
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
            border-radius: 8px;
            margin: 0 2px;
            transition: all 0.3s ease;
        }
        
        .page-link:hover {
            background: #667eea;
            color: white;
            transform: translateY(-1px);
        }
        
        .page-item.active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
        }
        
        .page-item.disabled .page-link {
            opacity: 0.5;
        }
        
        .no-events {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 400px;
            color: #6c757d;
        }
        
        .no-events i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        @media (max-width: 768px) {
            .stat-card {
                padding: 1.25rem 1rem;
                height: 120px;
            }
            
            .stat-card h2 {
                font-size: 1.5rem;
            }
            
            .stat-card i {
                font-size: 1.5rem;
            }
            
            .main-content {
                margin: 10px;
                padding: 20px;
            }
            
            .events-container {
                height: 500px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Include your existing sidebar -->
        <jsp:include page="organizationSidebar.jsp" />
        
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10">
            <div class="container-fluid p-4">
                <!-- Dashboard Header -->
                <div class="dashboard-header">
                    <h1>
                        <i class="fas fa-tachometer-alt"></i>
                        Organization Dashboard
                    </h1>
                </div>

                <!-- Statistics Cards (Smaller) -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card">
                            <i class="fas fa-calendar-check"></i>
                            <h2>${activeEvents}</h2>
                            <p>Active Events</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card-warning">
                            <i class="fas fa-clock"></i>
                            <h2>${pendingEvents}</h2>
                            <p>Pending Approval</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card-success">
                            <i class="fas fa-folder-open"></i>
                            <h2>${totalEvents}</h2>
                            <p>Total Events Created</p>
                        </div>
                    </div>
                </div>

                <!-- My Recent Events with Pagination -->
                <div class="row">
                    <div class="col-12">
                        <div class="card events-container">
                            <div class="section-header">
                                <h5>
                                    <i class="fas fa-calendar-alt"></i>
                                    My Recent Events
                                </h5>
                                <a href="${pageContext.request.contextPath}/organization?action=events" 
                                   class="btn btn-primary">
                                    View All
                                </a>
                            </div>
                            
                            <div class="events-content">
                                <c:choose>
                                    <c:when test="${not empty myEvents}">
                                        <div id="eventsContainer">
                                            <c:forEach var="event" items="${myEvents}" varStatus="status">
                                                <div class="event-item" style="display: ${status.index < 5 ? 'block' : 'none'};">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div class="flex-grow-1">
                                                            <div class="event-title">${event.eventTitle}</div>
                                                            <div class="event-detail">
                                                                <i class="fas fa-calendar text-primary"></i>
                                                                <span>${event.eventDate}</span>
                                                            </div>
                                                            <div class="event-detail">
                                                                <i class="fas fa-clock text-primary"></i>
                                                                <span>${event.eventTime}</span>
                                                            </div>
                                                            <div class="event-detail">
                                                                <i class="fas fa-map-marker-alt text-danger"></i>
                                                                <span>${event.eventLocation}</span>
                                                            </div>
                                                        </div>
                                                        <div class="ms-3">
                                                            <c:choose>
                                                                <c:when test="${event.eventStatus == 'approved'}">
                                                                    <span class="badge bg-success">Approved</span>
                                                                </c:when>
                                                                <c:when test="${event.eventStatus == 'pending'}">
                                                                    <span class="badge bg-warning">Pending</span>
                                                                </c:when>
                                                                <c:when test="${event.eventStatus == 'rejected'}">
                                                                    <span class="badge bg-danger">Rejected</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${event.eventStatus}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-events">
                                            <i class="fas fa-calendar-plus"></i>
                                            <h5>No events yet</h5>
                                            <p class="mb-4">Create your first event to get started!</p>
                                            <a href="${pageContext.request.contextPath}/organization?action=createEvent" 
                                               class="btn btn-primary">
                                                <i class="fas fa-plus me-2"></i>Create Event
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${not empty myEvents}">
                                <div class="pagination-container">
                                    <div class="pagination-info">
                                        Showing <span id="currentStart">1</span> to <span id="currentEnd">5</span> 
                                        of <span id="totalEvents">${not empty myEvents ? fn:length(myEvents) : 0}</span> events
                                    </div>
                                    
                                    <nav>
                                        <ul class="pagination" id="pagination">
                                            <li class="page-item" id="prevPage">
                                                <a class="page-link" href="javascript:void(0)" onclick="changePage(-1)">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                            <li class="page-item active">
                                                <a class="page-link" href="javascript:void(0)" id="currentPageBtn">1</a>
                                            </li>
                                            <li class="page-item" id="nextPage">
                                                <a class="page-link" href="javascript:void(0)" onclick="changePage(1)">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Pagination functionality
    let currentPage = 1;
    const itemsPerPage = 5;
    const totalItems = document.querySelectorAll('.event-item').length;
    const totalPages = Math.ceil(totalItems / itemsPerPage);

    function showPage(page) {
        const events = document.querySelectorAll('.event-item');
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        
        events.forEach((event, index) => {
            if (index >= start && index < end) {
                event.style.display = 'block';
            } else {
                event.style.display = 'none';
            }
        });
        
        // Update pagination info
        document.getElementById('currentStart').textContent = start + 1;
        document.getElementById('currentEnd').textContent = Math.min(end, totalItems);
        document.getElementById('currentPageBtn').textContent = page;
        
        // Update pagination buttons
        document.getElementById('prevPage').classList.toggle('disabled', page === 1);
        document.getElementById('nextPage').classList.toggle('disabled', page === totalPages);
    }

    function changePage(direction) {
        const newPage = currentPage + direction;
        if (newPage >= 1 && newPage <= totalPages) {
            currentPage = newPage;
            showPage(currentPage);
        }
    }

    // Initialize pagination
    document.addEventListener('DOMContentLoaded', function() {
        if (totalItems > 0) {
            showPage(1);
        }
    });
</script>
</body>
</html>