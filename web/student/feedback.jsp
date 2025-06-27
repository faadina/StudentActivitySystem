<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Feedback - UiTM Activity System</title>
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
        
        .feedback-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .feedback-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .event-summary {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .rating-section {
            margin: 30px 0;
        }
        
        .rating-group {
            margin-bottom: 25px;
        }
        
        .rating-label {
            font-weight: 600;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .star-rating {
            display: flex;
            gap: 5px;
            margin-bottom: 10px;
        }
        
        .star {
            font-size: 2rem;
            color: #e9ecef;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .star:hover,
        .star.active {
            color: #f39c12;
            transform: scale(1.1);
        }
        
        .star.hover {
            color: #f1c40f;
        }
        
        .rating-text {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .comment-section {
            margin: 30px 0;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 15px 20px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .btn-submit {
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
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(39, 174, 96, 0.3);
            color: white;
        }
        
        .btn-cancel {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.3);
            color: white;
        }
        
        .feedback-list {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .feedback-item {
            border: 2px solid #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .feedback-item:hover {
            border-color: #3498db;
            background: rgba(52, 152, 219, 0.05);
        }
        
        .feedback-item.pending {
            border-color: #f39c12;
            background: rgba(243, 156, 18, 0.05);
        }
        
        .feedback-item.completed {
            border-color: #27ae60;
            background: rgba(39, 174, 96, 0.05);
        }
        
        .event-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .event-meta {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .feedback-status {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .quick-feedback {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
        }
        
        .emoji-rating {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }
        
        .emoji-option {
            text-align: center;
            cursor: pointer;
            padding: 15px;
            border-radius: 15px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .emoji-option:hover,
        .emoji-option.selected {
            background: white;
            border-color: #3498db;
            transform: scale(1.05);
        }
        
        .emoji {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        
        .feedback-stats {
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
            
            .star {
                font-size: 1.5rem;
            }
            
            .emoji {
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
        
        <div class="feedback-container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2 class="mb-2">
                            <i class="fas fa-comment-alt me-2 text-primary"></i>
                            Event Feedback
                        </h2>
                        <p class="mb-0 text-muted">
                            Help us improve by sharing your event experience
                        </p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <div class="text-muted">
                            <i class="fas fa-star me-2"></i>
                            Your feedback matters!
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Feedback Statistics -->
            <div class="feedback-stats">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number text-primary">${totalFeedbacks}</div>
                            <div class="stat-label">Feedbacks Given</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number text-warning">${pendingFeedbacks}</div>
                            <div class="stat-label">Pending Reviews</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number text-success">4.2</div>
                            <div class="stat-label">Avg Rating Given</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <div class="stat-number text-info">${completedEvents}</div>
                            <div class="stat-label">Events Attended</div>
                        </div>
                    </div>
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
            
            <!-- Feedback Form (if specific event) -->
            <c:if test="${not empty event}">
                <div class="event-summary">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="mb-2">${event.eventTitle}</h4>
                            <p class="mb-1 opacity-75">
                                <i class="fas fa-calendar me-2"></i>
                                <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy"/>
                            </p>
                            <p class="mb-0 opacity-75">
                                <i class="fas fa-map-marker-alt me-2"></i>
                                ${event.eventLocation}
                            </p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <div class="badge bg-white text-primary fs-6 px-3 py-2">
                                ${event.eventCategory}
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="feedback-card">
                    <form id="feedbackForm" method="POST" action="student">
                        <input type="hidden" name="action" value="submitFeedback">
                        <input type="hidden" name="eventId" value="${event.eventId}">
                        <input type="hidden" name="overallRating" id="overallRatingInput" value="0">
                        
                        <h4 class="mb-4">
                            <i class="fas fa-star me-2 text-warning"></i>
                            Rate Your Experience
                        </h4>
                        
                        <!-- Overall Rating -->
                        <div class="rating-group">
                            <div class="rating-label">Overall Experience</div>
                            <div class="star-rating" data-rating="overall">
                                <span class="star" data-value="1">★</span>
                                <span class="star" data-value="2">★</span>
                                <span class="star" data-value="3">★</span>
                                <span class="star" data-value="4">★</span>
                                <span class="star" data-value="5">★</span>
                            </div>
                            <div class="rating-text" id="overallText">Click stars to rate</div>
                        </div>
                        
                        <!-- Quick Emoji Rating -->
                        <div class="quick-feedback">
                            <h6 class="mb-3">Quick Rating</h6>
                            <div class="emoji-rating">
                                <div class="emoji-option" onclick="setEmojiRating(1)">
                                    <div class="emoji">😞</div>
                                    <small>Poor</small>
                                </div>
                                <div class="emoji-option" onclick="setEmojiRating(2)">
                                    <div class="emoji">😕</div>
                                    <small>Fair</small>
                                </div>
                                <div class="emoji-option" onclick="setEmojiRating(3)">
                                    <div class="emoji">😐</div>
                                    <small>Good</small>
                                </div>
                                <div class="emoji-option" onclick="setEmojiRating(4)">
                                    <div class="emoji">😊</div>
                                    <small>Great</small>
                                </div>
                                <div class="emoji-option" onclick="setEmojiRating(5)">
                                    <div class="emoji">😍</div>
                                    <small>Excellent</small>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Comments -->
                        <div class="comment-section">
                            <label for="comment" class="form-label">
                                <i class="fas fa-comment me-2"></i>
                                Tell us about your experience
                            </label>
                            <textarea class="form-control" name="comment" id="comment" rows="6"
                                      placeholder="Share your thoughts about the event, organization, content, and any suggestions for improvement..."></textarea>
                            <div class="form-text">
                                Your feedback helps us improve future events. Be honest and constructive!
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="row g-3 mt-4">
                            <div class="col-md-6">
                                <a href="student?action=feedback" class="btn-cancel">
                                    <i class="fas fa-arrow-left me-2"></i>Back to List
                                </a>
                            </div>
                            <div class="col-md-6">
                                <button type="submit" class="btn-submit" id="submitBtn" disabled>
                                    <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </c:if>
            
            <!-- Events Awaiting Feedback -->
            <c:if test="${empty event}">
                <div class="feedback-list">
                    <h4 class="mb-4">
                        <i class="fas fa-list me-2 text-primary"></i>
                        Events Awaiting Your Feedback
                    </h4>
                    
                    <c:choose>
                        <c:when test="${not empty completedEvents}">
                            <c:forEach var="completedEvent" items="${completedEvents}">
                                <div class="feedback-item ${completedEvent.feedbackGiven ? 'completed' : 'pending'}" 
                                     onclick="goToFeedback('${completedEvent.eventId}')">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="flex-grow-1">
                                            <div class="event-title">${completedEvent.eventTitle}</div>
                                            <div class="event-meta">
                                                <i class="fas fa-calendar me-2"></i>
                                                <fmt:formatDate value="${completedEvent.eventDate}" pattern="MMM dd, yyyy"/>
                                                <span class="ms-3">
                                                    <i class="fas fa-map-marker-alt me-2"></i>
                                                    ${completedEvent.eventLocation}
                                                </span>
                                                <span class="ms-3">
                                                    <i class="fas fa-tag me-2"></i>
                                                    ${completedEvent.eventCategory}
                                                </span>
                                            </div>
                                            <p class="text-muted mt-2 mb-0">
                                                ${completedEvent.eventDescription.length() > 100 ? 
                                                  completedEvent.eventDescription.substring(0, 100) + "..." : 
                                                  completedEvent.eventDescription}
                                            </p>
                                        </div>
                                        <div class="ms-3">
                                            <c:choose>
                                                <c:when test="${completedEvent.feedbackGiven}">
                                                    <span class="feedback-status status-completed">
                                                        <i class="fas fa-check me-1"></i>Feedback Given
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="feedback-status status-pending">
                                                        <i class="fas fa-clock me-1"></i>Pending Review
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not completedEvent.feedbackGiven}">
                                        <div class="mt-3">
                                            <button class="btn btn-primary btn-sm" onclick="event.stopPropagation(); goToFeedback('${completedEvent.eventId}')">
                                                <i class="fas fa-star me-2"></i>Give Feedback
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-comment-slash fa-4x text-muted mb-4"></i>
                                <h5 class="text-muted mb-3">No Events to Review</h5>
                                <p class="text-muted mb-4">
                                    You don't have any completed events that need feedback. 
                                    Attend events to share your experience!
                                </p>
                                <a href="student?action=events" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Browse Events
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        let currentRating = 0;
        const ratingTexts = {
            0: "Click stars to rate",
            1: "Poor - Needs significant improvement",
            2: "Fair - Below expectations",
            3: "Good - Met expectations",
            4: "Great - Exceeded expectations", 
            5: "Excellent - Outstanding experience"
        };
        
        // Toggle sidebar for mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
        }
        
        // Star rating functionality
        document.querySelectorAll('.star-rating').forEach(ratingContainer => {
            const stars = ratingContainer.querySelectorAll('.star');
            
            stars.forEach((star, index) => {
                star.addEventListener('mouseenter', () => {
                    highlightStars(stars, index + 1);
                });
                
                star.addEventListener('mouseleave', () => {
                    highlightStars(stars, currentRating);
                });
                
                star.addEventListener('click', () => {
                    currentRating = index + 1;
                    highlightStars(stars, currentRating);
                    updateRatingInputs(currentRating);
                    updateRatingText(currentRating);
                    validateForm();
                });
            });
        });
        
        function highlightStars(stars, rating) {
            stars.forEach((star, index) => {
                star.classList.toggle('active', index < rating);
            });
        }
        
        function updateRatingInputs(rating) {
            document.getElementById('overallRatingInput').value = rating;
        }
        
        function updateRatingText(rating) {
            document.getElementById('overallText').textContent = ratingTexts[rating];
        }
        
        // Emoji rating
        function setEmojiRating(rating) {
            // Remove previous selection
            document.querySelectorAll('.emoji-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Add selection to clicked emoji
            event.currentTarget.classList.add('selected');
            
            // Update star rating
            currentRating = rating;
            const stars = document.querySelectorAll('.star');
            highlightStars(stars, rating);
            updateRatingInputs(rating);
            updateRatingText(rating);
            validateForm();
        }
        
        // Go to specific event feedback
        function goToFeedback(eventId) {
            window.location.href = 'student?action=feedback&eventId=' + eventId;
        }
        
        // Form validation
        function validateForm() {
            const submitBtn = document.getElementById('submitBtn');
            if (submitBtn) {
                submitBtn.disabled = currentRating === 0;
            }
        }
        
        // Form submission
        document.getElementById('feedbackForm')?.addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Submitting...';
            submitBtn.disabled = true;
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
        
        // Add animation to feedback items on load
        document.addEventListener('DOMContentLoaded', function() {
            const items = document.querySelectorAll('.feedback-item');
            items.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>