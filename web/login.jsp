<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            min-height: 500px;
        }
        
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 40px;
            text-align: center;
            position: relative;
        }
        
        .login-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="rgba(255,255,255,0.1)"><polygon points="1000,100 1000,0 0,100"/></svg>') no-repeat;
            background-size: cover;
        }
        
        .login-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }
        
        .login-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }
        
        .login-form {
            padding: 50px 40px;
        }
        
        .form-floating {
            margin-bottom: 20px;
        }
        
        .form-floating .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            height: 60px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-floating .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .btn-login {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-login:active {
            transform: translateY(-1px);
        }
        
        .alert {
            border-radius: 15px;
            border: none;
            margin-bottom: 25px;
        }
        
        .alert-danger {
            background: linear-gradient(45deg, #ff6b6b, #ee5a6f);
            color: white;
        }
        
        .alert-success {
            background: linear-gradient(45deg, #51cf66, #40c057);
            color: white;
        }
        
        .alert-info {
            background: linear-gradient(45deg, #74c0fc, #339af0);
            color: white;
        }
        
        .forgot-password {
            text-align: center;
            margin-top: 30px;
        }
        
        .forgot-password a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .forgot-password a:hover {
            color: #764ba2;
        }
        
        .demo-accounts {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-top: 30px;
        }
        
        .demo-accounts h6 {
            color: #495057;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .demo-account {
            background: white;
            border-radius: 10px;
            padding: 10px 15px;
            margin-bottom: 10px;
            border-left: 4px solid #667eea;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .demo-account:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .demo-account small {
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .login-container {
                margin: 20px;
                border-radius: 15px;
            }
            
            .login-header {
                padding: 40px 25px;
            }
            
            .login-header h1 {
                font-size: 2rem;
            }
            
            .login-form {
                padding: 30px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="login-container">
                    <div class="row g-0">
                        <!-- Header Section -->
                        <div class="col-lg-5">
                            <div class="login-header">
                                <i class="fas fa-university fa-3x mb-3"></i>
                                <h1>UiTM Activity</h1>
                                <p>Campus Event Management System</p>
                                <div class="mt-4">
                                    <i class="fas fa-check-circle me-2"></i>Event Management<br>
                                    <i class="fas fa-check-circle me-2"></i>Venue Booking<br>
                                    <i class="fas fa-check-circle me-2"></i>Resource Management<br>
                                    <i class="fas fa-check-circle me-2"></i>Analytics & Reports
                                </div>
                            </div>
                        </div>
                        
                        <!-- Login Form Section -->
                        <div class="col-lg-7">
                            <div class="login-form">
                                <h3 class="text-center mb-4">
                                    <i class="fas fa-sign-in-alt me-2 text-primary"></i>
                                    Welcome Back
                                </h3>
                                
                                <!-- Display Messages -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        ${error}
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty param.message}">
                                    <div class="alert alert-info" role="alert">
                                        <i class="fas fa-info-circle me-2"></i>
                                        ${param.message}
                                    </div>
                                </c:if>
                                
                                <!-- Login Form -->
                                <form action="${pageContext.request.contextPath}/controller" method="post" id="loginForm">
                                    <input type="hidden" name="action" value="login">
                                    
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="email" 
                                               placeholder="name@example.com" required>
                                        <label for="email">
                                            <i class="fas fa-envelope me-2"></i>Email Address
                                        </label>
                                    </div>
                                    
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Password" required>
                                        <label for="password">
                                            <i class="fas fa-lock me-2"></i>Password
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="rememberMe">
                                        <label class="form-check-label" for="rememberMe">
                                            Remember me
                                        </label>
                                    </div>
                                    
                                    <button type="submit" class="btn-login" id="loginBtn">
                                        <i class="fas fa-sign-in-alt me-2"></i>
                                        Sign In
                                    </button>
                                </form>
                                
                                <div class="forgot-password">
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                                        <i class="fas fa-question-circle me-1"></i>
                                        Forgot your password?
                                    </a>
                                </div>
                                
                                <!-- Demo Accounts -->
                                <div class="demo-accounts">
                                    <h6><i class="fas fa-users me-2"></i>Demo Accounts</h6>
                                    
                                    <div class="demo-account" onclick="fillDemoAccount('compsoc@uitm.edu.my', 'password123')">
                                        <strong>Organization</strong>
                                        <br><small>Computer Society</small>
                                    </div>
                                    
                                    <div class="demo-account" onclick="fillDemoAccount('ahmad@student.uitm.edu.my', 'password123')">
                                        <strong>Student</strong>
                                        <br><small>Ahmad Ali</small>
                                    </div>
                                    
                                    <div class="demo-account" onclick="fillDemoAccount('rahman@uitm.edu.my', 'password123')">
                                        <strong>Staff</strong>
                                        <br><small>Dr. Rahman</small>
                                    </div>
                                    
                                    <div class="demo-account" onclick="fillDemoAccount('admin@uitm.edu.my', 'password123')">
                                        <strong>Admin</strong>
                                        <br><small>System Administrator</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Forgot Password Modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Reset Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Please contact your system administrator to reset your password.</p>
                    <div class="alert alert-info">
                        <strong>Contact Information:</strong><br>
                        Email: admin@uitm.edu.my<br>
                        Phone: +60 3-xxxx xxxx
                    </div>
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
        // Fill demo account credentials
        function fillDemoAccount(email, password) {
            document.getElementById('email').value = email;
            document.getElementById('password').value = password;
            
            // Add visual feedback
            const emailField = document.getElementById('email');
            const passwordField = document.getElementById('password');
            
            emailField.style.borderColor = '#28a745';
            passwordField.style.borderColor = '#28a745';
            
            setTimeout(() => {
                emailField.style.borderColor = '';
                passwordField.style.borderColor = '';
            }, 2000);
        }
        
        // Form submission with loading state
        document.getElementById('loginForm').addEventListener('submit', function() {
            const loginBtn = document.getElementById('loginBtn');
            const originalText = loginBtn.innerHTML;
            
            loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing In...';
            loginBtn.disabled = true;
            
            // Re-enable if there's an error (page doesn't redirect)
            setTimeout(function() {
                loginBtn.innerHTML = originalText;
                loginBtn.disabled = false;
            }, 3000);
        });
        
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });
        
        // Enter key support for demo accounts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && e.ctrlKey) {
                // Ctrl+Enter to fill organization demo account
                fillDemoAccount('compsoc@uitm.edu.my', 'password123');
            }
        });
        
        // Password visibility toggle
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Add floating label animation
        document.querySelectorAll('.form-floating .form-control').forEach(function(input) {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (this.value === '') {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
    </script>
</body>
</html>