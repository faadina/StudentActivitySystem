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
        body { background-color: #f4f7f6; }
        .card { 
            border-radius: 12px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            border: none; 
            margin-bottom: 20px;
        }
        .profile-header {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 2.5rem;
            border: 4px solid white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .profile-name {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: #2c3e50;
        }
        .profile-meta {
            color: #6c757d;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
        }
        .input-group-text {
            border-radius: 8px 0 0 8px;
        }
        .btn-primary {
            padding: 10px 25px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="organizationSidebar.jsp" />
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10" style="padding: 2rem;">
                <h2 class="mb-4">
                    <i class="fas fa-building me-2"></i>Organization Profile
                </h2>

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
                
                <div class="row">
                    <div class="col-lg-7">
                        <!-- Organization Information -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="section-title">
                                    <i class="fas fa-info-circle me-2"></i>Organization Information
                                </h5>
                                
                                <form id="profileForm" method="POST" action="${pageContext.request.contextPath}/organization">
                                    <input type="hidden" name="action" value="updateProfile">
                                    
                                    <div class="mb-3">
                                        <label for="userID" class="form-label">Organization ID</label>
                                        <input type="text" class="form-control" id="userID" value="${user.userID}" disabled>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">Organization Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-building"></i>
                                            </span>
                                            <input type="text" class="form-control" name="fullName" id="userName" 
                                                   value="${user.userName}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="userEmail" class="form-label">Email Address</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                            <input type="email" class="form-control" id="userEmail" value="${user.userEmail}" disabled>
                                        </div>
                                        <small class="form-text text-muted">Email cannot be changed. Contact admin if needed.</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="userPhoneNo" class="form-label">Contact Number</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                            <input type="tel" class="form-control" name="userPhoneNo" id="userPhoneNo" 
                                                   value="${user.userPhoneNo}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Save Changes
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-5">
                        <!-- Change Password -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="section-title">
                                    <i class="fas fa-lock me-2"></i>Change Password
                                </h5>
                                
                                <form id="passwordForm" method="POST" action="${pageContext.request.contextPath}/organization">
                                    <input type="hidden" name="action" value="updateProfile">
                                    <input type="hidden" name="fullName" value="${user.userName}">
                                    <input type="hidden" name="userPhoneNo" value="${user.userPhoneNo}">
                                    
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" name="currentPassword" id="currentPassword" 
                                                   placeholder="Enter current password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" name="newPassword" id="newPassword" 
                                                   placeholder="Enter new password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <small class="form-text text-muted">Minimum 8 characters with uppercase, lowercase, number and special character</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="confirmPassword" 
                                                   placeholder="Confirm new password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div id="passwordMatch" class="form-text"></div>
                                    </div>
                                    
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary" id="changePasswordBtn">
                                            <i class="fas fa-lock me-2"></i>Change Password
                                        </button>
                                    </div>
                                </form>
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
        
        // Check password match
        function checkPasswordMatch() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            
            if (confirmPassword.length === 0) {
                matchDiv.textContent = '';
                return;
            }
            
            if (newPassword === confirmPassword) {
                matchDiv.textContent = '✓ Passwords match';
                matchDiv.style.color = '#28a745';
            } else {
                matchDiv.textContent = '✗ Passwords do not match';
                matchDiv.style.color = '#dc3545';
            }
        }
        
        // Form validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (currentPassword || newPassword || confirmPassword) {
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
                
                if (newPassword.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long');
                    return;
                }
                
                // Add loading state
                const submitBtn = document.getElementById('changePasswordBtn');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Changing...';
                submitBtn.disabled = true;
            }
        });
        
        // Profile form submission
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const submitBtn = event.target.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';
            submitBtn.disabled = true;
        });
        
        // Event listeners
        document.getElementById('newPassword').addEventListener('input', checkPasswordMatch);
        document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);
    </script>
</body>
</html>