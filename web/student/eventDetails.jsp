<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${event.eventTitle} - UiTM Activity System</title>
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
        
        .event-header {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .event-hero {
            height: 300px;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .event-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.3);
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
        }
        
        .event-category-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            z-index: 3;
        }
        
        .event-status-badge {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            z-index: 3;
        }
        
        .status-available {
            background: #27ae60;
            color: white;
        }
        
        .status-full {
            background: #e74c3c;
            color: white;
        }
        
        .status-registered {
            background: #f39c12;
            color: white;
        }
        
        .event-details-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .info-item {
            background: #f8f9fa;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            border-left: 4px solid #3498db;
        }
        
        .info-item i {
            color: #3498db;
            width: 20px;
        }
        
        .price-display {
            background: linear-gradient(45deg, #27ae60, #229954);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .price-display.free {
            background: linear-gradient(45deg, #f39c12, #e67e22);
        }
        
        .btn-register {
            background: linear-gradient(45deg, #27ae60, #229954);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(39, 174, 96, 0.3);
            color: white;
        }
        
        .btn-register:disabled {
            background: #95a5a6;
            transform: none;
            box-shadow: none;
        }
        
        .btn-back {
            background: linear-gradient(45deg, #3498db, #2980b9);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
            color: white;
        }
        
        .progress-bar-custom {
            height: 25px;
            border-radius: 12px;
            background: #ecf0f1;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(45deg, #3498db, #2980b9);
            border-radius: 12px;
            transition: width 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.85rem;
        }
        
        .organizer-info {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
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
            
            .event-hero {
                height: 250px;
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
        <button class="btn btn-back d-md-none mb-3" type="button" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <!-- Back Button -->
        <div class="mb-3">
            <a href="student?action=events" class="btn btn-back">
                <i class="fas fa-arrow-left me-2"></i>Back to Events
            </a>
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
        
        <!-- Event Header -->
        <div class="event-header">
            <div class="event-hero">
                <div class="event-category-badge">${event.eventCategory}</div>
                
                <c:choose>
                    <c:when test="${isRegistered}">
                        <div class="event-status-badge status-registered">
                            <i class="fas fa-check me-1"></i>Registered
                        </div>
                    </c:when>
                    <c:when test="${event.currentParticipants >= event.participantLimit && event.participantLimit > 0}">
                        <div class="event-status-badge status-full">
                            <i class="fas fa-times me-1"></i>Full
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="event-status-badge status-available">
                            <i class="fas fa-check me-1"></i>Available
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="hero-content">
                    <h1 class="display-4 mb-3">${event.eventTitle}</h1>
                    <p class="lead mb-0">
                        <i class="fas fa-calendar me-2"></i>
                        <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy"/>
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Event Details -->
        <div class="row g-4">
            <!-- Main Details -->
            <div class="col-lg-8">
                <div class="event-details-card">
                    <h3 class="mb-4">
                        <i class="fas fa-info-circle me-2 text-primary"></i>
                        Event Details
                    </h3>
                    
                    <div class="info-item">
                        <i class="fas fa-align-left me-3"></i>
                        <strong>Description:</strong>
                        <p class="mt-2 mb-0">${event.eventDescription}</p>
                    </div>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="info-item">
                                <i class="fas fa-calendar me-3"></i>
                                <strong>Date:</strong><br>
                                <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-item">
                                <i class="fas fa-clock me-3"></i>
                                <strong>Time:</strong><br>
                                <fmt:formatDate value="${event.eventDate}" pattern="h:mm a"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-item">
                                <i class="fas fa-map-marker-alt me-3"></i>
                                <strong>Location:</strong><br>
                                ${event.eventLocation}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-item">
                                <i class="fas fa-tag me-3"></i>
                                <strong>Category:</strong><br>
                                ${event.eventCategory}
                            </div>
                        </div>
                    </div>
                    
                    <!-- Participation Progress -->
                    <c:if test="${event.participantLimit > 0}">
                        <div class="mt-4">
                            <h5 class="mb-3">
                                <i class="fas fa-users me-2 text-primary"></i>
                                Registration Status
                            </h5>
                            <div class="progress-bar-custom">
                                <div class="progress-fill" style="width: ${(event.currentParticipants / event.participantLimit) * 100}%">
                                    ${event.currentParticipants} / ${event.participantLimit} registered
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-2 text-muted small">
                                <span>${event.currentParticipants} participants registered</span>
                                <span>${event.participantLimit - event.currentParticipants} spots remaining</span>
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <!-- Organizer Information -->
                <div class="organizer-info">
                    <h5 class="mb-3">
                        <i class="fas fa-user-tie me-2"></i>
                        Event Organizer
                    </h5>
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h6 class="mb-1">${event.organizer}</h6>
                            <p class="mb-0 opacity-75">Event Organizer</p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-outline-light">
                                <i class="fas fa-envelope me-2"></i>Contact
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Registration Sidebar -->
            <div class="col-lg-4">
                <!-- Price Display -->
                <div class="price-display ${event.registrationFee == 0 ? 'free' : ''}">
                    <h3 class="mb-0">
                        <c:choose>
                            <c:when test="${event.registrationFee > 0}">
                                RM ${event.registrationFee}
                            </c:when>
                            <c:otherwise>
                                FREE
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    <small>Registration Fee</small>
                </div>
                
                <!-- Registration Status -->
                <c:choose>
                    <c:when test="${isRegistered}">
                        <div class="event-details-card text-center">
                            <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                            <h5 class="text-success mb-3">You're Registered!</h5>
                            <p class="text-muted mb-3">
                                Registration Status: <strong>${registration.registrationStatus}</strong><br>
                                <c:if test="${registration.paymentStatus == 'Paid'}">
                                    Payment: <span class="text-success">Confirmed</span><br>
                                    Amount: RM ${registration.amountPaid}
                                </c:if>
                            </p>
                            <div class="d-grid gap-2">
                                <a href="student?action=myRegistrations" class="btn btn-primary">
                                    <i class="fas fa-list me-2"></i>View My Registrations
                                </a>
                                <button class="btn btn-outline-danger" onclick="confirmCancel('${event.eventId}')">
                                    <i class="fas fa-times me-2"></i>Cancel Registration
                                </button>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${event.currentParticipants >= event.participantLimit && event.participantLimit > 0}">
                        <div class="event-details-card text-center">
                            <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                            <h5 class="text-warning mb-3">Event is Full</h5>
                            <p class="text-muted mb-3">
                                This event has reached its maximum capacity of ${event.participantLimit} participants.
                            </p>
                            <button class="btn-register" disabled>
                                <i class="fas fa-times me-2"></i>Registration Closed
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="event-details-card">
                            <h5 class="mb-3 text-center">Ready to Join?</h5>
                            <div class="d-grid">
                                <button class="btn-register" onclick="registerForEvent('${event.eventId}')">
                                    <i class="fas fa-plus me-2"></i>Register Now
                                </button>
                            </div>
                            <div class="mt-3 text-center small text-muted">
                                <c:if test="${event.registrationFee > 0}">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Payment required after registration
                                </c:if>
                                <c:if test="${event.registrationFee == 0}">
                                    <i class="fas fa-gift me-1"></i>
                                    Free registration - no payment required
                                </c:if>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- Quick Actions -->
                <div class="event-details-card">
                    <h6 class="mb-3">Quick Actions</h6>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-share me-2"></i>Share Event
                        </button>
                        <button class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-calendar-plus me-2"></i>Add to Calendar
                        </button>
                        <button class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-download me-2"></i>Download Details
                        </button>
                    </div>
                </div>
            </div>
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
        
        // Register for event
        function registerForEvent(eventId) {
            if (confirm('Are you sure you want to register for this event?')) {
                window.location.href = 'student?action=registerEvent&eventId=' + eventId;
            }
        }
        
        // Cancel registration
        function confirmCancel(eventId) {
            if (confirm('Are you sure you want to cancel your registration? This action cannot be undone.')) {
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
        document.querySelectorAll('.btn-register, .btn-primary').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (this.onclick && this.onclick.toString().includes('registerForEvent')) {
                    // Don't add loading state for registration as it needs confirmation
                    return;
                }
                
                if (this.tagName === 'A' && !this.getAttribute('href').startsWith('#')) {
                    const originalContent = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                    this.classList.add('disabled');
                }
            });
        });
    </script>
</body>
</html>