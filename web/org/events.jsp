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
        .main-content {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .page-header {
            background: white;
            border-bottom: 1px solid #dee2e6;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        .event-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: none;
        }
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .event-status {
            font-size: 0.85rem;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 20px;
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
        .event-date {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            margin-right: 20px;
            min-width: 80px;
        }
        .event-date .day {
            font-size: 1.5rem;
            font-weight: bold;
            display: block;
        }
        .event-date .month {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .filter-tabs .nav-link {
            color: #6c757d;
            border: none;
            background: none;
            padding: 12px 20px;
            border-radius: 8px;
            margin-right: 10px;
            transition: all 0.3s ease;
        }
        .filter-tabs .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
        }
        .btn-action {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.9rem;
            margin: 2px;
            transition: all 0.3s ease;
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
                                   class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Create New Event
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <!-- Statistics Row -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number">${totalEvents}</div>
                                <div class="text-muted">Total Events</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number text-success">${approvedEvents}</div>
                                <div class="text-muted">Approved</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number text-warning">${pendingEvents}</div>
                                <div class="text-muted">Pending</div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stats-card">
                                <div class="stats-number text-info">${upcomingEvents}</div>
                                <div class="text-muted">Upcoming</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filter Tabs -->
                    <ul class="nav filter-tabs mb-4">
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

                    <!-- Events List -->
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty events}">
                                <c:forEach var="event" items="${events}">
                                    <div class="col-12 mb-4">
                                        <div class="card event-card">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <!-- Event Date -->
                                                    <div class="col-auto">
                                                        <div class="event-date">
                                                            <span class="day">
                                                                <fmt:formatDate value="${event.eventDate}" pattern="dd"/>
                                                            </span>
                                                            <span class="month">
                                                                <fmt:formatDate value="${event.eventDate}" pattern="MMM"/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Event Details -->
                                                    <div class="col">
                                                        <div class="d-flex justify-content-between align-items-start mb-2">      
                                                            <h5 class="card-title mb-0">${event.eventTitle}</h5>
                                                            <span class="event-status status-${fn:toLowerCase(event.eventStatus)}">
                                                                <i class="fas fa-circle me-1"></i>
                                                                ${event.eventStatus}
                                                            </span>

                                                        </div>
                                                        
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-map-marker-alt me-2"></i>
                                                            ${event.eventLocation}
                                                        </p>
                                                        
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-clock me-2"></i>
                                                            <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy"/> 
                                                            at <fmt:formatDate value="${event.eventTime}" pattern="HH:mm"/>
                                                        </p>
                                                        
                                                        <c:if test="${not empty event.eventDescription}">
                                                            <p class="card-text text-muted mb-3">
                                                                ${fn:length(event.eventDescription) > 150 ? 
                                                                  fn:substring(event.eventDescription, 0, 150).concat('...') : 
                                                                  event.eventDescription}
                                                            </p>
                                                        </c:if>
                                                        
                                                        <!-- Event Stats -->
                                                        <div class="row text-center mb-3">
                                                            <div class="col-4">
                                                                <small class="text-muted d-block">Registered</small>
                                                                <strong>${event.registeredCount}/${event.participantLimit}</strong>
                                                            </div>
                                                            <div class="col-4">
                                                                <small class="text-muted d-block">Category</small>
                                                                <strong>${event.eventCategory}</strong>
                                                            </div>
                                                            <div class="col-4">
                                                                <small class="text-muted d-block">Created</small>
                                                                <strong>
                                                                    <fmt:formatDate value="${event.createdAt}" pattern="MMM dd"/>
                                                                </strong>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Action Buttons -->
                                                    <div class="col-auto">
                                                        <div class="d-flex flex-column">
                                                            <a href="${pageContext.request.contextPath}/organization?action=viewEvent&id=${event.eventID}" 
                                                               class="btn btn-outline-primary btn-action">
                                                                <i class="fas fa-eye me-1"></i>View
                                                            </a>
                                                            
                                                            <c:if test="${event.eventStatus == 'DRAFT' or event.eventStatus == 'REJECTED'}">
                                                                <a href="${pageContext.request.contextPath}/organization?action=editEvent&id=${event.eventID}" 
                                                                   class="btn btn-outline-secondary btn-action">
                                                                    <i class="fas fa-edit me-1"></i>Edit
                                                                </a>
                                                            </c:if>
                                                            
                                                            <c:if test="${event.eventStatus == 'APPROVED'}">
                                                                <a href="${pageContext.request.contextPath}/organization?action=eventParticipants&id=${event.eventID}" 
                                                                   class="btn btn-outline-info btn-action">
                                                                    <i class="fas fa-users me-1"></i>Participants
                                                                </a>
                                                            </c:if>

                                                                        <a class="dropdown-item" 
                                                                           href="${pageContext.request.contextPath}/organization?action=exportEvent&id=${event.eventID}">
                                                                            <i class="fas fa-download me-2"></i>Export
                                                                        </a>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="empty-state">
                                        <i class="fas fa-calendar-times"></i>
                                        <h4>No Events Found</h4>
                                        <p>You haven't created any events yet. Start by creating your first event!</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Events pagination">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&filter=${param.filter}">Previous</a>
                                    </li>
                                </c:if>
                                
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <li class="page-item ${page == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/organization?page=${page}&filter=${param.filter}">${page}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/organization?page=${currentPage + 1}&filter=${param.filter}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this event? This action cannot be undone.</p>
                    <p class="text-muted small">Note: If participants have already registered, they will be notified of the cancellation.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete Event</a>
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

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });

        // Add smooth scrolling for better UX
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
    </script>
</body>
</html>