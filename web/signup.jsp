<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }
        
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .form-control, .form-select {
            border-radius: 15px;
            border: 2px solid #e9ecef;
            padding: 12px 20px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .welcome-section {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border-radius: 20px 0 0 20px;
        }
        
        .logo-text {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        
        .role-card {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .role-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
        }
        
        .role-card.selected {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }
        
        .role-card input[type="radio"] {
            display: none;
        }
        
        .alert {
            border-radius: 15px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="card">
                    <div class="row g-0">
                        <!-- Welcome Section -->
                        <div class="col-lg-5 d-none d-lg-block">
                            <div class="welcome-section h-100 p-5 d-flex flex-column justify-content-center">
                                <div class="text-center">
                                    <i class="fas fa-university fa-4x mb-4"></i>
                                    <div class="logo-text">Join UiTM!</div>
                                    <p class="lead mb-4">
                                        Create your account to start exploring amazing campus activities and connect with fellow students.
                                    </p>
                                    
                                    <div class="mt-4">
                                        <h6 class="mb-3">Benefits of joining:</h6>
                                        <ul class="list-unstyled text-start">
                                            <li class="mb-2">
                                                <i class="fas fa-check-circle me-2"></i>
                                                Access to exclusive events
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-check-circle me-2"></i>
                                                Easy event registration
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-check-circle me-2"></i>
                                                Digital certificates
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-check-circle me-2"></i>
                                                Network with peers
                                            </li>
                                        </ul>
                                    </div>
                                    
                                    <div class="mt-4">
                                        <h6 class="mb-3">Already have an account?</h6>
                                        <a href="signin.jsp" class="btn btn-outline-light btn-lg">
                                            <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Registration Form Section -->
                        <div class="col-lg-7">
                            <div class="p-5">
                                <div class="text-center mb-4">
                                    <h2 class="fw-bold text-primary">Create Account</h2>
                                    <p class="text-muted">Fill in your details to get started</p>
                                </div>
                                
                                <!-- Display Messages -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i>
                                        ${error}
                                    </div>
                                </c:if>
                                
                                <!-- Registration Form -->
                                <form action="controller" method="post" class="needs-validation" novalidate id="signupForm">
                                    <input type="hidden" name="action" value="signup">
                                    
                                    <!-- Role Selection -->
                                    <div class="mb-4">
                                        <label class="form-label">
                                            <i class="fas fa-user-tag me-2"></i>Choose Your Role
                                        </label>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <div class="role-card" onclick="selectRole('student')">
                                                    <input type="radio" name="role" value="student" id="student" required>
                                                    <i class="fas fa-graduation-cap fa-2x text-primary mb-2"></i>
                                                    <h6>Student</h6>
                                                    <small class="text-muted">Register for events and activities</small>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <div class="role-card" onclick="selectRole('organization')">
                                                    <input type="radio" name="role" value="organization" id="organization" required>
                                                    <i class="fas fa-users fa-2x text-success mb-2"></i>
                                                    <h6>Organization</h6>
                                                    <small class="text-muted">Create and manage events</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Personal Information -->
                                    <div class="row g-3 mb-3">
                                        <div class="col-12">
                                            <label for="name" class="form-label">
                                                <i class="fas fa-user me-2"></i>Full Name
                                            </label>
                                            <input type="text" class="form-control" id="name" name="name" 
                                                   placeholder="Enter your full name" required>
                                            <div class="invalid-feedback">
                                                Please enter your full name.
                                            </div>
                                        </div>
                                        
                                        <div class="col-12">
                                            <label for="email" class="form-label">
                                                <i class="fas fa-envelope me-2"></i>Email Address
                                            </label>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   placeholder="Enter your email address" required>
                                            <div class="invalid-feedback">
                                                Please enter a valid email address.
                                            </div>
                                            <div class="form-text">Use your UiTM email for verification</div>
                                        </div>
                                        
                                        <div class="col-12">
                                            <label for="phone" class="form-label">
                                                <i class="fas fa-phone me-2"></i>Phone Number
                                            </label>
                                            <input type="tel" class="form-control" id="phone" name="phone" 
                                                   placeholder="Enter your phone number" required>
                                            <div class="invalid-feedback">
                                                Please enter your phone number.
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Security Settings -->
                                    <div class="row g-3 mb-3">
                                        <div class="col-12">
                                            <label for="password" class="form-label">
                                                <i class="fas fa-lock me-2"></i>Password
                                            </label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="password" name="password" 
                                                       placeholder="Create a strong password" required minlength="6">
                                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                            <div class="invalid-feedback">
                                                Password must be at least 6 characters long.
                                            </div>
                                            <div class="form-text">Use at least 6 characters with a mix of letters and numbers</div>
                                        </div>
                                        
                                        <div class="col-12">
                                            <label for="confirmPassword" class="form-label">
                                                <i class="fas fa-lock me-2"></i>Confirm Password
                                            </label>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                                   placeholder="Confirm your password" required>
                                            <div class="invalid-feedback">
                                                Passwords do not match.
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-check mb-4">
                                        <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                        <label class="form-check-label" for="agreeTerms">
                                            I agree to the <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms of Service</a> 
                                            and <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Privacy Policy</a>
                                        </label>
                                        <div class="invalid-feedback">
                                            You must agree to the terms and conditions.
                                        </div>
                                    </div>
                                    
                                    <div class="d-grid mb-3">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-user-plus me-2"></i>Create Account
                                        </button>
                                    </div>
                                </form>
                                
                                <!-- Additional Links -->
                                <div class="text-center mt-4">
                                    <p class="text-muted mb-2">Already have an account?</p>
                                    <a href="signin.jsp" class="btn btn-outline-primary">
                                        <i class="fas fa-sign-in-alt me-2"></i>Sign In Instead
                                    </a>
                                </div>
                                
                                <div class="text-center mt-4">
                                    <a href="index.jsp" class="text-decoration-none text-muted">
                                        <i class="fas fa-arrow-left me-2"></i>Back to Home
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Terms of Service Modal -->
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-file-contract me-2"></i>Terms of Service
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Acceptance of Terms</h6>
                    <p>By accessing and using the UiTM Activity Management System, you accept and agree to be bound by the terms and provision of this agreement.</p>
                    
                    <h6>2. Use License</h6>
                    <p>Permission is granted to temporarily access the system for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.</p>
                    
                    <h6>3. User Account</h6>
                    <p>You are responsible for safeguarding your account credentials and for all activities that occur under your account.</p>
                    
                    <h6>4. Prohibited Uses</h6>
                    <p>You may not use the system for any unlawful purpose or to solicit others to perform unlawful acts.</p>
                    
                    <h6>5. Contact Information</h6>
                    <p>For questions about these Terms of Service, please contact us at admin@uitm.edu.my</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Privacy Policy Modal -->
    <div class="modal fade" id="privacyModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-shield-alt me-2"></i>Privacy Policy
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>Information We Collect</h6>
                    <p>We collect information you provide directly to us, such as when you create an account, register for events, or contact us.</p>
                    
                    <h6>How We Use Your Information</h6>
                    <p>We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.</p>
                    
                    <h6>Information Sharing</h6>
                    <p>We do not share your personal information with third parties except as described in this policy or with your consent.</p>
                    
                    <h6>Data Security</h6>
                    <p>We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.</p>
                    
                    <h6>Contact Us</h6>
                    <p>If you have questions about this Privacy Policy, please contact us at admin@uitm.edu.my</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
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
        
        // Role selection
        function selectRole(role) {
            // Remove selected class from all role cards
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            event.target.closest('.role-card').classList.add('selected');
            
            // Check the radio button
            document.getElementById(role).checked = true;
        }
        
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Real-time password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.classList.add('is-invalid');
                this.setCustomValidity('Passwords do not match');
            } else {
                this.classList.remove('is-invalid');
                this.setCustomValidity('');
            }
        });
        
        // Auto-hide alerts after 5 seconds
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
        
        // Add loading state to submit button
        document.getElementById('signupForm').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating Account...';
            submitBtn.disabled = true;
            
            // Re-enable if form validation fails
            setTimeout(function() {
                if (!submitBtn.form.checkValidity()) {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }
            }, 100);
        });
    </script>
</body>
</html>