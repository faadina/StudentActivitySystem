<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venue Booking - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --white: #ffffff;
            --dark-text: #2c3e50;
            --muted-text: #6c757d;
            --border-color: #dee2e6;
            
            --card-shadow: 0 4px 15px rgba(0,0,0,0.1);
            --card-hover-shadow: 0 8px 25px rgba(0,0,0,0.15);
            --button-shadow: 0 4px 12px rgba(0,0,0,0.15);
            --border-radius: 12px;
            --border-radius-lg: 15px;
            --border-radius-sm: 8px;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--dark-text);
        }

        .main-content {
            background-color: var(--light-bg);
            min-height: 100vh;
        }

        .page-header {
            background: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 20px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .page-header h2 {
            margin: 0;
            color: var(--dark-text);
            font-weight: 600;
        }

        .page-header p {
            margin: 0;
            color: var(--muted-text);
        }

        .page-header i {
            color: var(--primary-color);
        }

        /* Enhanced Statistics Cards */
        .stats-card {
            background: var(--primary-gradient);
            color: var(--white);
            text-align: center;
            padding: 1.5rem 1rem;
            height: 140px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
            border-radius: var(--border-radius);
            border: none;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-hover-shadow);
        }

        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255,255,255,0.1) 0%, transparent 100%);
            pointer-events: none;
        }

        .stats-card-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%);
        }

        .stats-card-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #fd7e14 100%);
        }

        .stats-card-info {
            background: linear-gradient(135deg, var(--info-color) 0%, #20c9e7 100%);
        }

        .stats-card i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .stats-card .stats-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.25rem;
            position: relative;
            z-index: 1;
        }

        .stats-card .stats-label {
            font-size: 0.9rem;
            margin: 0;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* Filter Section */
        .filter-section {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        /* Venue Cards Grid */
        .venue-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
        }

        .venue-card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
            position: relative;
            width: 350px;
            margin-bottom: 15px;
        }

        .venue-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }

        .venue-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .venue-card-body {
            padding: 20px;
        }

        .venue-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .venue-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .venue-type {
            background-color: #e9ecef;
            color: #495057;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .venue-location {
            color: var(--muted-text);
            font-size: 0.9rem;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }

        .venue-location i {
            margin-right: 8px;
            color: var(--danger-color);
        }

        .venue-capacity {
            color: var(--info-color);
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            font-weight: 500;
        }

        .venue-capacity i {
            margin-right: 8px;
        }

        .venue-facilities {
            margin-bottom: 15px;
        }

        .venue-facilities small {
            color: var(--muted-text);
            font-size: 0.85rem;
        }

        .venue-facilities i {
            color: var(--warning-color);
            margin-right: 5px;
        }

        /* Status Badge */
        .availability-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .availability-available {
            background-color: #d4edda;
            color: #155724;
        }

        .availability-booked {
            background-color: #f8d7da;
            color: #721c24;
        }

        .availability-maintenance {
            background-color: #fff3cd;
            color: #856404;
        }

        /* Action Buttons */
        .venue-action {
            width: 100%;
            padding: 12px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: block;
            font-size: 0.9rem;
        }

        .venue-action.primary {
            background: var(--primary-gradient);
            color: var(--white);
        }

        .venue-action.warning {
            background:var(--primary-gradient);
            color: var(--white);
        }

        .venue-action:hover {
            transform: translateY(-1px);
            box-shadow: var(--button-shadow);
            text-decoration: none;
            color: var(--white);
        }

        /* Buttons */
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 25px;
            padding: 0.5rem 1.25rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
            background: var(--primary-gradient);
        }

        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
            border-radius: 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            border-color: var(--primary-color);
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            border-radius: 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            transform: translateY(-1px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--muted-text);
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 5rem;
            margin-bottom: 30px;
            opacity: 0.3;
            color: var(--primary-color);
        }

        .empty-state h4 {
            color: var(--dark-text);
            margin-bottom: 15px;
        }

        /* Pagination */
        .pagination .page-link {
            color: var(--primary-color);
            border: 1px solid var(--border-color);
            padding: 0.5rem 0.8rem;
            font-size: 0.9rem;
            border-radius: 8px;
            margin: 0 2px;
            transition: all 0.3s ease;
        }

        .pagination .page-link:hover {
            background: var(--primary-color);
            color: var(--white);
            transform: translateY(-1px);
            border-color: var(--primary-color);
        }

        .pagination .page-item.active .page-link {
            background: var(--primary-gradient);
            border-color: var(--primary-color);
            color: var(--white);
        }

        .pagination .page-item.disabled .page-link {
            opacity: 0.5;
        }

        /* Modals */
        .modal-content {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .modal-header {
            background: var(--primary-gradient);
            color: var(--white);
            border-bottom: none;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .modal-header .btn-close {
            filter: invert(1);
        }

        .modal-title i {
            margin-right: 0.5rem;
        }

        /* Tables */
        .table {
            background: var(--white);
            border-radius: var(--border-radius-sm);
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }

        .table thead th {
            background: var(--primary-gradient);
            color: var(--white);
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* Status badges for bookings */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Booking History Cards */
        .booking-history-card {
            background: var(--white);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.2s ease;
            box-shadow: var(--card-shadow);
        }

        .booking-history-card:hover {
            box-shadow: var(--card-hover-shadow);
            transform: translateY(-2px);
        }

        /* Alert Messages */
        .alert {
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 1rem 1.25rem;
            margin-bottom: 1rem;
        }

        .alert i {
            margin-right: 0.5rem;
        }

        /* Animations */
        .venue-card {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 767px) {
            .venue-grid {
                justify-content: center;
            }
            
            .venue-card {
                width: 100%;
                max-width: 350px;
            }
            
            .stats-card {
                padding: 1.25rem 1rem;
                height: 120px;
            }
            
            .stats-card .stats-number {
                font-size: 1.5rem;
            }
            
            .stats-card i {
                font-size: 1.5rem;
            }
            
            .venue-card-body {
                padding: 15px;
            }
            
            .venue-title {
                font-size: 1.1rem;
            }
        }

        /* Stagger animation for cards */
        .venue-card:nth-child(1) { animation-delay: 0.1s; }
        .venue-card:nth-child(2) { animation-delay: 0.2s; }
        .venue-card:nth-child(3) { animation-delay: 0.3s; }
        .venue-card:nth-child(4) { animation-delay: 0.4s; }
        .venue-card:nth-child(5) { animation-delay: 0.5s; }
        .venue-card:nth-child(6) { animation-delay: 0.6s; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="organizationSidebar.jsp" />
            
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <h2 class="mb-0">
                                    <i class="fas fa-building me-2"></i>
                                    Venue Booking
                                </h2>
                                <p class="text-muted mb-0">Book venues for your events and activities</p>
                            </div>
                            <div class="col-auto">
                                <button class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#bookingHistoryModal">
                                    <i class="fas fa-history me-2"></i>Booking History
                                </button>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#quickBookModal">
                                    <i class="fas fa-plus me-2"></i>Quick Book
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <form method="GET" action="${pageContext.request.contextPath}/organization">
                            <input type="hidden" name="action" value="venues">
                            <div class="row align-items-end">
                                <div class="col-md-3">
                                    <label for="dateFilter" class="form-label">
                                        <i class="fas fa-calendar me-2"></i>Select Date
                                    </label>
                                    <input type="date" class="form-control" id="dateFilter" name="date" value="${param.date}" onchange="this.form.submit()">
                                </div>
                                <div class="col-md-2">
                                    <label for="capacityFilter" class="form-label">
                                        <i class="fas fa-users me-2"></i>Min Capacity
                                    </label>
                                    <select class="form-select" id="capacityFilter" name="capacity" onchange="this.form.submit()">
                                        <option value="">Any</option>
                                        <option value="50" ${param.capacity == '50' ? 'selected' : ''}>50+</option>
                                        <option value="100" ${param.capacity == '100' ? 'selected' : ''}>100+</option>
                                        <option value="200" ${param.capacity == '200' ? 'selected' : ''}>200+</option>
                                        <option value="500" ${param.capacity == '500' ? 'selected' : ''}>500+</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="buildingFilter" class="form-label">
                                        <i class="fas fa-building me-2"></i>Building
                                    </label>
                                    <select class="form-select" id="buildingFilter" name="building" onchange="this.form.submit()">
                                        <option value="">All Buildings</option>
                                        <c:forEach var="building" items="${buildings}">
                                            <option value="${building}" ${param.building == building ? 'selected' : ''}>${building}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="typeFilter" class="form-label">
                                        <i class="fas fa-tag me-2"></i>Venue Type
                                    </label>
                                    <select class="form-select" id="typeFilter" name="type" onchange="this.form.submit()">
                                        <option value="">All Types</option>
                                        <option value="Hall" ${param.type == 'Hall' ? 'selected' : ''}>Hall</option>
                                        <option value="Auditorium" ${param.type == 'Auditorium' ? 'selected' : ''}>Auditorium</option>
                                        <option value="Classroom" ${param.type == 'Classroom' ? 'selected' : ''}>Classroom</option>
                                        <option value="Lab" ${param.type == 'Lab' ? 'selected' : ''}>Laboratory</option>
                                        <option value="Sports" ${param.type == 'Sports' ? 'selected' : ''}>Sports Facility</option>
                                        <option value="Outdoor" ${param.type == 'Outdoor' ? 'selected' : ''}>Outdoor Space</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="statusFilter" class="form-label">
                                        <i class="fas fa-filter me-2"></i>Availability
                                    </label>
                                    <select class="form-select" id="statusFilter" name="status" onchange="this.form.submit()">
                                        <option value="">All</option>
                                        <option value="available" ${param.status == 'available' ? 'selected' : ''}>Available</option>
                                        <option value="booked" ${param.status == 'booked' ? 'selected' : ''}>Booked</option>
                                        <option value="maintenance" ${param.status == 'maintenance' ? 'selected' : ''}>Maintenance</option>
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()" title="Clear Filters">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Venues Grid -->
                    <c:choose>
                        <c:when test="${not empty venues}">
                            <div class="venue-grid">
                                <c:forEach var="venue" items="${venues}" varStatus="status">
                                    <div class="venue-card">
                                        <div class="venue-card-body">

                                            <!-- Venue Title & Type -->
                                            <div class="venue-header">
                                                <div>
                                                    <h3 class="venue-title">${venue.venueName}</h3>
                                                    <span class="venue-type">${venue.venueType}</span>
                                                </div>
                                            </div>
                                            
                                            <!-- Location -->
                                            <div class="venue-location">
                                                <i class="fas fa-map-marker-alt"></i>
                                                ${venue.building}, ${venue.floor}
                                            </div>

                                            <!-- Capacity -->
                                            <div class="venue-capacity">
                                                <i class="fas fa-users"></i>
                                                Capacity: ${venue.capacity} people
                                            </div>

                                            <!-- Facilities -->
                                            <c:if test="${not empty venue.facilities}">
                                                <div class="venue-facilities">
                                                    <small>
                                                        <i class="fas fa-tools"></i>
                                                        Facilities: ${fn:substring(venue.facilities, 0, 80)}${fn:length(venue.facilities) > 80 ? '...' : ''}
                                                    </small>
                                                </div>
                                            </c:if>

                                            <!-- Action Button -->
                                            <div class="mt-3">
                                                <c:choose>
                                                    <c:when test="${venue.availability == 'Available'}">
                                                        <a href="javascript:void(0)" 
                                                           class="venue-action primary"
                                                           onclick="bookVenue(${venue.venueID}, '${fn:escapeXml(venue.venueName)}')">
                                                            <i class="fas fa-calendar-plus me-2"></i>Book Now
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0)" 
                                                           class="venue-action warning"
                                                           onclick="viewSchedule(${venue.venueID})">
                                                            <i class="fas fa-clock me-2"></i>View Schedule
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-building"></i>
                                <h4>No Venues Found</h4>
                                <p>No venues match your current filters. Try adjusting your search criteria.</p>
                                <button class="btn btn-primary" onclick="clearFilters()">
                                    <i class="fas fa-refresh me-2"></i>Clear Filters
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Venue Pagination" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <!-- Previous Button -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?action=venues&page=${currentPage - 1}&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}" aria-label="Previous">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>

                                <!-- Page Numbers -->
                                <c:choose>
                                    <c:when test="${totalPages <= 7}">
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?action=venues&page=${i}&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Smart pagination for more than 7 pages -->
                                        <!-- First page -->
                                        <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                                            <a class="page-link" href="?action=venues&page=1&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}">1</a>
                                        </li>

                                        <!-- Ellipsis if needed -->
                                        <c:if test="${currentPage > 4}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>

                                        <!-- Pages around current page -->
                                        <c:set var="startPage" value="${currentPage - 2 < 2 ? 2 : currentPage - 2}" />
                                        <c:set var="endPage" value="${currentPage + 2 > totalPages - 1 ? totalPages - 1 : currentPage + 2}" />

                                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                            <c:if test="${i != 1 && i != totalPages}">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="?action=venues&page=${i}&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Ellipsis if needed -->
                                        <c:if test="${currentPage < totalPages - 3}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>

                                        <!-- Last page -->
                                        <c:if test="${totalPages > 1}">
                                            <li class="page-item ${currentPage == totalPages ? 'active' : ''}">
                                                <a class="page-link" href="?action=venues&page=${totalPages}&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}">${totalPages}</a>
                                            </li>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Next Button -->
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?action=venues&page=${currentPage + 1}&date=${param.date}&capacity=${param.capacity}&building=${param.building}&type=${param.type}&status=${param.status}" aria-label="Next">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>

                        <!-- Pagination Info -->
                        <div class="text-center text-muted mt-2">
                            <small>
                                Showing page ${currentPage} of ${totalPages}
                                <c:if test="${not empty totalRecords}">
                                    (${totalRecords} total venues)
                                </c:if>
                            </small>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Book Modal -->
    <div class="modal fade" id="quickBookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-calendar-plus me-2"></i>Quick Venue Booking</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form id="quickBookForm" method="POST" action="${pageContext.request.contextPath}/organization?action=bookVenue">
                    <div class="modal-body">
                        <!-- Booking Type Selection -->
                        <div class="mb-3">
                            <label class="form-label">Booking Type <span class="text-danger">*</span></label>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="bookingType" id="existingEventVenue" value="existing" checked>
                                        <label class="form-check-label" for="existingEventVenue">
                                            <i class="fas fa-calendar-check me-2"></i>Link to Existing Event
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="bookingType" id="newEventVenue" value="new">
                                        <label class="form-check-label" for="newEventVenue">
                                            <i class="fas fa-plus-circle me-2"></i>New Venue Booking
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Existing Event Selection -->
                        <div id="existingEventVenueSection">
                            <div class="mb-3">
                                <label for="selectedEventIDVenue" class="form-label">Select Approved Event <span class="text-danger">*</span></label>
                                <select class="form-select" name="selectedEventID" id="selectedEventIDVenue">
                                    <option value="">Choose an approved event...</option>
                                    <c:forEach var="event" items="${approvedEvents}">
                                        <option value="${event.eventID}" 
                                            data-title="${fn:escapeXml(event.eventTitle)}"
                                            data-date="<fmt:formatDate value='${event.eventDate}' pattern='yyyy-MM-dd'/>"
                                            data-time="${event.eventTime}">
                                            ${event.eventTitle} - <fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy"/>
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">Event details will auto-fill when selected</div>
                            </div>

                            <div class="row" id="eventDetailsVenueDisplay" style="display:none;">
                                <div class="col-md-6">
                                    <label class="form-label">Event Title</label>
                                    <input type="text" class="form-control" id="displayEventTitleVenue" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Event Date & Time</label>
                                    <input type="text" class="form-control" id="displayEventDateTimeVenue" readonly>
                                </div>
                            </div>
                        </div>

                        <!-- New Booking Section -->
                        <div id="newEventVenueSection" style="display:none;">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="eventType" class="form-label">Event Type *</label>
                                    <select class="form-select" id="eventType" name="eventType">
                                        <option value="">Select Event Type</option>
                                        <option value="Meeting">Meeting</option>
                                        <option value="Workshop">Workshop</option>
                                        <option value="Seminar">Seminar</option>
                                        <option value="Conference">Conference</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="bookingDate" class="form-label">Date *</label>
                                    <input type="date" class="form-control" id="bookingDate" name="bookingDate"
                                        min="<fmt:formatDate value='${currentDate}' pattern='yyyy-MM-dd'/>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startTime" class="form-label">Start Time *</label>
                                    <input type="time" class="form-control" id="startTime" name="startTime">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="endTime" class="form-label">End Time *</label>
                                    <input type="time" class="form-control" id="endTime" name="endTime">
                                </div>
                            </div>
                        </div>

                        <!-- Common Fields -->
                        <div class="mb-3">
                            <label for="expectedAttendees" class="form-label">Expected Attendees *</label>
                            <input type="number" class="form-control" id="expectedAttendees" name="expectedAttendees" required min="1">
                        </div>
                        <div class="mb-3">
                            <label for="venuePreference" class="form-label">Venue Preference</label>
                            <select class="form-select" id="venuePreference" name="venueId">
                                <option value="">Let system suggest best venue</option>
                                <c:forEach var="venue" items="${availableVenuesList}">
                                    <option value="${venue.venueID}">${venue.venueName} (${venue.capacity} capacity)</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="bookingPurpose" class="form-label">Purpose *</label>
                            <textarea class="form-control" id="bookingPurpose" name="purpose" rows="3" required></textarea>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="submitVenueBooking">
                            <i class="fas fa-calendar-check me-2"></i>Submit Request
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Booking History Modal -->
    <div class="modal fade" id="bookingHistoryModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-history me-2"></i>My Booking History
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div id="bookingHistoryList">
                        <c:choose>
                            <c:when test="${not empty bookingHistory}">
                                <c:forEach var="booking" items="${bookingHistory}">
                                    <div class="booking-history-card">
                                        <div class="row align-items-center">
                                            <div class="col-md-2 text-center">
                                                <div class="h5 mb-0">
                                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd"/>
                                                </div>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${booking.bookingDate}" pattern="MMM yyyy"/>
                                                </small>
                                            </div>

                                            <div class="col-md-5">
                                                <h6 class="mb-1">${booking.venueName}</h6>
                                                <p class="text-muted mb-0">
                                                    <i class="fas fa-clock me-1"></i>
                                                    <fmt:formatDate value="${booking.startTime}" pattern="hh:mm a"/> -
                                                    <fmt:formatDate value="${booking.endTime}" pattern="hh:mm a"/>
                                                </p>
                                            </div>

                                            <div class="col-md-2">
                                                <span class="status-badge status-${fn:toLowerCase(booking.status)}">
                                                    ${booking.status}
                                                </span>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="d-grid gap-2 d-md-flex">
                                                    <button class="btn btn-outline-primary btn-sm"
                                                            onclick="viewBookingDetails(${booking.bookingID})">
                                                        <i class="fas fa-eye"></i> View
                                                    </button>

                                                    <c:choose>
                                                        <c:when test="${booking.status == 'confirmed' && booking.bookingDate.time > currentDate.time}">
                                                            <button class="btn btn-outline-danger btn-sm"
                                                                    onclick="cancelBooking(${booking.bookingID})">
                                                                <i class="fas fa-times"></i> Cancel
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'cancelled'}">
                                                            <span class="text-muted fst-italic">Cancelled</span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <h5>No Booking History</h5>
                                    <p>You haven't made any venue bookings yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Alert Container -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
        <div id="alertContainer"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function clearFilters() {
        window.location.href = '${pageContext.request.contextPath}/organization?action=venues';
    }

    function bookVenue(venueId, venueName) {
        document.getElementById('venuePreference').value = venueId;
        new bootstrap.Modal(document.getElementById('quickBookModal')).show();
    }

    function viewSchedule(venueId) {
        const contextPath = '${pageContext.request.contextPath}';
        console.log("Navigating to schedule of venue ID:", venueId);
        window.location.href = contextPath + '/organization?action=venueSchedule&venueId=' + venueId;
    }

    function viewBookingDetails(bookingId) {
        window.location.href = '${pageContext.request.contextPath}/organization?action=viewBooking&bookingId=' + bookingId;
    }

    function cancelBooking(bookingId) {
        if (confirm('Are you sure you want to cancel booking ID: ' + bookingId + '?')) {
            const params = new URLSearchParams();
            params.append('bookingId', bookingId);
            params.append('type', 'venue');

            fetch('${pageContext.request.contextPath}/organization?action=cancelBooking', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString()
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert(data.message || 'Booking cancelled.', 'success');
                    setTimeout(() => location.reload(), 1500);
                } else {
                    showAlert(data.message || 'Failed to cancel.', 'danger');
                }
            })
            .catch(err => {
                console.error(err);
                showAlert('An error occurred.', 'danger');
            });
        }
    }

    function showAlert(message, type = 'info') {
        const wrapper = document.createElement('div');
        let iconClass = 'fa-info-circle';
        if (type === 'success') iconClass = 'fa-check-circle';
        else if (type === 'danger') iconClass = 'fa-exclamation-circle';
        else if (type === 'warning') iconClass = 'fa-exclamation-triangle';
        
        wrapper.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
            <i class="fas ${iconClass} me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>`;
        document.getElementById('alertContainer').append(wrapper);
        setTimeout(() => wrapper.remove(), 5000);
    }
    
    document.addEventListener('DOMContentLoaded', function () {
        const existingEventVenueRadio = document.getElementById('existingEventVenue');
        const newEventVenueRadio = document.getElementById('newEventVenue');
        const existingEventVenueSection = document.getElementById('existingEventVenueSection');
        const newEventVenueSection = document.getElementById('newEventVenueSection');
        const eventDetailsVenueDisplay = document.getElementById('eventDetailsVenueDisplay');

        function toggleVenueBookingType() {
            if (existingEventVenueRadio.checked) {
                existingEventVenueSection.style.display = 'block';
                newEventVenueSection.style.display = 'none';
            } else {
                existingEventVenueSection.style.display = 'none';
                newEventVenueSection.style.display = 'block';
                eventDetailsVenueDisplay.style.display = 'none';
            }
        }

        existingEventVenueRadio.addEventListener('change', toggleVenueBookingType);
        newEventVenueRadio.addEventListener('change', toggleVenueBookingType);

        document.getElementById('selectedEventIDVenue').addEventListener('change', function() {
            const selected = this.options[this.selectedIndex];
            if (selected.value) {
                document.getElementById('displayEventTitleVenue').value = selected.dataset.title;
                document.getElementById('displayEventDateTimeVenue').value = selected.dataset.date + ' at ' + selected.dataset.time;
                eventDetailsVenueDisplay.style.display = 'block';
                document.getElementById('bookingDate').value = selected.dataset.date;
                document.getElementById('startTime').value = selected.dataset.time;
                const [hours, minutes] = selected.dataset.time.split(':');
                const endHours = (parseInt(hours) + 2) % 24;
                document.getElementById('endTime').value = String(endHours).padStart(2, '0') + ':' + minutes;
            } else {
                eventDetailsVenueDisplay.style.display = 'none';
            }
        });

        toggleVenueBookingType();

        // Add stagger animation to cards
        const cards = document.querySelectorAll('.venue-card');
        cards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
        });

        // Auto-hide alerts
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                if (alert.querySelector('.btn-close')) {
                    alert.querySelector('.btn-close').click();
                }
            });
        }, 5000);
    });
    </script>
</body>
</html>