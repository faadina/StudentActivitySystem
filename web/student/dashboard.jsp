<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - UiTM Activity System</title>
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
        
        .dashboard-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            overflow: hidden;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .stat-card {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
        }
        
        .stat-card-success {
            background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
            color: white;
        }
        
        .stat-card-warning {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            color: white;
        }
        
        .stat-card-info {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            color: white;
        }
        
        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .event-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            height: 100%;
        }
        
        .event-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .event-card .card-header {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: none;
            padding: 15px 20px;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #3498db, #2980b9);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        }
        
        .btn-success {
            background: linear-gradient(45deg, #27ae60, #229954);
            border: none;
            border-radius: 25px;
        }
        
        .btn-warning {
            background: linear-gradient(45deg, #f39c12, #e67e22);
            border: none;
            border-radius: 25px;
        }
        
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quick-actions {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .quick-action-btn {
            background: white;
            border: 2px dashed #dee2e6;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #6c757d;
            display: block;
            height: 100%;
        }
        
        .quick-action-btn:hover {
            border-color: #3498db;
            color: #3498db;
            background: rgba(52, 152, 219, 0.05);
            transform: translateY(-3px);
        }
        
        .progress-custom {
            height: 10px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.2);
        }
        
        .progress-custom .progress-bar {
            border-radius: 10px;
        }
        
        .achievement-badge {
            background: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
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
        
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-2">
                        <i class="fas fa-hand-wave me-2"></i>
                        Welcome back, ${sessionScope.currentUser.userName}!
                    </h2>
                    <p class="mb-0 opacity-90">
                        Ready to explore exciting events and activities? Let's make your university experience unforgettable!
                    </p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <div class="text-white">
                        <div class="h5 mb-1">
                            <i class="fas fa-calendar me-2"></i>
                            <span id="current-date"></span>
                        </div>
                        <div>
                            <i class="fas fa-clock me-2"></i>
                            <span id="current-time"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="dashboard-card stat-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-calendar-check fa-3x mb-3 opacity-80"></i>
                        <h3 class="mb-1">${totalRegistrations}</h3>
                        <p class="mb-0">Events Registered</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="dashboard-card stat-card-success">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-trophy fa-3x mb-3 opacity-80"></i>
                        <h3 class="mb-1">${completedEvents}</h3>
                        <p class="mb-0">Events Completed</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="dashboard-card stat-card-warning">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-clock fa-3x mb-3 opacity-80"></i>
                        <h3 class="mb-1">${upcomingEvents}</h3>
                        <p class="mb-0">Upcoming Events</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="dashboard-card stat-card-info">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-certificate fa-3x mb-3 opacity-80"></i>
                        <h3 class="mb-1">${certificatesEarned}</h3>
                        <p class="mb-0">Certificates Earned</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row g-4">
            <!-- Quick Actions -->
            <div class="col-lg-4">
                <div class="quick-actions">
                    <h5 class="mb-4">
                        <i class="fas fa-bolt me-2 text-primary"></i>Quick Actions
                    </h5>
                    <div class="row g-3">
                        <div class="col-6">
                            <a href="student?action=events" class="quick-action-btn">
                                <i class="fas fa-search fa-2x mb-2"></i>
                                <h6>Browse Events</h6>
                                <small>Find exciting activities</small>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="student?action=myRegistrations" class="quick-action-btn">
                                <i class="fas fa-list fa-2x mb-2"></i>
                                <h6>My Events</h6>
                                <small>View registrations</small>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="student?action=certificates" class="quick-action-btn">
                                <i class="fas fa-download fa-2x mb-2"></i>
                                <h6>Certificates</h6>
                                <small>Download awards</small>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="student?action=feedback" class="quick-action-btn">
                                <i class="fas fa-star fa-2x mb-2"></i>
                                <h6>Give Feedback</h6>
                                <small>Rate events</small>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Achievement Progress -->
                    <div class="mt-4 p-3 bg-light rounded-3">
                        <h6 class="mb-3">
                            <i class="fas fa-target me-2 text-success"></i>Your Progress
                        </h6>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1">
                                <small>Events Attended</small>
                                <small>${completedEvents}/10</small>
                            </div>
                            <div class="progress progress-custom">
                                <div class="progress-bar bg-success" style="width: ${(completedEvents/10)*100}%"></div>
                            </div>
                        </div>
                        <c:if test="${completedEvents >= 5}">
                            <span class="achievement-badge">
                                <i class="fas fa-medal me-1"></i>Active Participant
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- Upcoming Events -->
            <div class="col-lg-8">
                <div class="dashboard-card">
                    <div class="card-header d-flex justify-content-between align-items-center bg-white border-0 pb-0">
                        <h5 class="mb-0">
                            <i class="fas fa-calendar-alt me-2 text-primary"></i>Upcoming Events
                        </h5>
                        <a href="student?action=events" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus me-1"></i>Browse All
                        </a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentEvents}">
                                <div class="row g-3">
                                    <c:forEach var="event" items="${recentEvents}" varStatus="status">
                                        <c:if test="${status.index < 4}">
                                            <div class="col-md-6">
                                                <div class="event-card">
                                                    <div class="card-header">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div>
                                                                <h6 class="mb-1">${event.eventTitle}</h6>
                                                                <small class="opacity-75">
                                                                    <i class="fas fa-calendar me-1"></i>
                                                                    <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy"/>
                                                                </small>
                                                            </div>
                                                            <span class="badge bg-white text-primary">${event.eventCategory}</span>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <p class="card-text text-muted small mb-3">
                                                            ${event.eventDescription.length() > 80 ? 
                                                              event.eventDescription.substring(0, 80) + "..." : 
                                                              event.eventDescription}
                                                        </p>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <small class="text-muted">
                                                                <i class="fas fa-map-marker-alt me-1"></i>
                                                                ${event.eventLocation}
                                                            </small>
                                                            <c:choose>
                                                                <c:when test="${event.registrationFee > 0}">
                                                                    <span class="text-success fw-bold">RM ${event.registrationFee}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-success fw-bold">FREE</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="mt-3">
                                                            <a href="student?action=eventDetails&eventId=${event.eventId}" 
                                                               class="btn btn-primary btn-sm w-100">
                                                                <i class="fas fa-eye me-1"></i>View Details
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted">No upcoming events</h6>
                                    <p class="text-muted">Check back later for new activities!</p>
                                    <a href="student?action=events" class="btn btn-primary">
                                        <i class="fas fa-search me-2"></i>Browse Events
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Activity & Notifications -->
        <div class="row g-4 mt-2">
            <div class="col-lg-6">
                <div class="dashboard-card">
                    <div class="card-header bg-white border-0">
                        <h5 class="mb-0">
                            <i class="fas fa-bell me-2 text-warning"></i>Recent Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="timeline">
                            <c:choose>
                                <c:when test="${not empty recentActivity}">
                                    <c:forEach var="activity" items="${recentActivity}">
                                        <div class="d-flex align-items-start mb-3">
                                            <div class="flex-shrink-0">
                                                <div class="bg-primary rounded-circle p-2 text-white">
                                                    <i class="fas fa-calendar-check"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <p class="mb-1">${activity.description}</p>
                                                <small class="text-muted">${activity.timeAgo}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-3">
                                        <i class="fas fa-history fa-2x text-muted mb-2"></i>
                                        <p class="text-muted mb-0">No recent activity</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-6">
                <div class="dashboard-card">
                    <div class="card-header bg-white border-0">
                        <h5 class="mb-0">
                            <i class="fas fa-chart-bar me-2 text-info"></i>Your Statistics
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3 text-center">
                            <div class="col-6">
                                <div class="bg-light rounded-3 p-3">
                                    <h4 class="text-primary mb-1">${monthlyEvents}</h4>
                                    <small class="text-muted">Events This Month</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light rounded-3 p-3">
                                    <h4 class="text-success mb-1">95%</h4>
                                    <small class="text-muted">Attendance Rate</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light rounded-3 p-3">
                                    <h4 class="text-warning mb-1">${favoriteCategory}</h4>
                                    <small class="text-muted">Favorite Category</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light rounded-3 p-3">
                                    <h4 class="text-info mb-1">4.8</h4>
                                    <small class="text-muted">Avg Feedback Score</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <h6 class="mb-3">Event Categories</h6>
                            <div class="mb-2">
                                <div class="d-flex justify-content-between">
                                    <small>Academic</small>
                                    <small>${academicPercentage}%</small>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-primary" style="width: ${academicPercentage}%"></div>
                                </div>
                            </div>
                            <div class="mb-2">
                                <div class="d-flex justify-content-between">
                                    <small>Cultural</small>
                                    <small>${culturalPercentage}%</small>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-success" style="width: ${culturalPercentage}%"></div>
                                </div>
                            </div>
                            <div class="mb-2">
                                <div class="d-flex justify-content-between">
                                    <small>Sports</small>
                                    <small>${sportsPercentage}%</small>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-warning" style="width: ${sportsPercentage}%"></div>
                                </div>
                            </div>
                        </div>
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
        
        // Update time and date
        function updateDateTime() {
            const now = new Date();
            
            // Update date
            const dateOptions = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            document.getElementById('current-date').textContent = 
                now.toLocaleDateString('en-US', dateOptions);
            
            // Update time
            const timeOptions = { 
                hour: '2-digit', 
                minute: '2-digit',
                second: '2-digit',
                hour12: true 
            };
            document.getElementById('current-time').textContent = 
                now.toLocaleTimeString('en-US', timeOptions);
        }
        
        // Update every second
        setInterval(updateDateTime, 1000);
        updateDateTime(); // Initial call
        
        // Card animations on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.dashboard-card');
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
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
        
        // Add loading states for buttons
        document.querySelectorAll('.btn-primary, .btn-success, .btn-warning').forEach(btn => {
            btn.addEventListener('click', function() {
                if (this.tagName === 'A' && this.getAttribute('href') && 
                    !this.getAttribute('href').startsWith('#')) {
                    const originalContent = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                    this.disabled = true;
                    
                    // Re-enable after navigation (fallback)
                    setTimeout(() => {
                        this.innerHTML = originalContent;
                        this.disabled = false;
                    }, 2000);
                }
            });
        });
        
        // Welcome message based on time of day
        function updateWelcomeMessage() {
            const hour = new Date().getHours();
            const nameElement = document.querySelector('.welcome-banner h2');
            const currentText = nameElement.textContent;
            
            let greeting = 'Welcome back';
            if (hour < 12) greeting = 'Good morning';
            else if (hour < 17) greeting = 'Good afternoon';
            else greeting = 'Good evening';
            
            nameElement.innerHTML = `<i class="fas fa-hand-wave me-2"></i>${greeting}, ${currentText.split(', ')[1]}`;
        }
        
        // Call on page load
        updateWelcomeMessage();
    </script>
</body>
</html>