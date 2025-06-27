<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Events - UiTM Activity System</title>
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
        
        .event-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            height: 100%;
            background: white;
        }
        
        .event-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .event-header {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            padding: 20px;
            position: relative;
        }
        
        .event-header.academic {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }
        
        .event-header.sports {
            background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
        }
        
        .event-header.cultural {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
        }
        
        .event-header.general {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
        }
        
        .filter-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .search-bar {
            border-radius: 25px;
            border: 2px solid #e9ecef;
            padding: 12px 20px;
            transition: all 0.3s ease;
        }
        
        .search-bar:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .btn-filter {
            border-radius: 20px;
            border: 2px solid #dee2e6;
            background: white;
            color: #6c757d;
            transition: all 0.3s ease;
        }
        
        .btn-filter:hover,
        .btn-filter.active {
            border-color: #3498db;
            background: #3498db;
            color: white;
        }
        
        .price-tag {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }
        
        .price-tag.free {
            background: rgba(39, 174, 96, 0.9);
        }
        
        .btn-register {
            background: linear-gradient(45deg, #27ae60, #229954);
            border: none;
            border-radius: 25px;
            color: white;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
            color: white;
        }
        
        .event-meta {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 10px;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .capacity-bar {
            height: 6px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 3px;
            overflow: hidden;
            margin-top: 10px;
        }
        
        .capacity-fill {
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            transition: width 0.3s ease;
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Include sidebar here (same as dashboard) -->
    <jsp:include page="studentSidebar.jsp" />
    
    <div class="main-content">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="text-white mb-2">
                    <i class="fas fa-calendar-alt me-2"></i>Browse Events
                </h2>
                <p class="text-white-50 mb-0">Discover exciting activities and events happening around campus</p>
            </div>
            <a href="student?action=dashboard" class="btn btn-light">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
        
        <!-- Filters and Search -->
        <div class="filter-card">
            <form method="GET" action="student" class="row g-3">
                <input type="hidden" name="action" value="searchEvents">
                
                <div class="col-md-4">
                    <input type="text" class="form-control search-bar" name="keyword" 
                           placeholder="Search events..." value="${searchKeyword}">
                </div>
                
                <div class="col-md-3">
                    <select class="form-select search-bar" name="category">
                        <option value="">All Categories</option>
                        <option value="academic" ${selectedCategory == 'academic' ? 'selected' : ''}>Academic</option>
                        <option value="sports" ${selectedCategory == 'sports' ? 'selected' : ''}>Sports</option>
                        <option value="cultural" ${selectedCategory == 'cultural' ? 'selected' : ''}>Cultural</option>
                        <option value="general" ${selectedCategory == 'general' ? 'selected' : ''}>General</option>
                    </select>
                </div>
                
                <div class="col-md-2">
                    <input type="date" class="form-control search-bar" name="dateFrom" 
                           placeholder="From Date" value="${searchDateFrom}">
                </div>
                
                <div class="col-md-2">
                    <input type="date" class="form-control search-bar" name="dateTo" 
                           placeholder="To Date" value="${searchDateTo}">
                </div>
                
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary w-100" style="border-radius: 25px;">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            
            <!-- Quick Filters -->
            <div class="mt-3">
                <div class="d-flex flex-wrap gap-2">
                    <a href="student?action=events" class="btn btn-filter ${empty selectedFilter ? 'active' : ''}">
                        <i class="fas fa-list me-1"></i>All Events
                    </a>
                    <a href="student?action=events&filter=free" class="btn btn-filter ${selectedFilter == 'free' ? 'active' : ''}">
                        <i class="fas fa-gift me-1"></i>Free Events
                    </a>
                    <a href="student?action=events&filter=paid" class="btn btn-filter ${selectedFilter == 'paid' ? 'active' : ''}">
                        <i class="fas fa-tag me-1"></i>Paid Events
                    </a>
                    <a href="student?action=events&category=academic" class="btn btn-filter ${selectedCategory == 'academic' ? 'active' : ''}">
                        <i class="fas fa-graduation-cap me-1"></i>Academic
                    </a>
                    <a href="student?action=events&category=sports" class="btn btn-filter ${selectedCategory == 'sports' ? 'active' : ''}">
                        <i class="fas fa-running me-1"></i>Sports
                    </a>
                    <a href="student?action=events&category=cultural" class="btn btn-filter ${selectedCategory == 'cultural' ? 'active' : ''}">
                        <i class="fas fa-theater-masks me-1"></i>Cultural
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Display Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Events Grid -->
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty events}">
                    <c:forEach var="event" items="${events}">
                        <div class="col-lg-4 col-md-6">
                            <div class="event-card">
                                <div class="event-header ${event.eventCategory}">
                                    <div class="price-tag ${event.registrationFee == null || event.registrationFee == 0 ? 'free' : ''}">
                                        <c:choose>
                                            <c:when test="${event.registrationFee == null || event.registrationFee == 0}">
                                                FREE
                                            </c:when>
                                            <c:otherwise>
                                                RM <fmt:formatNumber value="${event.registrationFee}" pattern="#,##0.00"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <h5 class="mb-2">${event.eventTitle}</h5>
                                    <div class="event-meta">
                                        <span><i class="fas fa-calendar me-1"></i>
                                            <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy"/></span>
                                        <span><i class="fas fa-clock me-1"></i>
                                            <fmt:formatDate value="${event.eventTime}" pattern="HH:mm"/></span>
                                    </div>
                                    
                                    <c:if test="${event.participantLimit > 0}">
                                        <div class="capacity-bar">
                                            <div class="capacity-fill" style="width: ${(event.currentParticipants * 100) / event.participantLimit}%"></div>
                                        </div>
                                        <small class="d-block mt-1">
                                            ${event.currentParticipants}/${event.participantLimit} participants
                                        </small>
                                    </c:if>
                                </div>
                                
                                <div class="card-body p-4">
                                    <p class="text-muted mb-3">
                                        ${event.eventDescription.length() > 120 ? 
                                          event.eventDescription.substring(0, 120) + "..." : 
                                          event.eventDescription}
                                    </p>
                                    
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="fas fa-map-marker-alt text-danger me-2"></i>
                                        <span class="text-muted">${event.eventLocation}</span>
                                    </div>
                                    
                                    
                                    <div class="d-flex align-items-center justify-content-between">
                                        <span class="badge bg-secondary">${event.eventCategory}</span>
                                        
                                        <c:choose>
                                            <c:when test="${event.currentParticipants >= event.participantLimit && event.participantLimit > 0}">
                                                <span class="badge bg-danger">FULL</span>
                                            </c:when>
                                            <c:when test="${event.registrationDeadline != null && event.registrationDeadline < now}">
                                                <span class="badge bg-warning">DEADLINE PASSED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">OPEN</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <div class="mt-4 d-grid gap-2">
                                        <a href="student?action=eventDetails&eventID=${event.eventId}" 
                                           class="btn btn-primary">
                                            <i class="fas fa-eye me-2"></i>View Details
                                        </a>
                                        
                                        <c:if test="${event.currentParticipants < event.participantLimit || event.participantLimit == 0}">
                                            <c:if test="${event.registrationDeadline == null || event.registrationDeadline >= now}">
                                                <button type="button" class="btn btn-register" 
                                                        onclick="registerQuick('${event.eventId}', '${event.eventTitle}')">
                                                    <i class="fas fa-user-plus me-2"></i>Quick Register
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <div class="bg-white rounded-4 p-5 shadow">
                                <i class="fas fa-search fa-4x text-muted mb-4"></i>
                                <h4 class="text-muted">No events found</h4>
                                <p class="text-muted mb-4">
                                    <c:choose>
                                        <c:when test="${not empty searchKeyword}">
                                            No events match your search criteria. Try different keywords or filters.
                                        </c:when>
                                        <c:otherwise>
                                            There are no events available at the moment. Check back later!
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="student?action=events" class="btn btn-primary">
                                    <i class="fas fa-refresh me-2"></i>View All Events
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Load More Button (if needed) -->
        <c:if test="${not empty events && events.size() >= 12}">
            <div class="text-center mt-5">
                <button class="btn btn-outline-light btn-lg" onclick="loadMoreEvents()">
                    <i class="fas fa-plus me-2"></i>Load More Events
                </button>
            </div>
        </c:if>
    </div>

    <!-- Quick Registration Modal -->
    <div class="modal fade" id="quickRegModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-user-plus me-2 text-success"></i>
                        Quick Registration
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to register for "<span id="quickRegEventTitle"></span>"?</p>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        You can view full event details and manage your registration from your dashboard.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success" onclick="confirmQuickRegistration()">
                        <i class="fas fa-check me-2"></i>Register Now
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let currentEventId = null;
        
        // Quick registration function
        function registerQuick(eventId, eventTitle) {
            currentEventId = eventId;
            document.getElementById('quickRegEventTitle').textContent = eventTitle;
            new bootstrap.Modal(document.getElementById('quickRegModal')).show();
        }
        
        function confirmQuickRegistration() {
            if (currentEventId) {
                // Show loading state
                const btn = document.querySelector('#quickRegModal .btn-success');
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Registering...';
                btn.disabled = true;
                
                // Submit registration
                window.location.href = 'student?action=registerEvent&eventID=' + currentEventId;
            }
        }
        
        // Auto-hide alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('alert-success') || alert.classList.contains('alert-info')) {
                    alert.style.transition = 'opacity 0.5s ease';
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                }
            });
        }, 5000);
        
        // Card animations
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.event-card');
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
        
        // Load more events (implement if needed)
        function loadMoreEvents() {
            // Implementation for pagination
            console.log('Loading more events...');
        }
        
        // Filter animations
        document.querySelectorAll('.btn-filter').forEach(btn => {
            btn.addEventListener('click', function() {
                // Add loading state
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Loading...';
            });
        });
    </script>
</body>
</html>