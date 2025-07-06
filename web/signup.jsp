<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            background: white;
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

        .auth-links {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95rem;
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

        .password-requirements {
            margin-top: 10px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #667eea;
            font-size: 0.85rem;
        }

        .password-requirements h6 {
            color: #495057;
            margin-bottom: 10px;
            font-size: 0.9rem;
        }

        .password-requirements ul {
            margin: 0;
            padding-left: 20px;
            color: #6c757d;
        }

        .role-info {
            margin-top: 15px;
            padding: 12px 15px;
            background: #e3f2fd;
            border-radius: 10px;
            border-left: 4px solid #2196f3;
            font-size: 0.9rem;
            color: #1565c0;
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
                    <i class="fas fa-user-plus fa-3x mb-3"></i>
                    <h1>Join UiTM</h1>
                    <p>Create your student account</p>
                    <div class="auth-features">
                        <div><i class="fas fa-check-circle me-2"></i>Easy Registration</div>
                        <div><i class="fas fa-check-circle me-2"></i>Secure Access</div>
                        <div><i class="fas fa-check-circle me-2"></i>Event Participation</div>
                        <div><i class="fas fa-check-circle me-2"></i>Resource Booking</div>
                    </div>
                </div>
            </div>
            
            <!-- Signup form -->
            <div class="col-lg-7">
                <div class="auth-form">
                    <h3 class="text-center mb-4 text-primary">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </h3>

                    <!-- Error message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/controller" method="post" id="signupForm">
                        <input type="hidden" name="action" value="signup">
                        <input type="hidden" name="userRole" value="student">

                        <div class="form-floating">
                            <input type="text" class="form-control" id="userName" name="userName" placeholder="Full Name" required>
                            <label for="userName"><i class="fas fa-id-card me-2"></i>Full Name</label>
                        </div>

                        <div class="form-floating">
                            <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="name@example.com" required>
                            <label for="userEmail"><i class="fas fa-envelope me-2"></i>Email Address</label>
                        </div>

                        <div class="form-floating">
                            <input type="tel" class="form-control" id="userPhoneNo" name="userPhoneNo" placeholder="Phone Number">
                            <label for="userPhoneNo"><i class="fas fa-phone me-2"></i>Phone Number (Optional)</label>
                        </div>

                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required minlength="6">
                            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                        </div>

                        <div class="password-requirements">
                            <h6><i class="fas fa-info-circle me-1"></i>Password Requirements:</h6>
                            <ul>
                                <li>At least 6 characters long</li>
                                <li>Use a mix of letters, numbers, and symbols</li>
                                <li>Avoid common words or personal information</li>
                            </ul>
                        </div>

                        <div class="role-info">
                            <i class="fas fa-user-graduate me-2"></i>
                            <strong>Student Account:</strong> You're creating a student account that will allow you to participate in events, book resources, and access university facilities.
                        </div>

                        <button type="submit" class="btn-auth" id="signupBtn">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </form>

                    <div class="auth-links">
                        Already have an account? 
                        <a href="${pageContext.request.contextPath}/login.jsp">
                            <i class="fas fa-sign-in-alt me-1"></i>Sign in here
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Success popup & redirect -->
    <c:if test="${param.success == 'true'}">
        <div class="modal fade" id="successModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">
                            <i class="fas fa-check-circle me-2"></i>Registration Successful!
                        </h5>
                    </div>
                    <div class="modal-body text-center">
                        <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                        <h5>Welcome to UiTM Activity Hub!</h5>
                        <p>Your account has been created successfully. You will be redirected to the login page to sign in.</p>
                        <div class="progress mt-3">
                            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 0%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const modal = new bootstrap.Modal(document.getElementById('successModal'));
                modal.show();
                
                // Animate progress bar
                let progress = 0;
                const progressBar = document.querySelector('.progress-bar');
                const interval = setInterval(() => {
                    progress += 10;
                    progressBar.style.width = progress + '%';
                    if (progress >= 100) {
                        clearInterval(interval);
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/login.jsp';
                        }, 500);
                    }
                }, 300);
            });
        </script>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const signupBtn = document.getElementById('signupBtn');
            signupBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating Account...';
            signupBtn.disabled = true;
        });

        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            this.style.borderColor = strength < 2 ? '#dc3545' : strength < 4 ? '#ffc107' : '#28a745';
        });

        // Auto-hide alerts
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
    </script>
</body>
</html>