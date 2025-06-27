<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organization Profile - UiTM Activity System</title>
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
        .profile-header {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .profile-avatar {
            position: relative;
            z-index: 2;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 3rem;
            border: 5px solid white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-info {
            position: relative;
            z-index: 2;
        }
        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .profile-role {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 20px;
        }
        .profile-stats {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 30px;
        }
        .stat-item {
            text-align: center;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
        }
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .profile-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 15px 20px;
            transition: all 0.3s ease;
            font-size: 1rem;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .form-control:disabled {
            background-color: #f8f9fa;
            color: #6c757d;
        }
        .input-group-text {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 15px 0 0 15px;
            border-right: none;
            color: #6c757d;
        }
        .input-group .form-control {
            border-left: none;
            border-radius: 0 15px 15px 0;
        }
        .btn-update {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        .btn-update:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3);
            color: white;
        }
        .btn-cancel {
            background: linear-gradient(45deg, #6c757d, #495057);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        .btn-cancel:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(108, 117, 125, 0.3);
            color: white;
        }
        .section-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }
        .activity-summary {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
        .achievement-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        .badge-item {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .badge-item.gold {
            background: linear-gradient(45deg, #f1c40f, #f39c12);
        }
        .badge-item.silver {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
        }
        .password-strength {
            margin-top: 10px;
        }
        .strength-bar {
            height: 6px;
            border-radius: 3px;
            background: #e9ecef;
            overflow: hidden;
        }
        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 3px;
        }
        .strength-weak { background: #e74c3c; width: 33%; }
        .strength-medium { background: #f39c12; width: 66%; }
        .strength-strong { background: #27ae60; width: 100%; }
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
                                    <i class="fas fa-user-cog me-2 text-primary"></i>
                                    Organization Profile
                                </h2>
                                <p class="text-muted mb-0">Manage your organization information and settings</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <!-- Profile Header -->
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-university"></i>
                        </div>
                        <div class="profile-info">
                            <h1 class="profile-name">${user.userName}</h1>
                            <p class="profile-role">
                                <i class="fas fa-building me-2"></i>
                                Organization - ${user.userID}
                            </p>
                            <p class="text-muted">
                                <i class="fas fa-calendar me-2"></i>
                                Member since <fmt:formatDate value="${user.createdAt}" pattern="MMMM yyyy"/>
                            </p>
                            
                            <div class="profile-stats">
                                <div class="stat-item">
                                    <div class="stat-number">${totalEvents}</div>
                                    <div class="stat-label">Events Created</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${certificatesEarned}</div>
                                    <div class="stat-label">Active Events</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">4.5</div>
                                    <div class="stat-label">Avg Rating</div>
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
                    
                    <!-- Activity Summary -->
                    <div class="profile-card">
                        <h4 class="section-title">
                            <i class="fas fa-chart-line me-2"></i>Organization Summary
                        </h4>
                        <div class="activity-summary">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6><i class="fas fa-calendar-check me-2"></i>Recent Activities</h6>
                                    <ul class="list-unstyled">
                                        <li class="mb-2">
                                            <i class="fas fa-dot-circle me-2 text-success"></i>
                                            Created "Tech Innovation Workshop"
                                        </li>
                                        <li class="mb-2">
                                            <i class="fas fa-dot-circle me-2 text-primary"></i>
                                            Booked Computer Lab A for event
                                        </li>
                                        <li class="mb-2">
                                            <i class="fas fa-dot-circle me-2 text-warning"></i>
                                            Requested projector equipment
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6><i class="fas fa-award me-2"></i>Achievements</h6>
                                    <div class="achievement-badges">
                                        <span class="badge-item gold">
                                            <i class="fas fa-trophy me-1"></i>Event Organizer
                                        </span>
                                        <span class="badge-item silver">
                                            <i class="fas fa-calendar me-1"></i>Active Organization
                                        </span>
                                        <span class="badge-item">
                                            <i class="fas fa-users me-1"></i>Community Builder
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Profile Information -->
                    <div class="profile-card">
                        <h4 class="section-title">
                            <i class="fas fa-edit me-2"></i>Organization Information
                        </h4>
                        
                        <form id="profileForm" method="POST" action="${pageContext.request.contextPath}/organization">
                            <input type="hidden" name="action" value="updateProfile">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="userID" class="form-label">Organization ID</label>
                                        <input type="text" class="form-control" id="userID" value="${user.userID}" disabled>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="userRole" class="form-label">Role</label>
                                        <input type="text" class="form-control" id="userRole" value="${user.userRole}" disabled>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="userName" class="form-label">Organization Name</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-building"></i>
                                    </span>
                                    <input type="text" class="form-control" name="fullName" id="userName" 
                                           value="${user.userName}" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="userEmail" class="form-label">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                    <input type="email" class="form-control" id="userEmail" value="${user.userEmail}" disabled>
                                </div>
                                <small class="form-text text-muted">Email cannot be changed. Contact admin if needed.</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="userPhoneNo" class="form-label">Contact Number</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-phone"></i>
                                    </span>
                                    <input type="tel" class="form-control" name="userPhoneNo" id="userPhoneNo" 
                                           value="${user.userPhoneNo}" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="submit" class="btn-update w-100">
                                        <i class="fas fa-save me-2"></i>Update Profile
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button type="reset" class="btn-cancel w-100">
                                        <i class="fas fa-undo me-2"></i>Reset Changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Change Password -->
                    <div class="profile-card">
                        <h4 class="section-title">
                            <i class="fas fa-lock me-2"></i>Change Password
                        </h4>
                        
                        <form id="passwordForm" method="POST" action="${pageContext.request.contextPath}/organization">
                            <input type="hidden" name="action" value="updateProfile">
                            <input type="hidden" name="fullName" value="${user.userName}">
                            <input type="hidden" name="userPhoneNo" value="${user.userPhoneNo}">
                            
                            <div class="form-group">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                    <input type="password" class="form-control" name="currentPassword" id="currentPassword" 
                                           placeholder="Enter your current password">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-key"></i>
                                    </span>
                                    <input type="password" class="form-control" name="newPassword" id="newPassword" 
                                           placeholder="Enter your new password">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength">
                                    <div class="strength-bar">
                                        <div class="strength-fill" id="strengthFill"></div>
                                    </div>
                                    <small class="text-muted" id="strengthText">Password strength will appear here</small>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-key"></i>
                                    </span>
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           placeholder="Confirm your new password">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div id="passwordMatch" class="form-text"></div>
                            </div>
                            
                            <button type="submit" class="btn-update w-100" id="changePasswordBtn" disabled>
                                <i class="fas fa-lock me-2"></i>Change Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Toggle password visibility
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = event.currentTarget.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Password strength checker
        function checkPasswordStrength(password) {
            let strength = 0;
            let feedback = [];
            
            if (password.length >= 8) strength += 1;
            else feedback.push('at least 8 characters');
            
            if (/[a-z]/.test(password)) strength += 1;
            else feedback.push('lowercase letter');
            
            if (/[A-Z]/.test(password)) strength += 1;
            else feedback.push('uppercase letter');
            
            if (/[0-9]/.test(password)) strength += 1;
            else feedback.push('number');
            
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            else feedback.push('special character');
            
            return { strength, feedback };
        }
        
        // Update password strength display
        function updatePasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            
            if (password.length === 0) {
                strengthFill.className = 'strength-fill';
                strengthText.textContent = 'Password strength will appear here';
                return;
            }
            
            const { strength, feedback } = checkPasswordStrength(password);
            
            if (strength <= 2) {
                strengthFill.className = 'strength-fill strength-weak';
                strengthText.textContent = 'Weak - Add: ' + feedback.slice(0, 2).join(', ');
                strengthText.style.color = '#e74c3c';
            } else if (strength <= 4) {
                strengthFill.className = 'strength-fill strength-medium';
                strengthText.textContent = 'Medium - Add: ' + feedback.join(', ');
                strengthText.style.color = '#f39c12';
            } else {
                strengthFill.className = 'strength-fill strength-strong';
                strengthText.textContent = 'Strong password';
                strengthText.style.color = '#27ae60';
            }
        }
        
        // Check password match
        function checkPasswordMatch() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            const changeBtn = document.getElementById('changePasswordBtn');
            
            if (confirmPassword.length === 0) {
                matchDiv.textContent = '';
                changeBtn.disabled = true;
                return;
            }
            
            if (newPassword === confirmPassword) {
                matchDiv.textContent = '✓ Passwords match';
                matchDiv.style.color = '#27ae60';
                changeBtn.disabled = false;
            } else {
                matchDiv.textContent = '✗ Passwords do not match';
                matchDiv.style.color = '#e74c3c';
                changeBtn.disabled = true;
            }
        }
        
        // Event listeners
        document.getElementById('newPassword').addEventListener('input', updatePasswordStrength);
        document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);
        document.getElementById('newPassword').addEventListener('input', checkPasswordMatch);
        
        // Form validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (!currentPassword || !newPassword || !confirmPassword) {
                e.preventDefault();
                alert('Please fill in all password fields');
                return;
            }
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('New passwords do not match');
                return;
            }
            
            const { strength } = checkPasswordStrength(newPassword);
            if (strength < 3) {
                e.preventDefault();
                alert('Password is too weak. Please use a stronger password.');
                return;
            }
            
            // Add loading state
            const submitBtn = document.getElementById('changePasswordBtn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Changing Password...';
            submitBtn.disabled = true;
        });
        
        // Profile form submission
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const submitBtn = event.target.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Updating...';
            submitBtn.disabled = true;
        });
        
        // Auto-hide alerts
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</body>
</html>