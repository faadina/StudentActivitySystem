<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Certificates - UiTM Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-color: #667eea;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --light-bg: #f8f9fa;
            --white: #ffffff;
            --dark-text: #2c3e50;
            --muted-text: #6c757d;
            --border-color: #dee2e6;
            --card-shadow: 0 4px 15px rgba(0,0,0,0.1);
            --card-hover-shadow: 0 8px 25px rgba(0,0,0,0.15);
            --border-radius: 12px;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-content {
            background-color: var(--light-bg);
            min-height: 100vh;
        }

        .page-header {
            background: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 20px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .certificate-card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
            margin-bottom: 20px;
            position: relative;
        }

        .certificate-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }

        .certificate-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #FFD700 0%, #FFA500 100%);
        }

        .certificate-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .certificate-body {
            padding: 20px;
        }

        .certificate-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 10px;
        }

        .certificate-detail {
            font-size: 0.9rem;
            color: var(--muted-text);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        .certificate-detail i {
            width: 20px;
            text-align: center;
            margin-right: 8px;
            color: var(--primary-color);
        }

        .certificate-badge {
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            color: #8B4513;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
            margin-bottom: 15px;
        }

        .btn-view-certificate {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view-certificate:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .btn-download {
            background: transparent;
            border: 2px solid var(--success-color);
            color: var(--success-color);
            padding: 6px 16px;
            border-radius: 18px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
        }

        .btn-download:hover {
            background: var(--success-color);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--muted-text);
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 5rem;
            margin-bottom: 30px;
            opacity: 0.3;
            color: #FFD700;
        }

        .empty-state h4 {
            color: var(--dark-text);
            margin-bottom: 15px;
        }

        .stats-row {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--muted-text);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @media (max-width: 768px) {
            .certificate-card {
                margin-bottom: 15px;
            }
            
            .certificate-body {
                padding: 15px;
            }
        }

        .animation-fadeInUp {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="studentSidebar.jsp">
                <jsp:param name="active" value="certificates"/>
            </jsp:include>
            
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <h2 class="mb-0">
                                    <i class="fas fa-certificate me-2 text-warning"></i>
                                    My Certificates
                                </h2>
                                <p class="text-muted mb-0">View and download your earned certificates</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <!-- Alert Messages -->
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>
                    
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <!-- Statistics -->
                    <div class="stats-row">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="stat-item">
                                    <div class="stat-number">${fn:length(certificateRegistrations)}</div>
                                    <div class="stat-label">Total Certificates</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-item">
                                    <div class="stat-number">
                                        <c:set var="thisYearCount" value="0" />
                                        <c:forEach var="cert" items="${certificateRegistrations}">
                                            <fmt:formatDate value="${cert.registrationDate}" pattern="yyyy" var="certYear" />
                                            <jsp:useBean id="now" class="java.util.Date" />
                                            <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
                                            <c:if test="${certYear eq currentYear}">
                                                <c:set var="thisYearCount" value="${thisYearCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${thisYearCount}
                                    </div>
                                    <div class="stat-label">This Year</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-item">
                                    <div class="stat-number">
                                        <c:set var="avgRating" value="0" />
                                        <c:set var="ratedCount" value="0" />
                                        <c:forEach var="cert" items="${certificateRegistrations}">
                                            <c:if test="${cert.rating > 0}">
                                                <c:set var="avgRating" value="${avgRating + cert.rating}" />
                                                <c:set var="ratedCount" value="${ratedCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${ratedCount > 0}">
                                                <fmt:formatNumber value="${avgRating / ratedCount}" maxFractionDigits="1" />
                                            </c:when>
                                            <c:otherwise>0</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="stat-label">Avg Rating Given</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Certificates Grid -->
                    <c:choose>
                        <c:when test="${not empty certificateRegistrations}">
                            <div class="row">
                                <c:forEach var="registration" items="${certificateRegistrations}" varStatus="status">
                                    <div class="col-lg-6 col-xl-4">
                                        <div class="certificate-card animation-fadeInUp" style="animation-delay: ${status.index * 0.1}s;">
                                            <div class="certificate-header">
                                                <div class="certificate-badge">
                                                    <i class="fas fa-award me-1"></i>Certificate
                                                </div>
                                            </div>
                                            <div class="certificate-body">
                                                <h5 class="certificate-title">${registration.eventTitle}</h5>
                                                
                                                <div class="certificate-detail">
                                                    <i class="fas fa-calendar"></i>
                                                    <span>Completed: <fmt:formatDate value="${registration.registrationDate}" pattern="dd MMM yyyy"/></span>
                                                </div>
                                                
                                                <div class="certificate-detail">
                                                    <i class="fas fa-user-tie"></i>
                                                    <span>Issued by Organization</span>
                                                </div>
                                                
                                                <c:if test="${registration.rating > 0}">
                                                    <div class="certificate-detail">
                                                        <i class="fas fa-star"></i>
                                                        <span>Your Rating: 
                                                            <c:forEach begin="1" end="${registration.rating}">
                                                                <i class="fas fa-star text-warning"></i>
                                                            </c:forEach>
                                                        </span>
                                                    </div>
                                                </c:if>
                                                
                                                <div class="mt-3">
                                                    <a href="${pageContext.request.contextPath}/student?action=viewCertificate&registrationId=${registration.registrationID}" 
                                                       class="btn-view-certificate">
                                                        <i class="fas fa-eye me-2"></i>View Certificate
                                                    </a>
                                                    <a href="#" onclick="downloadCertificate(${registration.registrationID})" 
                                                       class="btn-download">
                                                        <i class="fas fa-download me-1"></i>Download
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-certificate"></i>
                                <h4>No Certificates Yet</h4>
                                <p>Complete events to earn your certificates!</p>
                                <a href="${pageContext.request.contextPath}/student?action=events" 
                                   class="btn btn-primary btn-lg mt-3">
                                    <i class="fas fa-calendar me-2"></i>Browse Events
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                document.querySelectorAll('.alert').forEach(alert => {
                    if (alert.querySelector('.btn-close')) {
                        alert.querySelector('.btn-close').click();
                    }
                });
            }, 5000);
        });

        function downloadCertificate(registrationId) {
            // Open certificate in new window for printing/saving
            window.open(
                '${pageContext.request.contextPath}/student?action=viewCertificate&registrationId=' + registrationId + '&download=true',
                '_blank',
                'width=800,height=600'
            );
        }
    </script>
</body>
</html>