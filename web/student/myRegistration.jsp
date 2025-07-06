<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Registrations - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .page-header {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #6c757d;
            font-weight: 600;
        }
        
        .filter-tabs {
            background: white;
            border-radius: 15px;
            padding: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .filter-tab {
            background: transparent;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            margin: 0 5px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .filter-tab.active {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
        }
        
        .filter-tab:hover {
            background: rgba(52, 152, 219, 0.1);
        }
        
        .registration-card {
            background: white;
            border: none;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .registration-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .card-header-custom {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            padding: 20px;
            border: none;
        }
        
        .card-header-custom.academic {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
        }
        
        .card-header-custom.sports {
            background: linear-gradient(45deg, #27ae60, #229954);
        }
        
        .card-header-custom.cultural {
            background: linear-gradient(45deg, #9b59b6, #8e44ad);
        }
        
        .card-header-custom.general {
            background: linear-gradient(45fd, #f39c12, #e67e22);
        }
        
        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-registered {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-confirmed {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-attended {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .payment-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .payment-paid {
            background: #28a745;
            color: white;
        }
        
        .payment-free {
            background: #17a2b8;
            color: white;
        }
        
        .payment-pending {
            background: #ffc107;
            color: #212529;
        }
        
        .btn-action {
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            border: none;
            transition: all 0.3s ease;
            margin: 2px;
        }
        
        .btn-view {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-cancel {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .btn-feedback {
            background: linear-gradient(45deg, #f39c12, #e67e22);
            color: white;
        }
        
        .btn-certificate {
            background: linear-gradient(45deg, #9b59b6, #8e44ad);
            color: white;
        }
        
        .btn-payment {
            background: linear-gradient(45deg, #17a2b8, #138496);
            color: white;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .timeline-item {
            position: relative;
            padding-left: 30px;
            margin-bottom: 15px;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 5px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #3498db;
        }
        
        .timeline-item::after {
            content: '';
            position: absolute;
            left: 11px;
            top: 13px;
            width: 2px;
            height: calc(100% - 8px);
            background: #dee2e6;
        }
        
        .timeline-item:last-child::after {
            display: none;
        }
        
        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .notification-item {
            background: #f8f9fa;
            border-left: 4px solid #3498db;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        
        .notification-item.warning {
            border-left-color: #f39c12;
            background: #fff3cd;
        }
        
        .notification-item.danger {
            border-left-color: #e74c3c;
            background: #f8d7da;
        }
        
        .event-countdown {
            background: linear-gradient(135deg, #fd7e14, #dc6200);
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            text-align: center;
            font-size: 0.85rem;
            font-weight: 600;
            margin-top: 10px;
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
            
            .stat-item {
                padding: 15px 10px;
            }
            
            .stat-number {
                font-size: 2rem;
            }
            
            .filter-tab {
                display: block;
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="studentSidebar.jsp" />
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Mobile Menu Button -->
        <button class="btn btn-primary d-md-none mb-3" type="button" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-2">
                        <i class="fas fa-user-check me-2 text-primary"></i>
                        My Registrations
                    </h2>
                    <p class="mb-0 text-muted">
                        Manage your event registrations and track your participation
                    </p>
                </div>
                <div class="col-md-4 text-md-end">
                    <div class="btn-group">
                        <a href="student?action=events" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Register for More Events
                        </a>
                        <button class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fas fa-download"></i>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="exportRegistrations('pdf')">
                                <i class="fas fa-file-pdf me-2"></i>Export as PDF</a></li>
                            <li><a class="dropdown-item" href="#" onclick="exportRegistrations('excel')">
                                <i class="fas fa-file-excel me-2"></i>Export as Excel</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-card">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-primary">${totalRegistrations}</div>
                        <div class="stat-label">Total Registered</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-success">${completedEvents}</div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-warning">${upcomingEvents}</div>
                        <div class="stat-label">Upcoming</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-info">${pendingRegistrations}</div>
                        <div class="stat-label">Pending</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Notifications -->
        <c:if test="${not empty notifications}">
            <div class="quick-actions">
                <h6 class="mb-3"><i class="fas fa-bell me-2 text-warning"></i>Notifications</h6>
                <c:forEach var="notification" items="${notifications}">
                    <div class="notification-item ${notification.type}">
                        <strong>${notification.title}</strong><br>
                        <small>${notification.message}</small>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <div class="d-flex flex-wrap justify-content-center">
                <button class="filter-tab active" onclick="filterRegistrations('all')">
                    <i class="fas fa-list me-2"></i>All Registrations
                </button>
                <button class="filter-tab" onclick="filterRegistrations('upcoming')">
                    <i class="fas fa-clock me-2"></i>Upcoming Events
                </button>
                <button class="filter-tab" onclick="filterRegistrations('completed')">
                    <i class="fas fa-check-circle me-2"></i>Completed
                </button>
                <button class="filter-tab" onclick="filterRegistrations('pending')">
                    <i class="fas fa-hourglass-half me-2"></i>Pending Payment
                </button>
                <button class="filter-tab" onclick="filterRegistrations('cancelled')">
                    <i class="fas fa-times-circle me-2"></i>Cancelled
                </button>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Registration List -->
        <div id="registrationsList">
            <c:choose>
                <c:when test="${not empty registrations}">
                    <c:forEach var="registration" items="${registrations}">
                        <div class="registration-card" 
                             data-status="${registration.status.toLowerCase()}" 
                             data-payment="${registration.paymentStatus.toLowerCase()}"
                             data-category="${registration.eventCategory.toLowerCase()}"
                             data-date="${registration.eventDate}">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <div class="card-header-custom ${registration.eventCategory.toLowerCase()} h-100 d-flex flex-column justify-content-center">
                                        <h5 class="mb-2">${registration.eventTitle}</h5>
                                        <p class="mb-1 opacity-75">
                                            <i class="fas fa-calendar me-2"></i>
                                            <fmt:formatDate value="${registration.eventDate}" pattern="MMM dd, yyyy"/>
                                        </p>
                                        <p class="mb-1 opacity-75">
                                            <i class="fas fa-clock me-2"></i>
                                            <fmt:formatDate value="${registration.eventTime}" pattern="h:mm a"/>
                                        </p>
                                        <p class="mb-0 opacity-75">
                                            <i class="fas fa-map-marker-alt me-2"></i>
                                            ${registration.eventLocation}
                                        </p>
                                        
                                        <!-- Event Countdown for upcoming events -->
                                        <c:if test="${registration.eventDate > now && (registration.status == 'confirmed' || registration.status == 'registered')}">
                                            <div class="event-countdown" data-event-date="${registration.eventDate}">
                                                <i class="fas fa-clock me-1"></i>
                                                Event in: <span class="countdown-text">Calculating...</span>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body p-4">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="mb-3">
                                                    <h6 class="mb-2">Registration Details</h6>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="me-3">Status:</span>
                                                        <span class="status-badge status-${registration.status.toLowerCase()}">
                                                            <c:choose>
                                                                <c:when test="${registration.status == 'registered'}">
                                                                    <i class="fas fa-user-check me-1"></i>Registered
                                                                </c:when>
                                                                <c:when test="${registration.status == 'confirmed'}">
                                                                    <i class="fas fa-check-circle me-1"></i>Confirmed
                                                                </c:when>
                                                                <c:when test="${registration.status == 'attended'}">
                                                                    <i class="fas fa-medal me-1"></i>Attended
                                                                </c:when>
                                                                <c:when test="${registration.status == 'cancelled'}">
                                                                    <i class="fas fa-times-circle me-1"></i>Cancelled
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-hourglass-half me-1"></i>${registration.status}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="me-3">Payment:</span>
                                                        <span class="payment-badge payment-${registration.paymentStatus.toLowerCase()}">
                                                            <c:choose>
                                                                <c:when test="${registration.paymentStatus == 'paid'}">
                                                                    <i class="fas fa-check me-1"></i>Paid
                                                                </c:when>
                                                                <c:when test="${registration.paymentStatus == 'free'}">
                                                                    <i class="fas fa-gift me-1"></i>Free
                                                                </c:when>
                                                                <c:when test="${registration.paymentStatus == 'pending'}">
                                                                    <i class="fas fa-clock me-1"></i>Pending
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${registration.paymentStatus}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="me-3">Category:</span>
                                                        <span class="text-muted">${registration.eventCategory}</span>
                                                    </div>
                                                    <div class="d-flex align-items-center">
                                                        <span class="me-3">Registered:</span>
                                                        <span class="text-muted">
                                                            <fmt:formatDate value="${registration.registrationDate}" pattern="MMM dd, yyyy"/>
                                                        </span>
                                                    </div>
                                                </div>
                                                
                                                <!-- Payment Information -->
                                                <c:if test="${registration.paymentStatus == 'paid' && registration.paymentAmount > 0}">
                                                    <div class="small text-muted">
                                                        <i class="fas fa-receipt me-1"></i>
                                                        Amount Paid: RM <fmt:formatNumber value="${registration.paymentAmount}" pattern="#,##0.00"/>
                                                    </div>
                                                </c:if>
                                                
                                                <!-- Timeline for registration status -->
                                                <div class="mt-3">
                                                    <h6 class="mb-2">Registration Timeline</h6>
                                                    <div class="timeline-item">
                                                        <small class="text-muted">
                                                            <strong>Registered:</strong> 
                                                            <fmt:formatDate value="${registration.registrationDate}" pattern="MMM dd, yyyy 'at' h:mm a"/>
                                                        </small>
                                                    </div>
                                                    <c:if test="${registration.paymentStatus == 'paid'}">
                                                        <div class="timeline-item">
                                                            <small class="text-success">
                                                                <strong>Payment Confirmed:</strong> Payment processed successfully
                                                            </small>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${registration.status == 'attended'}">
                                                        <div class="timeline-item">
                                                            <small class="text-success">
                                                                <strong>Event Attended:</strong> Successfully attended the event
                                                            </small>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="d-grid gap-2">
                                                    <!-- View Event Details -->
                                                    <a href="student?action=eventDetails&eventId=${registration.eventID}" 
                                                       class="btn btn-action btn-view">
                                                        <i class="fas fa-eye me-2"></i>View Event
                                                    </a>
                                                    
                                                    <!-- Status-specific actions -->
                                                    <c:choose>
                                                        <c:when test="${registration.status == 'attended'}">
                                                            <!-- Download Certificate -->
                                                            <a href="student?action=downloadCertificate&eventId=${registration.eventID}" 
                                                               class="btn btn-action btn-certificate">
                                                                <i class="fas fa-certificate me-2"></i>Get Certificate
                                                            </a>
                                                            <!-- Give Feedback -->
                                                            <c:if test="${empty registration.feedback}">
                                                                <a href="student?action=feedback&eventId=${registration.eventID}" 
                                                                   class="btn btn-action btn-feedback">
                                                                    <i class="fas fa-star me-2"></i>Give Feedback
                                                                </a>
                                                            </c:if>
                                                        </c:when>
                                                        
                                                        <c:when test="${registration.paymentStatus == 'pending'}">
                                                            <!-- Complete Payment -->
                                                            <a href="student?action=payment&eventId=${registration.eventID}" 
                                                               class="btn btn-action btn-payment">
                                                                <i class="fas fa-credit-card me-2"></i>Complete Payment
                                                            </a>
                                                        </c:when>
                                                        
                                                        <c:when test="${registration.status == 'confirmed' || registration.status == 'registered'}">
                                                            <!-- Cancel Registration -->
                                                            <c:if test="${registration.eventDate > now}">
                                                                <button class="btn btn-action btn-cancel" 
                                                                        onclick="confirmCancel('${registration.eventID}', '${registration.eventTitle}')">
                                                                    <i class="fas fa-times me-2"></i>Cancel Registration
                                                                </button>
                                                            </c:if>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                    <!-- Additional Actions -->
                                                    <div class="btn-group w-100">
                                                        <button class="btn btn-outline-secondary btn-sm dropdown-toggle" 
                                                                data-bs-toggle="dropdown">
                                                            <i class="fas fa-ellipsis-h"></i>
                                                        </button>
                                                        <ul class="dropdown-menu w-100">
                                                            <li><a class="dropdown-item" href="#" onclick="addToCalendar('${registration.eventID}')">
                                                                <i class="fas fa-calendar-plus me-2"></i>Add to Calendar</a></li>
                                                            <li><a class="dropdown-item" href="#" onclick="shareEvent('${registration.eventID}')">
                                                                <i class="fas fa-share me-2"></i>Share Event</a></li>
                                                            <li><a class="dropdown-item" href="#" onclick="downloadReceipt('${registration.registrationID}')">
                                                                <i class="fas fa-receipt me-2"></i>Download Receipt</a></li>
                                                            <c:if test="${registration.status == 'attended' && not empty registration.feedback}">
                                                                <li><a class="dropdown-item" href="#" onclick="viewFeedback('${registration.registrationID}')">
                                                                    <i class="fas fa-comment me-2"></i>View My Feedback</a></li>
                                                            </c:if>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="registration-card">
                        <div class="empty-state">
                            <i class="fas fa-calendar-times"></i>
                            <h4 class="mb-3">No Registrations Found</h4>
                            <p class="mb-4">You haven't registered for any events yet. Start exploring exciting activities!</p>
                            <a href="student?action=events" class="btn btn-primary">
                                <i class="fas fa-search me-2"></i>Browse Events
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Cancel Confirmation Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2 text-warning"></i>
                        Cancel Registration
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to cancel your registration for "<span id="cancelEventTitle"></span>"?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Important:</strong> This action cannot be undone. If you've made a payment, 
                        please check the refund policy for this event.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Keep Registration</button>
                    <button type="button" class="btn btn-danger" onclick="proceedWithCancel()">
                        <i class="fas fa-times me-2"></i>Cancel Registration
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        let currentEventId = null;
        
        // Toggle sidebar for mobile
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('show');
        }
        
        // Filter registrations
        function filterRegistrations(status) {
            // Update active tab
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Filter cards
            const cards = document.querySelectorAll('.registration-card');
            cards.forEach(card => {
                if (status === 'all') {
                    card.style.display = 'block';
                } else if (status === 'upcoming') {
                    const eventDate = new Date(card.getAttribute('data-date'));
                    const today = new Date();
                    const cardStatus = card.getAttribute('data-status');
                    if (eventDate > today && (cardStatus === 'confirmed' || cardStatus === 'registered')) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                } else if (status === 'pending') {
                    const paymentStatus = card.getAttribute('data-payment');
                    if (paymentStatus === 'pending') {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                } else if (status === 'completed') {
                    const cardStatus = card.getAttribute('data-status');
                    if (cardStatus === 'attended') {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                } else {
                    const cardStatus = card.getAttribute('data-status');
                    if (cardStatus === status) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
        }
        
        // Confirm cancellation
        function confirmCancel(eventId, eventTitle) {
            currentEventId = eventId;
            document.getElementById('cancelEventTitle').textContent = eventTitle;
            new bootstrap.Modal(document.getElementById('cancelModal')).show();
        }
        
        function proceedWithCancel() {
            if (currentEventId) {
                window.location.href = 'student?action=cancelRegistration&eventId=' + currentEventId;
            }
        }
        
        // Update event countdowns
        function updateEventCountdowns() {
            document.querySelectorAll('[data-event-date]').forEach(element => {
                const eventDate = new Date(element.dataset.eventDate).getTime();
                const now = new Date().getTime();
                const distance = eventDate - now;
                
                if (distance < 0) {
                    element.innerHTML = '<i class="fas fa-calendar-check me-1"></i>Event completed';
                    element.style.background = 'linear-gradient(135deg, #27ae60, #229954)';
                    return;
                }
                
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                
                let countdownText = '';
                if (days > 0) {
                    countdownText = `${days} day${days > 1 ? 's' : ''}`;
                } else if (hours > 0) {
                    countdownText = `${hours} hour${hours > 1 ? 's' : ''}`;
                } else {
                    countdownText = 'Starting soon!';
                }
                
                element.querySelector('.countdown-text').textContent = countdownText;
            });
        }
        
        // Update countdowns every minute
        setInterval(updateEventCountdowns, 60000);
        updateEventCountdowns();
        
        // Additional action functions
        function addToCalendar(eventId) {
            // Implementation for adding event to calendar
            alert('Add to calendar feature will be implemented soon!');
        }
        
        function shareEvent(eventId) {
            if (navigator.share) {
                navigator.share({
                    title: 'Event Registration',
                    text: 'Check out this event I registered for!',
                    url: window.location.origin + '/student?action=eventDetails&eventId=' + eventId
                });
            } else {
                // Fallback - copy link to clipboard
                const link = window.location.origin + '/student?action=eventDetails&eventId=' + eventId;
                navigator.clipboard.writeText(link).then(() => {
                    alert('Event link copied to clipboard!');
                });
            }
        }
        
        function downloadReceipt(registrationId) {
            window.location.href = 'student?action=downloadReceipt&registrationId=' + registrationId;
        }
        
        function viewFeedback(registrationId) {
            // Implementation for viewing submitted feedback
            alert('View feedback feature will be implemented soon!');
        }
        
        function exportRegistrations(format) {
            window.location.href = 'student?action=exportRegistrations&format=' + format;
        }
        
        // Auto-hide mobile sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const isClickInsideSidebar = sidebar && sidebar.contains(event.target);
            const isClickOnMenuButton = event.target.closest('.btn') && 
                                       event.target.closest('.btn').onclick === toggleSidebar;
            
            if (sidebar && !isClickInsideSidebar && !isClickOnMenuButton && sidebar.classList.contains('show')) {
                sidebar.classList.remove('show');
            }
        });
        
        // Add loading states for buttons
        document.querySelectorAll('.btn-action').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (this.onclick) {
                    // Don't add loading state for buttons with onclick handlers
                    return;
                }
                
                if (this.tagName === 'A' && !this.getAttribute('href').startsWith('#')) {
                    const originalContent = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                    this.classList.add('disabled');
                }
            });
        });
        
        // Add animation to cards on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.registration-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>