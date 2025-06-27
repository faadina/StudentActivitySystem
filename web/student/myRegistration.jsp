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
        
        .sidebar {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            min-height: 100vh;
            color: white;
            position: fixed;
            width: 250px;
            left: 0;
            top: 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 15px 20px;
            border-radius: 8px;
            margin: 2px 10px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.1);
            border-left-color: #3498db;
            transform: translateX(5px);
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
        
        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-confirmed {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
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
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
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
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .stat-item {
                padding: 15px 10px;
            }
            
            .stat-number {
                font-size: 2rem;
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
                    <a href="student?action=events" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Register for More Events
                    </a>
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
        
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <div class="d-flex flex-wrap justify-content-center">
                <button class="filter-tab active" onclick="filterRegistrations('all')">
                    <i class="fas fa-list me-2"></i>All Registrations
                </button>
                <button class="filter-tab" onclick="filterRegistrations('upcoming')">
                    <i class="fas fa-clock me-2"></i>Upcoming
                </button>
                <button class="filter-tab" onclick="filterRegistrations('completed')">
                    <i class="fas fa-check-circle me-2"></i>Completed
                </button>
                <button class="filter-tab" onclick="filterRegistrations('pending')">
                    <i class="fas fa-hourglass-half me-2"></i>Pending
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
                        <div class="registration-card" data-status="${registration.registrationStatus.toLowerCase()}">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <div class="card-header-custom h-100 d-flex flex-column justify-content-center">
                                        <h5 class="mb-2">${registration.event.eventTitle}</h5>
                                        <p class="mb-1 opacity-75">
                                            <i class="fas fa-calendar me-2"></i>
                                            <fmt:formatDate value="${registration.event.eventDate}" pattern="MMM dd, yyyy"/>
                                        </p>
                                        <p class="mb-0 opacity-75">
                                            <i class="fas fa-map-marker-alt me-2"></i>
                                            ${registration.event.eventLocation}
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body p-4">
                                        <div class="row align-items-center">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <h6 class="mb-2">Registration Details</h6>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="me-3">Status:</span>
                                                        <span class="status-badge status-${registration.registrationStatus.toLowerCase()}">
                                                            ${registration.registrationStatus}
                                                        </span>
                                                    </div>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="me-3">Payment:</span>
                                                        <span class="payment-badge payment-${registration.paymentStatus.toLowerCase()}">
                                                            ${registration.paymentStatus}
                                                        </span>
                                                    </div>
                                                    <div class="d-flex align-items-center">
                                                        <span class="me-3">Category:</span>
                                                        <span class="text-muted">${registration.event.eventCategory}</span>
                                                    </div>
                                                </div>
                                                
                                                <c:if test="${registration.paymentStatus == 'Paid'}">
                                                    <div class="small text-muted">
                                                        <i class="fas fa-receipt me-1"></i>
                                                        Amount Paid: RM ${registration.amountPaid}<br>
                                                        Payment Date: <fmt:formatDate value="${registration.paymentDate}" pattern="MMM dd, yyyy"/>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="d-grid gap-2">
                                                    <a href="student?action=eventDetails&eventId=${registration.event.eventId}" 
                                                       class="btn btn-action btn-view">
                                                        <i class="fas fa-eye me-2"></i>View Event
                                                    </a>
                                                    
                                                    <c:choose>
                                                        <c:when test="${registration.registrationStatus == 'Completed'}">
                                                            <a href="student?action=downloadCertificate&eventId=${registration.event.eventId}" 
                                                               class="btn btn-action btn-certificate">
                                                                <i class="fas fa-certificate me-2"></i>Get Certificate
                                                            </a>
                                                            <a href="student?action=feedback&eventId=${registration.event.eventId}" 
                                                               class="btn btn-action btn-feedback">
                                                                <i class="fas fa-star me-2"></i>Give Feedback
                                                            </a>
                                                        </c:when>
                                                        <c:when test="${registration.registrationStatus == 'Confirmed' || registration.registrationStatus == 'Pending'}">
                                                            <button class="btn btn-action btn-cancel" 
                                                                    onclick="confirmCancel('${registration.event.eventId}', '${registration.event.eventTitle}')">
                                                                <i class="fas fa-times me-2"></i>Cancel Registration
                                                            </button>
                                                        </c:when>
                                                    </c:choose>
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Toggle sidebar for mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
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
            if (confirm(`Are you sure you want to cancel your registration for "${eventTitle}"?\n\nThis action cannot be undone.`)) {
                window.location.href = 'student?action=cancelRegistration&eventId=' + eventId;
            }
        }
        
        // Auto-hide mobile sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const isClickInsideSidebar = sidebar.contains(event.target);
            const isClickOnMenuButton = event.target.closest('.btn') && 
                                       event.target.closest('.btn').onclick === toggleSidebar;
            
            if (!isClickInsideSidebar && !isClickOnMenuButton && sidebar.classList.contains('show')) {
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