<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resource Booking - UiTM Activity</title>
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

        /* Resource Cards Grid */
        .resource-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
        }

        .resource-card {
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

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }

        .resource-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .resource-card-body {
            padding: 20px;
        }

        .resource-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .resource-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .resource-category {
            background-color: #e9ecef;
            color: #495057;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .resource-location {
            color: var(--muted-text);
            font-size: 0.9rem;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }

        .resource-location i {
            margin-right: 8px;
            color: var(--danger-color);
        }

        .resource-description {
            color: var(--muted-text);
            font-size: 0.9rem;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        .resource-availability {
            color: var(--success-color);
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            font-weight: 500;
        }

        .resource-availability i {
            margin-right: 8px;
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

        .availability-low {
            background-color: #fff3cd;
            color: #856404;
        }

        .availability-unavailable {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Action Buttons */
        .resource-action {
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

        .resource-action.primary {
            background: var(--primary-gradient);
            color: var(--white);
        }

        .resource-action.disabled {
            background: #6c757d;
            color: var(--white);
            cursor: not-allowed;
        }

        .resource-action:hover:not(.disabled) {
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

        .status-confirmed, .status-borrowed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-returned {
            background-color: #cfe2ff;
            color: #084298;
        }

        .status-overdue {
            background-color: #f8d7da;
            color: #842029;
        }

        .status-cancelled {
            background-color: #e2e3e5;
            color: #41464b;
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
        .resource-card {
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
            .resource-grid {
                justify-content: center;
            }
            
            .resource-card {
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
            
            .resource-card-body {
                padding: 15px;
            }
            
            .resource-title {
                font-size: 1.1rem;
            }
        }

        /* Stagger animation for cards */
        .resource-card:nth-child(1) { animation-delay: 0.1s; }
        .resource-card:nth-child(2) { animation-delay: 0.2s; }
        .resource-card:nth-child(3) { animation-delay: 0.3s; }
        .resource-card:nth-child(4) { animation-delay: 0.4s; }
        .resource-card:nth-child(5) { animation-delay: 0.5s; }
        .resource-card:nth-child(6) { animation-delay: 0.6s; }
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
                                    <i class="fas fa-boxes me-2"></i>
                                    Resource Booking
                                </h2>
                                <p class="text-muted mb-0">Book equipment and resources for your events</p>
                            </div>
                            <div class="col-auto">
                                <button class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#bookingHistoryModal">
                                    <i class="fas fa-history me-2"></i>My Bookings
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty success}">
                    <div class="container-fluid">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="container-fluid">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty warning}">
                    <div class="container-fluid">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${warning}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                </c:if>

                <div class="container-fluid">

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <form method="GET" action="${pageContext.request.contextPath}/organization">
                            <input type="hidden" name="action" value="resources">
                            <div class="row align-items-end">
                                <div class="col-md-3">
                                    <label for="categoryFilter" class="form-label">
                                        <i class="fas fa-tag me-2"></i>Category
                                    </label>
                                    <select class="form-select" id="categoryFilter" name="category" onchange="this.form.submit()">
                                        <option value="">All Categories</option>
                                        <option value="Audio/Visual" ${param.category == 'Audio/Visual' ? 'selected' : ''}>Audio/Visual</option>
                                        <option value="IT Equipment" ${param.category == 'IT Equipment' ? 'selected' : ''}>IT Equipment</option>
                                        <option value="Sports" ${param.category == 'Sports' ? 'selected' : ''}>Sports Equipment</option>
                                        <option value="Furniture" ${param.category == 'Furniture' ? 'selected' : ''}>Furniture</option>
                                        <option value="Tools" ${param.category == 'Tools' ? 'selected' : ''}>Tools</option>
                                        <option value="Other" ${param.category == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="locationFilter" class="form-label">
                                        <i class="fas fa-map-marker-alt me-2"></i>Location
                                    </label>
                                    <select class="form-select" id="locationFilter" name="location" onchange="this.form.submit()">
                                        <option value="">All Locations</option>
                                        <c:forEach var="location" items="${locations}">
                                            <option value="${location}" ${param.location == location ? 'selected' : ''}>${location}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="statusFilter" class="form-label">
                                        <i class="fas fa-filter me-2"></i>Availability
                                    </label>
                                    <select class="form-select" id="statusFilter" name="status" onchange="this.form.submit()">
                                        <option value="">All</option>
                                        <option value="available" ${param.status == 'available' ? 'selected' : ''}>Available</option>
                                        <option value="low" ${param.status == 'low' ? 'selected' : ''}>Low Stock</option>
                                        <option value="unavailable" ${param.status == 'unavailable' ? 'selected' : ''}>Unavailable</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="searchFilter" class="form-label">
                                        <i class="fas fa-search me-2"></i>Search
                                    </label>
                                    <input type="text" class="form-control" id="searchFilter" name="search" 
                                           value="${param.search}" placeholder="Search resources...">
                                </div>
                                <div class="col-md-1">
                                    <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()" title="Clear Filters">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Resources Grid -->
                    <c:choose>
                        <c:when test="${not empty resources}">
                            <div class="resource-grid">
                                <c:forEach var="resource" items="${resources}" varStatus="status">
                                    <div class="resource-card">
                                        <div class="resource-card-body">
                                            <!-- Availability Badge -->
                                            <div class="availability-badge availability-available">
                                                Available
                                            </div>

                                            <!-- Resource Title & Category -->
                                            <div class="resource-header">
                                                <div>
                                                    <h3 class="resource-title">${resource.resourceName}</h3>
                                                    <span class="resource-category">${resource.category}</span>
                                                </div>
                                            </div>
                                            
                                            <!-- Location -->
                                            <div class="resource-location">
                                                <i class="fas fa-map-marker-alt"></i>
                                                ${resource.location}
                                            </div>

                                            <!-- Description -->
                                            <div class="resource-description">
                                                ${fn:substring(resource.description, 0, 120)}${fn:length(resource.description) > 120 ? '...' : ''}
                                            </div>

                                            <!-- Availability -->
                                            <div class="resource-availability">
                                                <i class="fas fa-check-circle"></i>
                                                ${resource.availableQuantity} available (${resource.totalQuantity} total)
                                            </div>

                                            <!-- Action Button -->
                                            <div class="mt-3">
                                                <c:choose>
                                                    <c:when test="${resource.availableQuantity > 0}">
                                                        <a href="javascript:void(0)" 
                                                           class="resource-action primary"
                                                           onclick="bookResource(${resource.resourceID}, '${fn:escapeXml(resource.resourceName)}', ${resource.availableQuantity})">
                                                            <i class="fas fa-plus me-2"></i>Book Resource
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0)" 
                                                           class="resource-action disabled">
                                                            <i class="fas fa-times me-2"></i>Unavailable
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
                                <i class="fas fa-boxes"></i>
                                <h4>No Resources Found</h4>
                                <p>No resources match your current filters. Try adjusting your search criteria.</p>
                                <button class="btn btn-primary" onclick="clearFilters()">
                                    <i class="fas fa-refresh me-2"></i>Clear Filters
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Resource Booking Modal -->
    <div class="modal fade" id="resourceBookingModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <form class="modal-content" method="post" action="${pageContext.request.contextPath}/organization" id="resourceBookingForm">
                <input type="hidden" name="action" value="bookResource">
                <input type="hidden" name="resourceIds" id="modalResourceID">
                
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-calendar-plus me-2"></i> 
                        Book Resource: <span id="modalResourceName"></span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <!-- Booking Type Selection -->
                    <div class="mb-3">
                        <label class="form-label">Booking Type <span class="text-danger">*</span></label>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="bookingType" id="existingEvent" value="existing" checked>
                                    <label class="form-check-label" for="existingEvent">
                                        <i class="fas fa-calendar-check me-2"></i>Link to Existing Event
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="bookingType" id="newEvent" value="new">
                                    <label class="form-check-label" for="newEvent">
                                        <i class="fas fa-plus-circle me-2"></i>New Event Booking
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Existing Event Selection -->
                    <div id="existingEventSection">
                        <div class="mb-3">
                            <label for="selectedEventID" class="form-label">Select Approved Event <span class="text-danger">*</span></label>
                            <select class="form-select" name="selectedEventID" id="selectedEventID">
                                <option value="">Choose an approved event...</option>
                                <c:forEach var="event" items="${approvedEvents}">
                                    <option value="${event.eventID}" 
                                            data-title="${fn:escapeXml(event.eventTitle)}"
                                            data-location="${fn:escapeXml(event.eventLocation)}"
                                            data-contact="${fn:escapeXml(event.contactPerson)}"
                                            data-phone="${fn:escapeXml(event.contactPhone)}"
                                            data-date="<fmt:formatDate value='${event.eventDate}' pattern='dd MMM yyyy'/>">
                                        ${event.eventTitle} - <fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy"/>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">Select from your approved events to auto-fill details</div>
                        </div>

                        <!-- Event Details Display (Read-only for existing events) -->
                        <div class="row" id="eventDetailsDisplay" style="display: none;">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Event Name</label>
                                    <input type="text" class="form-control" id="displayEventName" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Event Location</label>
                                    <input type="text" class="form-control" id="displayEventLocation" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- New Event Section -->
                    <div id="newEventSection" style="display: none;">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="eventName" class="form-label">Event Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="eventName" id="eventName">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="eventLocation" class="form-label">Event Location <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="eventLocation" id="eventLocation">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="contactPerson" class="form-label">Contact Person <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="contactPerson" id="contactPerson">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="contactPhone" class="form-label">Contact Phone <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" name="contactPhone" id="contactPhone">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Booking Dates -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="borrowDate" class="form-label">Borrow Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="borrowDate" id="borrowDate" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="returnDate" class="form-label">Return Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="returnDate" id="returnDate" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Resource Details -->
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="quantity" id="quantity" min="1" value="1" required>
                        <div class="form-text">Available: <span id="maxQuantity"></span></div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="purpose" class="form-label">Purpose <span class="text-danger">*</span></label>
                        <textarea class="form-control" name="purpose" id="purpose" rows="3" required 
                                  placeholder="Please describe the purpose for booking this resource..."></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="submitBooking">
                        <i class="fas fa-paper-plane me-2"></i>Submit Booking
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Booking History Modal -->
    <div class="modal fade" id="bookingHistoryModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-history me-2"></i>My Resource Bookings</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <c:choose>
                        <c:when test="${not empty resourceBookings}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Resource</th>
                                            <th>Event</th>
                                            <th>Borrow Date</th>
                                            <th>Return Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="booking" items="${resourceBookings}">
                                            <tr>
                                                <td><strong>${booking.resourceName}</strong></td>
                                                <td>${booking.eventName}</td>
                                                <td><fmt:formatDate value="${booking.borrowDate}" pattern="dd MMM yyyy" /></td>
                                                <td><fmt:formatDate value="${booking.returnDate}" pattern="dd MMM yyyy" /></td>
                                                <td><span class="status-badge status-${fn:toLowerCase(booking.status)}">${booking.status}</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'pending' || booking.status == 'confirmed'}">
                                                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="cancelBooking(${booking.bookingID})">
                                                                <i class="fas fa-times"></i> Cancel
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'cancelled'}">
                                                            <span class="text-muted fst-italic">Cancelled</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <h5>No booking history found.</h5>
                                <p>You haven't made any resource bookings yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert Container -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
        <div id="alertContainer"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function clearFilters() {
            window.location.href = '${pageContext.request.contextPath}/organization?action=resources';
        }

        document.addEventListener('DOMContentLoaded', function () {
            // Handle booking type changes
            const existingEventRadio = document.getElementById('existingEvent');
            const newEventRadio = document.getElementById('newEvent');
            const existingEventSection = document.getElementById('existingEventSection');
            const newEventSection = document.getElementById('newEventSection');
            const eventDetailsDisplay = document.getElementById('eventDetailsDisplay');

            function toggleBookingType() {
                if (existingEventRadio.checked) {
                    existingEventSection.style.display = 'block';
                    newEventSection.style.display = 'none';
                    // Clear new event fields
                    document.getElementById('eventName').value = '';
                    document.getElementById('eventLocation').value = '';
                    document.getElementById('contactPerson').value = '';
                    document.getElementById('contactPhone').value = '';
                } else {
                    existingEventSection.style.display = 'none';
                    newEventSection.style.display = 'block';
                    eventDetailsDisplay.style.display = 'none';
                    // Clear existing event selection
                    document.getElementById('selectedEventID').value = '';
                }
            }

            existingEventRadio.addEventListener('change', toggleBookingType);
            newEventRadio.addEventListener('change', toggleBookingType);

            // Handle existing event selection
            document.getElementById('selectedEventID').addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
                if (selectedOption.value) {
                    // Show event details
                    document.getElementById('displayEventName').value = selectedOption.dataset.title;
                    document.getElementById('displayEventLocation').value = selectedOption.dataset.location;
                    eventDetailsDisplay.style.display = 'block';
                    
                    // Set hidden fields for form submission
                    document.getElementById('eventName').value = selectedOption.dataset.title;
                    document.getElementById('eventLocation').value = selectedOption.dataset.location;
                    document.getElementById('contactPerson').value = selectedOption.dataset.contact;
                    document.getElementById('contactPhone').value = selectedOption.dataset.phone;
                } else {
                    eventDetailsDisplay.style.display = 'none';
                }
            });

            // Set minimum date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('borrowDate').min = today;
            document.getElementById('returnDate').min = today;
            
            // Update return date when borrow date changes
            document.getElementById('borrowDate').addEventListener('change', function() {
                const borrowDate = this.value;
                const returnDateField = document.getElementById('returnDate');
                returnDateField.min = borrowDate;
                
                if (returnDateField.value && returnDateField.value <= borrowDate) {
                    // Set return date to one day after borrow date
                    const nextDay = new Date(borrowDate);
                    nextDay.setDate(nextDay.getDate() + 1);
                    returnDateField.value = nextDay.toISOString().split('T')[0];
                }
            });
            
            // Validate quantity
            document.getElementById('quantity').addEventListener('input', function() {
                const max = parseInt(document.getElementById('maxQuantity').textContent);
                if (parseInt(this.value) > max) {
                    this.value = max;
                }
            });

            // Form submission with validation
            document.getElementById('resourceBookingForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Validate booking type specific fields
                if (existingEventRadio.checked) {
                    if (!document.getElementById('selectedEventID').value) {
                        showAlert('Please select an approved event.', 'danger');
                        return;
                    }
                } else {
                    // Validate new event fields
                    const requiredFields = ['eventName', 'eventLocation', 'contactPerson', 'contactPhone'];
                    for (let fieldId of requiredFields) {
                        if (!document.getElementById(fieldId).value.trim()) {
                            showAlert('Please fill in all required fields for new event booking.', 'danger');
                            return;
                        }
                    }
                }
                
                // Date validation
                const borrowDate = new Date(document.getElementById('borrowDate').value);
                const returnDate = new Date(document.getElementById('returnDate').value);
                
                if (returnDate <= borrowDate) {
                    showAlert('Return date must be after borrow date.', 'danger');
                    return;
                }
                
                // Disable submit button to prevent double submission
                const submitBtn = document.getElementById('submitBooking');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Submitting...';
                
                // Submit form
                this.submit();
            });

            // Initialize
            toggleBookingType();

            // Add stagger animation to cards
            const cards = document.querySelectorAll('.resource-card');
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

        function bookResource(resourceId, resourceName, maxQuantity) {
            const modal = new bootstrap.Modal(document.getElementById('resourceBookingModal'));
            
            // Set values
            document.getElementById('modalResourceID').value = resourceId;
            document.getElementById('modalResourceName').textContent = resourceName;
            document.getElementById('maxQuantity').textContent = maxQuantity;
            document.getElementById('quantity').max = maxQuantity;
            
            // Reset form
            document.getElementById('resourceBookingForm').reset();
            document.getElementById('quantity').value = 1;
            document.getElementById('existingEvent').checked = true;
            
            // Reset sections
            document.getElementById('existingEventSection').style.display = 'block';
            document.getElementById('newEventSection').style.display = 'none';
            document.getElementById('eventDetailsDisplay').style.display = 'none';
            
            // Re-enable submit button
            const submitBtn = document.getElementById('submitBooking');
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<i class="fas fa-paper-plane me-2"></i>Submit Booking';
            
            modal.show();
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this resource booking?')) {
                const params = new URLSearchParams();
                params.append('bookingId', bookingId);
                params.append('type', 'resource');

                fetch('${pageContext.request.contextPath}/organization?action=cancelBooking', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params.toString()
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert(data.message || 'Booking cancelled successfully.', 'success');
                        setTimeout(() => location.reload(), 1500);
                    } else {
                        showAlert(data.message || 'Failed to cancel booking.', 'danger');
                    }
                })
                .catch(err => {
                    console.error('Error:', err);
                    showAlert('An error occurred while cancelling the booking.', 'danger');
                });
            }
        }

        function showAlert(message, type = 'info') {
            const alertContainer = document.getElementById('alertContainer');
            if (!alertContainer) {
                console.error('Alert container not found');
                return;
            }

            let iconClass;
            if (type === 'success') {
                iconClass = 'fa-check-circle';
            } else if (type === 'danger') {
                iconClass = 'fa-exclamation-circle';
            } else if (type === 'warning') {
                iconClass = 'fa-exclamation-triangle';
            } else {
                iconClass = 'fa-info-circle';
            }

            const wrapper = document.createElement('div');
            wrapper.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
                <i class="fas ${iconClass} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>`;

            alertContainer.append(wrapper);

            setTimeout(() => { 
                if (wrapper.parentNode) {
                    wrapper.remove(); 
                }
            }, 5000);
        }
    </script>
</body>
</html>