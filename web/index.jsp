<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UiTM Activity Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .hero-section {
            padding: 100px 0;
            text-align: center;
            color: white;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.9;
        }
        
        .btn-hero {
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            padding: 15px 40px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            margin: 10px;
            backdrop-filter: blur(10px);
        }
        
        .btn-hero:hover {
            background: white;
            color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        .features-section {
            background: white;
            padding: 80px 0;
            margin-top: -50px;
            border-radius: 50px 50px 0 0;
        }
        
        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: none;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: white;
        }
        
        .feature-icon.primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
        }
        
        .feature-icon.success {
            background: linear-gradient(45deg, #28a745, #20c997);
        }
        
        .feature-icon.warning {
            background: linear-gradient(45deg, #ffc107, #fd7e14);
        }
        
        .feature-icon.info {
            background: linear-gradient(45deg, #17a2b8, #007bff);
        }
        
        .stats-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 60px 0;
        }
        
        .stat-card {
            text-align: center;
            padding: 30px;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 1.1rem;
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .btn-hero {
                display: block;
                margin: 10px auto;
                width: 80%;
            }
        }
    </style>
</head>
<body>
    <!-- Check if user is already logged in -->
    <c:if test="${not empty sessionScope.userID}">
        <c:choose>
            <c:when test="${sessionScope.userRole == 'organization'}">
                <c:redirect url="/organization?action=dashboard"/>
            </c:when>
            <c:when test="${sessionScope.userRole == 'student'}">
                <c:redirect url="/student?action=dashboard"/>
            </c:when>
            <c:when test="${sessionScope.userRole == 'staff'}">
                <c:redirect url="/staff?action=dashboard"/>
            </c:when>
            <c:when test="${sessionScope.userRole == 'admin'}">
                <c:redirect url="/admin?action=dashboard"/>
            </c:when>
        </c:choose>
    </c:if>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <i class="fas fa-university fa-4x mb-4"></i>
                    <h1 class="hero-title">UiTM Activity System</h1>
                    <p class="hero-subtitle">
                        Comprehensive Campus Event and Activity Management Platform
                    </p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-hero">
                            <i class="fas fa-sign-in-alt me-2"></i>Login to System
                        </a>
                        <a href="#features" class="btn btn-hero">
                            <i class="fas fa-info-circle me-2"></i>Learn More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section" id="features">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="display-5 fw-bold text-primary mb-3">Powerful Features</h2>
                    <p class="lead text-muted">Everything you need to manage campus activities efficiently</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon primary">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Event Management</h5>
                        <p class="text-muted">Create, manage, and track campus events with ease. Full lifecycle management from planning to completion.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon success">
                            <i class="fas fa-building"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Venue Booking</h5>
                        <p class="text-muted">Book venues across campus with real-time availability checking and conflict resolution.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon warning">
                            <i class="fas fa-boxes"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Resource Management</h5>
                        <p class="text-muted">Manage and book equipment, furniture, and other resources for your events.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon info">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h5 class="fw-bold mb-3">Analytics & Reports</h5>
                        <p class="text-muted">Comprehensive reporting and analytics to track performance and make data-driven decisions.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Events Managed</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Venues Available</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">100+</div>
                        <div class="stat-label">Organizations</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-number">5000+</div>
                        <div class="stat-label">Students</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="hero-section" style="padding: 60px 0;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Ready to Get Started?</h2>
                    <p class="lead mb-4">Join hundreds of organizations already using our platform</p>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-hero btn-lg">
                        <i class="fas fa-rocket me-2"></i>Start Managing Events
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h6><i class="fas fa-university me-2"></i>UiTM Activity System</h6>
                    <p class="mb-0">Campus Event and Activity Management Platform</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">© 2025 UiTM. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Smooth scrolling -->
    <script>
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