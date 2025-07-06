<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Events - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
:root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 15px rgba(0,0,0,0.1);
            --card-hover-shadow: 0 8px 25px rgba(0,0,0,0.15);
            --border-radius: 12px;
        }

        .main-content {
            background-color: var(--light-bg);
            min-height: 100vh;
        }

        .page-header {
            background: white;
            border-bottom: 1px solid #dee2e6;
            padding: 20px 0;
            margin-bottom: 30px;
        }

        /* Enhanced Event Cards - Compact version */
        .event-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
            position: relative;
            margin-bottom: 15px;
            max-width: 350px; /* Still keeps individual card width manageable */
        }

        .event-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-hover-shadow);
        }

        .event-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .event-card-body {
            padding: 15px; /* Reduced padding for compact cards */
        }

        .event-header {
            display: flex;
            justify-content: between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .event-title {
            font-size: 1.1rem; /* Slightly smaller title */
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .event-company {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 12px;
            font-weight: 500;
        }

        .event-location {
            color: #e74c3c;
            font-size: 0.85rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .event-location i {
            margin-right: 5px;
            font-size: 0.8rem;
        }

        /* Status Badge */
        .status-badge {
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

        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .status-draft {
            background-color: #e2e3e5;
            color: #383d41;
        }

        /* Match Percentage Style */
        .match-percentage {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--success-color);
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .match-warning {
            background: var(--warning-color);
            color: #856404;
        }

        .match-info {
            background: var(--info-color);
        }

        /* Skills/Tags Section */
        .event-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 15px;
        }

        .event-tag {
            background-color: #e9ecef;
            color: #495057;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .event-tag.primary {
            background-color: #cfe2ff;
            color: #0b3d91;
        }

        /* Enhanced Stats */
        .event-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding: 10px 0;
            border-top: 1px solid #e9ecef;
        }

        .stat-item {
            text-align: center;
            flex: 1;
        }

        .stat-value {
            font-weight: 600;
            font-size: 1.1rem;
            color: #2c3e50;
        }

        .stat-label {
            font-size: 0.75rem;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Action Button */
        .event-action {
            width: 100%;
            padding: 10px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: block;
        }

        .event-action.primary {
            background: var(--primary-gradient);
            color: white;
        }

        .event-action.outline {
            border-color: #6c757d;
            color: #6c757d;
            background: white;
        }

        .event-action:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        /* Filter Tabs Enhancement */
        .filter-tabs {
            background: white;
            border-radius: var(--border-radius);
            padding: 10px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }

        .filter-tabs .nav-link {
            color: #6c757d;
            border: none;
            background: none;
            padding: 12px 20px;
            border-radius: 8px;
            margin-right: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .filter-tabs .nav-link.active {
            background: var(--primary-gradient);
            color: white;
        }

        .filter-tabs .nav-link:hover:not(.active) {
            background-color: #f8f9fa;
        }

        /* Enhanced Statistics Cards */
        .stats-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 15px 12px;
            text-align: center;
            box-shadow: var(--card-shadow);
            border: none;
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-2px);
        }

        .stats-number {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stats-label {
            color: #7f8c8d;
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stats-primary { color: #667eea; }
        .stats-success { color: var(--success-color); }
        .stats-warning { color: var(--warning-color); }
        .stats-info { color: var(--info-color); }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #6c757d;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 5rem;
            margin-bottom: 30px;
            opacity: 0.3;
            color: #667eea;
        }

        .empty-state h4 {
            color: #2c3e50;
            margin-bottom: 15px;
        }

/* Responsive Grid - Compact cards */
        .event-grid {
            display: flex; /* Change from grid to flex */
            flex-wrap: wrap; /* Allow items to wrap to the next line */
            gap: 20px;
            justify-content: start; /* Center the flex items horizontally */
            /* You don't need grid-template-columns with flexbox */
        }
        
        .event-card {
            /* Keep max-width: 350px; or set a specific width */
            width: 350px; /* Or min-width: 300px; max-width: 350px; */
            margin-bottom: 15px; /* Keep this for vertical spacing */
            /* ... other styles ... */
        }

        /* This general mobile responsiveness for card body and stats is good to keep */
        @media (max-width: 767px) {
            .event-card-body {
                padding: 15px;
            }
            
            .event-title {
                font-size: 1.1rem;
            }
            
            .event-stats {
                flex-direction: column;
                gap: 10px;
            }
            
            .stat-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                text-align: left;
            }
        }

        /* Animation for page load */
        .event-card {
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
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="organizationSidebar.jsp" />

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <div class="page-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <h2 class="mb-0">
                                    <i class="fas fa-calendar-alt me-2 text-primary"></i>
                                    My Events
                                </h2>
                                <p class="text-muted mb-0">Manage your organization's events</p>
                            </div>
                            <div class="col-auto">
                                <a href="${pageContext.request.contextPath}/organization?action=createEvent" 
                                   class="btn btn-primary btn-lg">
                                    <i class="fas fa-plus me-2"></i>Create New Event
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <!-- Enhanced Statistics Row -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number stats-primary">${totalEvents}</div>
                                <div class="stats-label">Total Events</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number stats-success">${approvedEvents}</div>
                                <div class="stats-label">Approved</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number stats-warning">${pendingEvents}</div>
                                <div class="stats-label">Pending</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number stats-info">${upcomingEvents}</div>
                                <div class="stats-label">Upcoming</div>
                            </div>
                        </div>
                    </div>

                    <!-- Enhanced Filter Tabs -->
                    <ul class="nav filter-tabs">
                        <li class="nav-item">
                            <a class="nav-link ${empty param.filter or param.filter == 'all' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/organization?action=events&filter=all">
                                <i class="fas fa-list me-2"></i>All Events
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.filter == 'approved' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/organization?action=events&filter=approved">
                                <i class="fas fa-check-circle me-2"></i>Approved
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.filter == 'pending' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/organization?action=events&filter=pending">
                                <i class="fas fa-clock me-2"></i>Pending
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.filter == 'upcoming' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/organization?action=events&filter=upcoming">
                                <i class="fas fa-calendar-plus me-2"></i>Upcoming
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.filter == 'past' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/organization?action=events&filter=past">
                                <i class="fas fa-history me-2"></i>Past Events
                            </a>
                        </li>
                    </ul>

                    <!-- Enhanced Events Grid -->
                    <c:choose>
                        <c:when test="${not empty events}">
                            <div class="event-grid">
                                <c:forEach var="event" items="${events}">
                                    <div class="event-card">
                                        <div class="event-card-body">
                                            <!-- Status Badge (Career-style match percentage) -->
                                            <c:choose>
                                                <c:when test="${event.eventStatus == 'APPROVED'}">
                                                    <div class="match-percentage">
                                                        <c:choose>
                                                            <c:when test="${event.registeredCount >= event.participantLimit * 0.8}">
                                                                95% Match
                                                            </c:when>
                                                            <c:when test="${event.registeredCount >= event.participantLimit * 0.5}">
                                                                85% Match
                                                            </c:when>
                                                            <c:otherwise>
                                                                70% Match
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${event.eventStatus == 'PENDING'}">
                                                    <div class="match-percentage match-warning">
                                                        Under Review
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="match-percentage match-info">
                                                        ${event.eventStatus}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Event Title -->
                                            <h3 class="event-title">${event.eventTitle}</h3>
                                            
                                            <!-- Organization/Company equivalent -->
                                            <div class="event-company">
                                                <i class="fas fa-building me-1"></i>
                                                UiTM Activity Organization
                                            </div>
                                            
                                            <!-- Location -->
                                            <div class="event-location">
                                                <i class="fas fa-map-marker-alt"></i>
                                                ${event.eventLocation}
                                            </div>

                                            <!-- Event Details/Tags -->
                                            <div class="event-tags">
                                                <span class="event-tag primary">${event.eventCategory}</span>
                                                <span class="event-tag">
                                                    <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy"/>
                                                </span>
                                                <span class="event-tag">
                                                    <fmt:formatDate value="${event.eventTime}" pattern="HH:mm"/>
                                                </span>
                                                <c:if test="${event.registeredCount >= event.participantLimit * 0.8}">
                                                    <span class="event-tag" style="background-color: #fff3cd; color: #856404;">
                                                        Almost Full
                                                    </span>
                                                </c:if>
                                            </div>

                                            <!-- Event Stats -->
                                            <div class="event-stats">
                                                <div class="stat-item">
                                                    <div class="stat-value">${event.registeredCount}/${event.participantLimit}</div>
                                                    <div class="stat-label">Registered</div>
                                                </div>
                                                <div class="stat-item">
                                                    <div class="stat-value">
                                                        <fmt:formatDate value="${event.eventDate}" pattern="dd"/>
                                                    </div>
                                                    <div class="stat-label">
                                                        <fmt:formatDate value="${event.eventDate}" pattern="MMM"/>
                                                    </div>
                                                </div>
                                                <div class="stat-item">
                                                    <div class="stat-value">
                                                        <fmt:formatDate value="${event.createdAt}" pattern="dd"/>
                                                    </div>
                                                    <div class="stat-label">Created</div>
                                                </div>
                                            </div>

                                            <!-- Action Button -->
                                            <c:choose>
                                                <c:when test="${event.eventStatus == 'APPROVED'}">
                                                    <a href="${pageContext.request.contextPath}/organization?action=eventParticipants&id=${event.eventID}" 
                                                       class="event-action primary">
                                                        <i class="fas fa-users me-2"></i>View Participants
                                                    </a>
                                                </c:when>
                                                <c:when test="${event.eventStatus == 'DRAFT' or event.eventStatus == 'REJECTED'}">
                                                    <a href="${pageContext.request.contextPath}/organization?action=editEvent&id=${event.eventID}" 
                                                       class="event-action outline">
                                                        <i class="fas fa-edit me-2"></i>Edit Event
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/organization?action=viewEvent&id=${event.eventID}" 
                                                       class="event-action outline">
                                                        <i class="fas fa-eye me-2"></i>View Details
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <h4>No Events Found</h4>
                                <p>You haven't created any events yet. Start by creating your first event!</p>
                                <a href="${pageContext.request.contextPath}/organization?action=createEvent" 
                                   class="btn btn-primary btn-lg mt-3">
                                    <i class="fas fa-plus me-2"></i>Create Your First Event
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Enhanced Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Events pagination" class="mt-5">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&filter=${param.filter}">
                                            <i class="fas fa-chevron-left"></i> Previous
                                        </a>
                                    </li>
                                </c:if>
                                
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <li class="page-item ${page == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/organization?page=${page}&filter=${param.filter}">${page}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/organization?page=${currentPage + 1}&filter=${param.filter}">
                                            Next <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Enhanced Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 12px; border: none;">
                <div class="modal-header" style="border-bottom: 1px solid #e9ecef;">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                        Confirm Delete
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-3">Are you sure you want to delete this event? This action cannot be undone.</p>
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Note:</strong> If participants have already registered, they will be notified of the cancellation.
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 1px solid #e9ecef;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Delete Event
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(eventId) {
            const deleteBtn = document.getElementById('confirmDeleteBtn');
            deleteBtn.href = '${pageContext.request.contextPath}/organization?action=deleteEvent&id=' + eventId;
            
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        // Enhanced auto-hide alerts
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });

            // Add stagger animation to cards
            const cards = document.querySelectorAll('.event-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });

        // Enhanced smooth scrolling
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

        // Add loading state for buttons
        document.querySelectorAll('.event-action').forEach(button => {
            button.addEventListener('click', function() {
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                this.classList.add('disabled');
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.classList.remove('disabled');
                }, 2000);
            });
        });
        
        
    </script>
</body>
</html>