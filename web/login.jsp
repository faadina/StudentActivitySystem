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
            background:white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }

        .auth-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            min-height: 500px;
        }

        .auth-container .col-lg-5 {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .auth-header {
            background: transparent;
            color: white;
            padding: 60px 40px;
            text-align: center;
            position: relative;
        }

        .auth-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }

        .auth-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
            margin-bottom: 30px;
        }

        .auth-features {
            text-align: left;
            margin-top: 20px;
        }

        .auth-features div {
            margin-bottom: 10px;
            font-size: 1rem;
            opacity: 0.9;
        }

        .auth-form {
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

        .btn-auth {
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

        .btn-auth:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-auth:active {
            transform: translateY(-1px);
        }

        .btn-auth:disabled {
            opacity: 0.7;
            transform: none;
        }

        .form-check {
            margin-bottom: 15px;
        }

        .form-check-label {
            font-size: 0.95rem;
            color: #6c757d;
        }

        .demo-accounts {
            margin-top: 25px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
            border: 1px solid #e9ecef;
        }

        .demo-accounts strong {
            color: #495057;
            font-size: 0.95rem;
            margin-bottom: 15px;
            display: block;
        }

        .demo-account {
            padding: 12px 15px;
            background: white;
            border-left: 4px solid #667eea;
            margin-bottom: 10px;
            border-radius: 8px;
            transition: all 0.2s ease;
            cursor: pointer;
            font-size: 0.9rem;
            color: #495057;
            border: 1px solid #e9ecef;
        }

        .demo-account:hover {
            background: #f8f9fa;
            transform: translateX(5px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .auth-links {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            font-size: 0.9rem;
        }

        .auth-links a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .auth-links a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .alert {
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .auth-container {
                margin: 10px;
                border-radius: 15px;
                min-height: auto;
            }
            
            .auth-header {
                padding: 40px 25px;
            }
            
            .auth-header h1 {
                font-size: 2rem;
            }
            
            .auth-form {
                padding: 30px 25px;
            }

            .auth-container .row {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="row g-0">
            <!-- Left header/info -->
            <div class="col-lg-5">
                <div class="auth-header">
                    <i class="fas fa-sign-in-alt fa-3x mb-3"></i>
                    <h1>Welcome Back</h1>
                    <p>Sign in to your account</p>
                    <div class="auth-features">
                        <div><i class="fas fa-check-circle me-2"></i>Event Management</div>
                        <div><i class="fas fa-check-circle me-2"></i>Venue Booking</div>
                        <div><i class="fas fa-check-circle me-2"></i>Resource Access</div>
                        <div><i class="fas fa-check-circle me-2"></i>Analytics & Reports</div>
                    </div>
                </div>
            </div>
            
            <!-- Login form -->
            <div class="col-lg-7">
                <div class="auth-form">
                    <h3 class="text-center mb-4 text-primary">
                        <i class="fas fa-sign-in-alt me-2"></i>Sign In
                    </h3>

                    <!-- Error/Success messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty param.message}">
                        <div class="alert alert-info" role="alert">
                            <i class="fas fa-info-circle me-2"></i>${param.message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/controller" method="post" id="loginForm">
                        <input type="hidden" name="action" value="login">

                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                            <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                        </div>

                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember me
                            </label>
                        </div>

                        <button type="submit" class="btn-auth" id="loginBtn">
                            <i class="fas fa-sign-in-alt me-2"></i>Sign In
                        </button>
                    </form>

                    <div class="demo-accounts">
                        <strong><i class="fas fa-users me-2"></i>Quick Login (Demo Accounts):</strong>
                        <div class="demo-account" onclick="fillDemoAccount('compsoc@uitm.edu.my', 'password123')">
                            <i class="fas fa-building me-2"></i>Organization - Computer Society
                        </div>
                        <div class="demo-account" onclick="fillDemoAccount('ahmad@student.uitm.edu.my', 'password123')">
                            <i class="fas fa-user-graduate me-2"></i>Student - Ahmad Ali
                        </div>
                        <div class="demo-account" onclick="fillDemoAccount('rahman@uitm.edu.my', 'password123')">
                            <i class="fas fa-chalkboard-teacher me-2"></i>Staff - Dr. Rahman
                        </div>
                        <div class="demo-account" onclick="fillDemoAccount('admin@uitm.edu.my', 'password123')">
                            <i class="fas fa-user-shield me-2"></i>Admin - System Admin
                        </div>
                    </div>

                    <div class="auth-links">
                        <a href="${pageContext.request.contextPath}/signup.jsp">
                            <i class="fas fa-user-plus me-1"></i>Create Account
                        </a>
                        <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                            <i class="fas fa-key me-1"></i>Forgot Password?
                        </a>
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
                    <h5 class="modal-title">
                        <i class="fas fa-key me-2"></i>Reset Password
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Please contact your system administrator to reset your password.</p>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Contact Information:</strong><br>
                        Email: admin@uitm.edu.my<br>
                        Phone: +60 3-xxxx xxxx<br>
                        Office Hours: Mon-Fri, 8:00 AM - 5:00 PM
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Close
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function fillDemoAccount(email, password) {
            document.getElementById('email').value = email;
            document.getElementById('password').value = password;
            
            // Add visual feedback
            const emailField = document.getElementById('email');
            const passwordField = document.getElementById('password');
            
            emailField.style.background = '#e8f5e8';
            passwordField.style.background = '#e8f5e8';
            
            setTimeout(() => {
                emailField.style.background = '';
                passwordField.style.background = '';
            }, 1000);
        }

        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const loginBtn = document.getElementById('loginBtn');
            loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing In...';
            loginBtn.disabled = true;
        });

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.3s ease';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });

        // Add smooth transitions for demo accounts
        document.querySelectorAll('.demo-account').forEach(account => {
            account.addEventListener('click', function() {
                this.style.transform = 'translateX(10px)';
                setTimeout(() => {
                    this.style.transform = 'translateX(5px)';
                }, 150);
            });
        });
    </script>
</body>
</html>