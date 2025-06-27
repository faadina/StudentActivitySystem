<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Certificates - UiTM Activity System</title>
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
        
        .achievement-banner {
            background: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%);
            color: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .achievement-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y=".9em" font-size="90">🏆</text></svg>') repeat;
            opacity: 0.1;
            animation: float 20s infinite linear;
        }
        
        @keyframes float {
            0% { transform: translateX(-50px) translateY(-50px); }
            100% { transform: translateX(50px) translateY(50px); }
        }
        
        .achievement-content {
            position: relative;
            z-index: 2;
        }
        
        .stats-row {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .stat-card {
            text-align: center;
            padding: 20px;
        }
        
        .stat-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 2rem;
        }
        
        .stat-icon.primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .stat-icon.success {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
        }
        
        .stat-icon.warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }
        
        .stat-icon.info {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            color: white;
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
        
        .certificate-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .certificate-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
        }
        
        .certificate-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .certificate-preview {
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .certificate-preview::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 20px;
            right: 20px;
            bottom: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 10px;
        }
        
        .certificate-content {
            position: relative;
            z-index: 2;
            text-align: center;
        }
        
        .certificate-icon {
            font-size: 3rem;
            margin-bottom: 10px;
            opacity: 0.8;
        }
        
        .certificate-type {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .certificate-body {
            padding: 25px;
        }
        
        .certificate-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .certificate-meta {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .certificate-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        
        .detail-row:last-child {
            margin-bottom: 0;
        }
        
        .btn-download {
            background: linear-gradient(45deg, #27ae60, #229954);
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-download:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
            color: white;
        }
        
        .btn-preview {
            background: linear-gradient(45deg, #3498db, #2980b9);
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            margin-right: 10px;
        }
        
        .btn-preview:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 20px;
        }
        
        .filter-section {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .filter-btn {
            background: transparent;
            border: 2px solid #e9ecef;
            color: #6c757d;
            padding: 8px 20px;
            border-radius: 20px;
            margin: 5px;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .filter-btn.active,
        .filter-btn:hover {
            background: linear-gradient(45deg, #3498db, #2980b9);
            border-color: #3498db;
            color: white;
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
            
            .certificate-grid {
                grid-template-columns: 1fr;
            }
            
            .stat-card {
                padding: 15px 10px;
            }
            
            .stat-number {
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
        
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-2">
                        <i class="fas fa-certificate me-2 text-primary"></i>
                        My Certificates
                    </h2>
                    <p class="mb-0 text-muted">
                        Your collection of earned certificates and achievements
                    </p>
                </div>
                <div class="col-md-4 text-md-end">
                    <button class="btn btn-primary" onclick="downloadAllCertificates()">
                        <i class="fas fa-download me-2"></i>Download All
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Achievement Banner -->
        <c:if test="${certificatesEarned > 0}">
            <div class="achievement-banner">
                <div class="achievement-content">
                    <h3 class="mb-3">🎉 Congratulations!</h3>
                    <h4 class="mb-2">You've earned ${certificatesEarned} certificate<c:if test="${certificatesEarned > 1}">s</c:if>!</h4>
                    <p class="mb-0 opacity-75">
                        Keep participating in events to earn more achievements and recognition.
                    </p>
                </div>
            </div>
        </c:if>
        
        <!-- Statistics -->
        <div class="stats-row">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon primary">
                            <i class="fas fa-certificate"></i>
                        </div>
                        <div class="stat-number text-primary">${totalCertificates}</div>
                        <div class="stat-label">Total Certificates</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon success">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-number text-success">${academicCertificates}</div>
                        <div class="stat-label">Academic Events</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon warning">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div class="stat-number text-warning">${culturalCertificates}</div>
                        <div class="stat-label">Cultural Events</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon info">
                            <i class="fas fa-medal"></i>
                        </div>
                        <div class="stat-number text-info">${sportsCertificates}</div>
                        <div class="stat-label">Sports Events</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <h6 class="mb-3">Filter by Category:</h6>
            <div class="text-center">
                <button class="filter-btn active" onclick="filterCertificates('all')">
                    All Certificates
                </button>
                <button class="filter-btn" onclick="filterCertificates('academic')">
                    Academic
                </button>
                <button class="filter-btn" onclick="filterCertificates('cultural')">
                    Cultural
                </button>
                <button class="filter-btn" onclick="filterCertificates('sports')">
                    Sports
                </button>
                <button class="filter-btn" onclick="filterCertificates('leadership')">
                    Leadership
                </button>
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
        
        <!-- Certificates Grid -->
        <c:choose>
            <c:when test="${not empty certificates}">
                <div class="certificate-grid" id="certificatesGrid">
                    <c:forEach var="certificate" items="${certificates}">
                        <div class="certificate-card" data-category="${certificate.eventCategory.toLowerCase()}">
                            <div class="certificate-preview">
                                <div class="certificate-type">${certificate.eventCategory}</div>
                                <div class="certificate-content">
                                    <div class="certificate-icon">
                                        <c:choose>
                                            <c:when test="${certificate.eventCategory == 'Academic'}">
                                                <i class="fas fa-graduation-cap"></i>
                                            </c:when>
                                            <c:when test="${certificate.eventCategory == 'Cultural'}">
                                                <i class="fas fa-theater-masks"></i>
                                            </c:when>
                                            <c:when test="${certificate.eventCategory == 'Sports'}">
                                                <i class="fas fa-medal"></i>
                                            </c:when>
                                            <c:when test="${certificate.eventCategory == 'Leadership'}">
                                                <i class="fas fa-crown"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-certificate"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h6 class="mb-0">Certificate of Achievement</h6>
                                </div>
                            </div>
                            
                            <div class="certificate-body">
                                <h5 class="certificate-title">${certificate.eventTitle}</h5>
                                <div class="certificate-meta">
                                    <i class="fas fa-calendar me-2"></i>
                                    <fmt:formatDate value="${certificate.issueDate}" pattern="MMMM dd, yyyy"/>
                                </div>
                                
                                <div class="certificate-details">
                                    <div class="detail-row">
                                        <span><strong>Event Date:</strong></span>
                                        <span><fmt:formatDate value="${certificate.eventDate}" pattern="MMM dd, yyyy"/></span>
                                    </div>
                                    <div class="detail-row">
                                        <span><strong>Duration:</strong></span>
                                        <span>${certificate.duration} hours</span>
                                    </div>
                                    <div class="detail-row">
                                        <span><strong>Organizer:</strong></span>
                                        <span>${certificate.organizer}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span><strong>Certificate ID:</strong></span>
                                        <span>${certificate.certificateId}</span>
                                    </div>
                                </div>
                                
                                <div class="d-flex mb-3">
                                    <button class="btn-preview" onclick="previewCertificate('${certificate.certificateId}')">
                                        <i class="fas fa-eye me-2"></i>Preview
                                    </button>
                                    <button class="btn btn-outline-primary btn-sm flex-fill" onclick="shareCertificate('${certificate.certificateId}')">
                                        <i class="fas fa-share me-2"></i>Share
                                    </button>
                                </div>
                                
                                <a href="student?action=downloadCertificate&certificateId=${certificate.certificateId}" 
                                   class="btn-download">
                                    <i class="fas fa-download me-2"></i>Download PDF
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-certificate"></i>
                    <h4 class="mb-3">No Certificates Yet</h4>
                    <p class="text-muted mb-4">
                        You haven't earned any certificates yet. Participate in events and complete them to earn your first certificate!
                    </p>
                    <a href="student?action=events" class="btn btn-primary">
                        <i class="fas fa-search me-2"></i>Browse Events
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Certificate Preview Modal -->
    <div class="modal fade" id="certificatePreviewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Certificate Preview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center" id="certificatePreviewContent">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="downloadFromPreview">
                        <i class="fas fa-download me-2"></i>Download
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Toggle sidebar for mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
        }
        
        // Filter certificates
        function filterCertificates(category) {
            // Update active filter button
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Filter certificate cards
            const cards = document.querySelectorAll('.certificate-card');
            cards.forEach(card => {
                if (category === 'all') {
                    card.style.display = 'block';
                } else {
                    const cardCategory = card.getAttribute('data-category');
                    if (cardCategory === category) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
        }
        
        // Preview certificate
        function previewCertificate(certificateId) {
            const modal = new bootstrap.Modal(document.getElementById('certificatePreviewModal'));
            const content = document.getElementById('certificatePreviewContent');
            
            // Show loading
            content.innerHTML = `
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-3">Loading certificate preview...</p>
            `;
            
            modal.show();
            
            // Simulate loading (replace with actual preview loading)
            setTimeout(() => {
                content.innerHTML = `
                    <div class="certificate-preview-large">
                        <div style="border: 3px solid #3498db; border-radius: 15px; padding: 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
                            <div style="text-align: center; color: #2c3e50;">
                                <h2 style="color: #3498db; margin-bottom: 20px;">🏆 CERTIFICATE OF ACHIEVEMENT 🏆</h2>
                                <h4 style="margin-bottom: 30px;">This is to certify that</h4>
                                <h3 style="color: #e74c3c; border-bottom: 2px solid #3498db; display: inline-block; padding-bottom: 5px; margin-bottom: 30px;">
                                    ${sessionScope.currentUser.fullName}
                                </h3>
                                <h4 style="margin-bottom: 20px;">has successfully participated in</h4>
                                <h3 style="color: #27ae60; margin-bottom: 30px;">Event Title</h3>
                                <div style="display: flex; justify-content: space-between; margin-top: 40px;">
                                    <div style="text-align: left;">
                                        <p style="margin: 0; border-top: 1px solid #bdc3c7; padding-top: 5px;">Date</p>
                                    </div>
                                    <div style="text-align: right;">
                                        <p style="margin: 0; border-top: 1px solid #bdc3c7; padding-top: 5px;">Authorized Signature</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                
                // Set download link for the preview modal
                document.getElementById('downloadFromPreview').onclick = function() {
                    window.location.href = 'student?action=downloadCertificate&certificateId=' + certificateId;
                };
            }, 1500);
        }
        
        // Share certificate
        function shareCertificate(certificateId) {
            if (navigator.share) {
                navigator.share({
                    title: 'My Certificate',
                    text: 'Check out my certificate from UiTM!',
                    url: window.location.origin + '/student?action=viewCertificate&certificateId=' + certificateId
                });
            } else {
                // Fallback - copy link to clipboard
                const link = window.location.origin + '/student?action=viewCertificate&certificateId=' + certificateId;
                navigator.clipboard.writeText(link).then(() => {
                    alert('Certificate link copied to clipboard!');
                });
            }
        }
        
        // Download all certificates
        function downloadAllCertificates() {
            if (confirm('This will download all your certificates as a ZIP file. Continue?')) {
                window.location.href = 'student?action=downloadAllCertificates';
            }
        }
        
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
        
        // Add loading states for download buttons
        document.querySelectorAll('.btn-download').forEach(btn => {
            btn.addEventListener('click', function(e) {
                const originalContent = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Downloading...';
                this.classList.add('disabled');
                
                // Re-enable after 3 seconds (fallback)
                setTimeout(() => {
                    this.innerHTML = originalContent;
                    this.classList.remove('disabled');
                }, 3000);
            });
        });
        
        // Add animation to cards on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.certificate-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>