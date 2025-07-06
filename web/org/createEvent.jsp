<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .page-header {
            background: white;
            border-bottom: 1px solid #dee2e6;
            padding: 20px 0; /* This padding makes it taller */
            margin-bottom: 30px;
        }

    
    
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .form-step {
            display: none;
        }
        
        .form-step.active {
            display: block;
        }
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 10px;
            color: #6c757d;
            font-weight: bold;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .step.active {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }
        
        .step.completed {
            background: #28a745;
            color: white;
        }
        
        .step::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 100%;
            width: 80px;
            height: 2px;
            background: #e9ecef;
            z-index: -1;
        }
        
        .step:last-child::after {
            display: none;
        }
        
        .step.completed::after {
            background: #28a745;
        }
        
        .preview-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
        
        .category-card {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .category-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
        }
        
        .category-card.selected {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }
        
        .category-card input[type="radio"] {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
        <jsp:include page="organizationSidebar.jsp" />
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <!-- Top Navigation -->
                <div class="page-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <h2 class="mb-0">
                                    <i class="fas fa-plus-circle me-2 text-primary"></i>
                                    Create New Event
                                </h2>
                                <p class="text-muted mb-0">Fill in the details to create your new event</p>
                            </div>
                            </div>
                    </div>
                </div>
                
                <!-- Create Event Form -->
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <!-- Step Indicator -->
                            <div class="step-indicator">
                                <div class="step active" id="step-1">1</div>
                                <div class="step" id="step-2">2</div>
                                <div class="step" id="step-3">3</div>
                                <div class="step" id="step-4">4</div>
                            </div>
                            
                            <div class="card">
                                <div class="card-body p-4">
                                    <!-- Display Messages -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">
                                            <i class="fas fa-exclamation-circle me-2"></i>
                                            ${error}
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty success}">
                                        <div class="alert alert-success" role="alert">
                                            <i class="fas fa-check-circle me-2"></i>
                                            ${success}
                                        </div>
                                    </c:if>
                                    
                                    <form action="${pageContext.request.contextPath}/organization?action=createEvent" method="post">

                                        <input type="hidden" name="action" value="createEvent">
                                        
                                        <!-- Step 1: Basic Information -->
                                        <div class="form-step active" id="step1">
                                            <h4 class="text-center mb-4">
                                                <i class="fas fa-info-circle me-2 text-primary"></i>
                                                Basic Event Information
                                            </h4>
                                            
                                            <div class="row g-4">
                                                <div class="col-12">
                                                    <label for="eventTitle" class="form-label">
                                                        <i class="fas fa-heading me-2"></i>Event Title
                                                    </label>
                                                    <input type="text" class="form-control" id="eventTitle" name="eventTitle" 
                                                           placeholder="Enter an engaging event title" required>
                                                    <div class="invalid-feedback">
                                                        Please provide a valid event title.
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="eventDate" class="form-label">
                                                        <i class="fas fa-calendar me-2"></i>Event Date
                                                    </label>
                                                    <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                                                    <div class="invalid-feedback">
                                                        Please select an event date.
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="eventTime" class="form-label">
                                                        <i class="fas fa-clock me-2"></i>Event Time
                                                    </label>
                                                    <input type="time" class="form-control" id="eventTime" name="eventTime" required>
                                                    <div class="invalid-feedback">
                                                        Please select an event time.
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label for="eventLocation" class="form-label">
                                                        <i class="fas fa-map-marker-alt me-2"></i>Event Location
                                                    </label>
                                                    <input type="text" class="form-control" id="eventLocation" name="eventLocation" 
                                                           placeholder="e.g., Dewan Lestari, Computer Lab A" required>
                                                    <div class="invalid-feedback">
                                                        Please specify the event location.
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label for="eventDescription" class="form-label">
                                                        <i class="fas fa-align-left me-2"></i>Event Description
                                                    </label>
                                                    <textarea class="form-control" id="eventDescription" name="eventDescription" 
                                                              rows="4" placeholder="Describe your event, objectives, and what participants can expect..." required></textarea>
                                                    <div class="invalid-feedback">
                                                        Please provide an event description.
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="text-center mt-4">
                                                <button type="button" class="btn btn-primary" onclick="nextStep()">
                                                    Next <i class="fas fa-arrow-right ms-2"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 2: Category & Participants -->
                                        <div class="form-step" id="step2">
                                            <h4 class="text-center mb-4">
                                                <i class="fas fa-tags me-2 text-primary"></i>
                                                Category & Participants
                                            </h4>
                                            
                                            <div class="row g-4">
                                                <div class="col-12">
                                                    <label class="form-label">
                                                        <i class="fas fa-list me-2"></i>Event Category
                                                    </label>
                                                    <div class="row g-3">
                                                        <div class="col-md-3">
                                                            <div class="category-card" onclick="selectCategory('academic')">
                                                                <input type="radio" name="eventCategory" value="academic" id="academic" required>
                                                                <i class="fas fa-graduation-cap fa-2x text-primary mb-2"></i>
                                                                <h6>Academic</h6>
                                                                <small class="text-muted">Workshops, seminars, competitions</small>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-md-3">
                                                            <div class="category-card" onclick="selectCategory('sports')">
                                                                <input type="radio" name="eventCategory" value="sports" id="sports" required>
                                                                <i class="fas fa-running fa-2x text-success mb-2"></i>
                                                                <h6>Sports</h6>
                                                                <small class="text-muted">Tournaments, fitness activities</small>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-md-3">
                                                            <div class="category-card" onclick="selectCategory('cultural')">
                                                                <input type="radio" name="eventCategory" value="cultural" id="cultural" required>
                                                                <i class="fas fa-theater-masks fa-2x text-warning mb-2"></i>
                                                                <h6>Cultural</h6>
                                                                <small class="text-muted">Arts, performances, celebrations</small>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-md-3">
                                                            <div class="category-card" onclick="selectCategory('general')">
                                                                <input type="radio" name="eventCategory" value="general" id="general" required>
                                                                <i class="fas fa-users fa-2x text-info mb-2"></i>
                                                                <h6>General</h6>
                                                                <small class="text-muted">Social events, networking</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="participantLimit" class="form-label">
                                                        <i class="fas fa-users me-2"></i>Participant Limit
                                                    </label>
                                                    <input type="number" class="form-control" id="participantLimit" name="participantLimit" 
                                                           placeholder="Maximum number of participants" min="1" max="1000" required>
                                                    <div class="form-text">Enter 0 for unlimited participants</div>
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="registrationDeadline" class="form-label">
                                                        <i class="fas fa-calendar-times me-2"></i>Registration Deadline
                                                    </label>
                                                    <input type="date" class="form-control" id="registrationDeadline" name="registrationDeadline" required>
                                                    <div class="invalid-feedback">
                                                        Please set a registration deadline.
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label for="registrationFee" class="form-label">
                                                        <i class="fas fa-money-bill me-2"></i>Registration Fee (RM)
                                                    </label>
                                                    <input type="number" class="form-control" id="registrationFee" name="registrationFee" 
                                                           placeholder="0.00" min="0" step="0.01">
                                                    <div class="form-text">Leave blank or enter 0 for free events</div>
                                                </div>
                                            </div>
                                            
                                            <div class="d-flex justify-content-between mt-4">
                                                <button type="button" class="btn btn-outline-secondary" onclick="prevStep()">
                                                    <i class="fas fa-arrow-left me-2"></i>Back
                                                </button>
                                                <button type="button" class="btn btn-primary" onclick="nextStep()">
                                                    Next <i class="fas fa-arrow-right ms-2"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 3: Additional Details -->
                                        <div class="form-step" id="step3">
                                            <h4 class="text-center mb-4">
                                                <i class="fas fa-cogs me-2 text-primary"></i>
                                                Additional Details
                                            </h4>
                                            
                                            <div class="row g-4">
                                                <div class="col-12">
                                                    <div class="card bg-light">
                                                        <div class="card-body">
                                                            <h6 class="card-title">
                                                                <i class="fas fa-info-circle me-2"></i>Event Requirements
                                                            </h6>
                                                            <div class="row g-3">
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" id="needsVenue" name="requirements" value="venue">
                                                                        <label class="form-check-label" for="needsVenue">
                                                                            <i class="fas fa-building me-2"></i>Venue Booking Required
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" id="needsEquipment" name="requirements" value="equipment">
                                                                        <label class="form-check-label" for="needsEquipment">
                                                                            <i class="fas fa-laptop me-2"></i>Equipment Needed
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" id="needsCatering" name="requirements" value="catering">
                                                                        <label class="form-check-label" for="needsCatering">
                                                                            <i class="fas fa-utensils me-2"></i>Catering Required
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label for="specialInstructions" class="form-label">
                                                        <i class="fas fa-clipboard-list me-2"></i>Special Instructions / Notes
                                                    </label>
                                                    <textarea class="form-control" id="specialInstructions" name="specialInstructions" 
                                                              rows="3" placeholder="Any special requirements, instructions for participants, or additional notes..."></textarea>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label for="contactPerson" class="form-label">
                                                        <i class="fas fa-user-tie me-2"></i>Contact Person
                                                    </label>
                                                    <input type="text" class="form-control" id="contactPerson" name="contactPerson" 
                                                           placeholder="Name of person to contact for event inquiries">
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="contactEmail" class="form-label">
                                                        <i class="fas fa-envelope me-2"></i>Contact Email
                                                    </label>
                                                    <input type="email" class="form-control" id="contactEmail" name="contactEmail" 
                                                           placeholder="Contact email for inquiries">
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label for="contactPhone" class="form-label">
                                                        <i class="fas fa-phone me-2"></i>Contact Phone
                                                    </label>
                                                    <input type="tel" class="form-control" id="contactPhone" name="contactPhone" 
                                                           placeholder="Contact phone number">
                                                </div>
                                            </div>
                                            
                                            <div class="d-flex justify-content-between mt-4">
                                                <button type="button" class="btn btn-outline-secondary" onclick="prevStep()">
                                                    <i class="fas fa-arrow-left me-2"></i>Back
                                                </button>
                                                <button type="button" class="btn btn-primary" onclick="nextStep()">
                                                    Review <i class="fas fa-arrow-right ms-2"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 4: Review & Submit -->
                                        <div class="form-step" id="step4">
                                            <h4 class="text-center mb-4">
                                                <i class="fas fa-eye me-2 text-primary"></i>
                                                Review Your Event
                                            </h4>
                                            
                                            <div class="row g-4">
                                                <div class="col-lg-8">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6 class="mb-0">Event Details Summary</h6>
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="row g-3">
                                                                <div class="col-md-6">
                                                                    <strong>Event Title:</strong>
                                                                    <p id="review-title" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Category:</strong>
                                                                    <p id="review-category" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Date & Time:</strong>
                                                                    <p id="review-datetime" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Location:</strong>
                                                                    <p id="review-location" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Participant Limit:</strong>
                                                                    <p id="review-participants" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Registration Fee:</strong>
                                                                    <p id="review-fee" class="text-muted mb-0">-</p>
                                                                </div>
                                                                <div class="col-12">
                                                                    <strong>Description:</strong>
                                                                    <p id="review-description" class="text-muted mb-0">-</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-lg-4">
                                                    <div class="preview-card card">
                                                        <div class="card-body">
                                                            <h6 class="text-white mb-3">
                                                                <i class="fas fa-eye me-2"></i>Event Preview
                                                            </h6>
                                                            <div class="event-preview">
                                                                <h5 id="preview-title" class="text-white mb-2">Event Title</h5>
                                                                <p class="text-white-50 mb-2">
                                                                    <i class="fas fa-calendar me-2"></i>
                                                                    <span id="preview-date">Date</span>
                                                                </p>
                                                                <p class="text-white-50 mb-2">
                                                                    <i class="fas fa-clock me-2"></i>
                                                                    <span id="preview-time">Time</span>
                                                                </p>
                                                                <p class="text-white-50 mb-2">
                                                                    <i class="fas fa-map-marker-alt me-2"></i>
                                                                    <span id="preview-location">Location</span>
                                                                </p>
                                                                <p class="text-white-50 mb-3">
                                                                    <i class="fas fa-users me-2"></i>
                                                                    <span id="preview-participants">Participants</span>
                                                                </p>
                                                                <span id="preview-fee" class="badge bg-light text-dark">FREE</span>
                                                                <span id="preview-category" class="badge bg-white text-dark ms-2">Category</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="card mt-3">
                                                        <div class="card-body">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" id="confirmDetails" required>
                                                                <label class="form-check-label" for="confirmDetails">
                                                                    I confirm that all event details are correct and complete
                                                                </label>
                                                            </div>
                                                            <div class="form-check mt-2">
                                                                <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                                                <label class="form-check-label" for="agreeTerms">
                                                                    I agree to the event management terms and conditions
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="d-flex justify-content-between mt-4">
                                                <button type="button" class="btn btn-outline-secondary" onclick="prevStep()">
                                                    <i class="fas fa-arrow-left me-2"></i>Back
                                                </button>
                                                <button type="submit" class="btn btn-primary btn-lg">
                                                    <i class="fas fa-paper-plane me-2"></i>Submit Event for Approval
                                                </button>
                                            </div>
                                        </div>
                                    </form>
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
        let currentStep = 1;
        const totalSteps = 4;
        
        // Form validation
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
        
        // Category selection
        function selectCategory(category) {
            // Remove selected class from all category cards
            document.querySelectorAll('.category-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            event.target.closest('.category-card').classList.add('selected');
            
            // Check the radio button
            document.getElementById(category).checked = true;
            
            // Update preview
            updatePreview();
        }
        
        // Step navigation
        function nextStep() {
            if (validateCurrentStep()) {
                if (currentStep < totalSteps) {
                    // Hide current step
                    document.getElementById('step' + currentStep).classList.remove('active');
                    
                    // Update step indicator
                    document.getElementById('step-' + currentStep).classList.remove('active');
                    document.getElementById('step-' + currentStep).classList.add('completed');
                    
                    // Move to next step
                    currentStep++;
                    
                    // Show next step
                    document.getElementById('step' + currentStep).classList.add('active');
                    document.getElementById('step-' + currentStep).classList.add('active');
                    
                    // Update preview if on review step
                    if (currentStep === 4) {
                        updateReviewSummary();
                    }
                    
                    // Scroll to top
                    window.scrollTo(0, 0);
                }
            }
        }
        
        function prevStep() {
            if (currentStep > 1) {
                // Hide current step
                document.getElementById('step' + currentStep).classList.remove('active');
                document.getElementById('step-' + currentStep).classList.remove('active');
                
                // Move to previous step
                currentStep--;
                
                // Show previous step
                document.getElementById('step' + currentStep).classList.add('active');
                document.getElementById('step-' + currentStep).classList.add('active');
                document.getElementById('step-' + currentStep).classList.remove('completed');
                
                // Scroll to top
                window.scrollTo(0, 0);
            }
        }
        
        function validateCurrentStep() {
            const currentStepElement = document.getElementById('step' + currentStep);
            const inputs = currentStepElement.querySelectorAll('input[required], textarea[required], select[required]');
            let isValid = true;
            
            inputs.forEach(input => {
                if (!input.checkValidity()) {
                    isValid = false;
                    input.classList.add('is-invalid');
                } else {
                    input.classList.remove('is-invalid');
                }
            });
            
            // Special validation for radio buttons (category)
            if (currentStep === 2) {
                const categorySelected = document.querySelector('input[name="eventCategory"]:checked');
                if (!categorySelected) {
                    isValid = false;
                    alert('Please select an event category');
                }
            }
            
            return isValid;
        }
        
        function updatePreview() {
            const title = document.getElementById('eventTitle').value || 'Event Title';
            const date = document.getElementById('eventDate').value || 'Date';
            const time = document.getElementById('eventTime').value || 'Time';
            const location = document.getElementById('eventLocation').value || 'Location';
            const participants = document.getElementById('participantLimit').value || 'Unlimited';
            const fee = document.getElementById('registrationFee').value;
            const category = document.querySelector('input[name="eventCategory"]:checked');
            
            document.getElementById('preview-title').textContent = title;
            document.getElementById('preview-date').textContent = date;
            document.getElementById('preview-time').textContent = time;
            document.getElementById('preview-location').textContent = location;
            document.getElementById('preview-participants').textContent = participants + ' participants';
            
            if (fee && parseFloat(fee) > 0) {
                document.getElementById('preview-fee').textContent = 'RM ' + fee;
                document.getElementById('preview-fee').className = 'badge bg-warning text-dark';
            } else {
                document.getElementById('preview-fee').textContent = 'FREE';
                document.getElementById('preview-fee').className = 'badge bg-success';
            }
            
            if (category) {
                document.getElementById('preview-category').textContent = category.value.toUpperCase();
            }
        }
        
        function updateReviewSummary() {
            const title = document.getElementById('eventTitle').value;
            const date = document.getElementById('eventDate').value;
            const time = document.getElementById('eventTime').value;
            const location = document.getElementById('eventLocation').value;
            const description = document.getElementById('eventDescription').value;
            const participants = document.getElementById('participantLimit').value;
            const fee = document.getElementById('registrationFee').value;
            const category = document.querySelector('input[name="eventCategory"]:checked');
            
            document.getElementById('review-title').textContent = title;
            document.getElementById('review-datetime').textContent = date + ' at ' + time;
            document.getElementById('review-location').textContent = location;
            document.getElementById('review-description').textContent = description;
            document.getElementById('review-participants').textContent = participants || 'Unlimited';
            
            if (fee && parseFloat(fee) > 0) {
                document.getElementById('review-fee').textContent = 'RM ' + fee;
            } else {
                document.getElementById('review-fee').textContent = 'FREE';
            }
            
            if (category) {
                document.getElementById('review-category').textContent = category.value.charAt(0).toUpperCase() + category.value.slice(1);
            }
        }
        
        // Add event listeners for real-time preview updates
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = ['eventTitle', 'eventDate', 'eventTime', 'eventLocation', 'participantLimit', 'registrationFee'];
            
            inputs.forEach(inputId => {
                const element = document.getElementById(inputId);
                if (element) {
                    element.addEventListener('input', updatePreview);
                }
            });
            
            // Set minimum date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('eventDate').min = today;
            document.getElementById('registrationDeadline').min = today;
            
            // Auto-set registration deadline when event date changes
            document.getElementById('eventDate').addEventListener('change', function() {
                const eventDate = new Date(this.value);
                const regDeadline = new Date(eventDate);
                regDeadline.setDate(regDeadline.getDate() - 1);
                
                if (regDeadline >= new Date()) {
                    document.getElementById('registrationDeadline').value = regDeadline.toISOString().split('T')[0];
                }
            });
        });
        
        // Form submission with loading state
        document.getElementById('createEventForm').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Submitting...';
            submitBtn.disabled = true;
            
            // Re-enable if form validation fails
            setTimeout(function() {
                if (!submitBtn.form.checkValidity()) {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }
            }, 100);
        });
        
        // Smooth animations
        document.querySelectorAll('.form-step').forEach(step => {
            step.style.transition = 'opacity 0.3s ease-in-out';
        });
    </script>
</body>
</html>