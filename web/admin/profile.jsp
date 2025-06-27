<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .profile-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .form-label { font-weight: 600; color: #2c3e50; }
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 12px 20px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .form-control:disabled { background-color: #f8f9fa; }
        .btn-update {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-update:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            color: white;
        }
        .section-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }
        .strength-bar { height: 4px; border-radius: 2px; background: #e9ecef; overflow: hidden; }
        .strength-fill { height: 100%; transition: all 0.3s ease; border-radius: 2px; }
        .strength-weak { background: #e74c3c; width: 33%; }
        .strength-medium { background: #f39c12; width: 66%; }
        .strength-strong { background: #27ae60; width: 100%; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                 <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="profile"/>
                </jsp:include>
            </div>
            
            <div class="col-md-10 main-content">
                <div class="p-4">
                    <h2 class="mb-4">My Profile</h2>
                    
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">${sessionScope.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">${sessionScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <form id="profileForm" method="POST" action="admin">
                        <input type="hidden" name="action" value="updateProfile">
                        
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="profile-card h-100">
                                    <h4 class="section-title"><i class="fas fa-user-edit me-2"></i>Edit Information</h4>
                                    <div class="mb-3">
                                        <label class="form-label">User ID</label>
                                        <input type="text" class="form-control" value="${user.userID}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email Address</label>
                                        <input type="email" class="form-control" value="${user.userEmail}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="userPhoneNo" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control" id="userPhoneNo" name="userPhoneNo" value="${user.userPhoneNo}">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-6">
                                <div class="profile-card h-100">
                                    <h4 class="section-title"><i class="fas fa-lock me-2"></i>Change Password</h4>
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <input type="password" class="form-control" name="currentPassword" id="currentPassword" placeholder="Enter current password">
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <input type="password" class="form-control" name="newPassword" id="newPassword" placeholder="Enter new password">
                                        <div class="password-strength mt-2">
                                            <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                                            <small id="strengthText" class="form-text text-muted"></small>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm new password">
                                        <div id="passwordMatch" class="form-text mt-1"></div>
                                    </div>
                                    <p class="form-text text-muted small">Leave password fields blank if you don't want to change it.</p>
                                </div>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn-update" id="submitBtn">
                                <i class="fas fa-save me-2"></i>Save All Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const newPasswordField = document.getElementById('newPassword');
        const confirmPasswordField = document.getElementById('confirmPassword');
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');
        const matchDiv = document.getElementById('passwordMatch');

        // Semak kekuatan kata laluan
        newPasswordField.addEventListener('input', function() {
            const password = this.value;
            if (password.length === 0) {
                strengthFill.className = 'strength-fill';
                strengthText.textContent = '';
                return;
            }
            let strength = 0;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            
            if (strength <= 2) {
                strengthFill.className = 'strength-fill strength-weak';
                strengthText.textContent = 'Weak';
                strengthText.style.color = '#e74c3c';
            } else if (strength === 3) {
                strengthFill.className = 'strength-fill strength-medium';
                strengthText.textContent = 'Medium';
                strengthText.style.color = '#f39c12';
            } else {
                strengthFill.className = 'strength-fill strength-strong';
                strengthText.textContent = 'Strong';
                strengthText.style.color = '#27ae60';
            }
        });

        // Semak jika kata laluan sepadan
        function verifyPasswordMatch() {
            if (newPasswordField.value || confirmPasswordField.value) {
                if (newPasswordField.value === confirmPasswordField.value) {
                    matchDiv.textContent = '✓ Passwords match';
                    matchDiv.style.color = '#27ae60';
                } else {
                    matchDiv.textContent = '✗ Passwords do not match';
                    matchDiv.style.color = '#e74c3c';
                }
            } else {
                 matchDiv.textContent = '';
            }
        }
        newPasswordField.addEventListener('input', verifyPasswordMatch);
        confirmPasswordField.addEventListener('input', verifyPasswordMatch);

        // Pengesahan Borang
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            if (newPasswordField.value !== confirmPasswordField.value) {
                e.preventDefault();
                alert('New passwords do not match. Please check again.');
            }
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';
            submitBtn.disabled = true;
        });
    </script>
</body>
</html>