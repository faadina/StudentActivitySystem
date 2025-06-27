<%@ page contentType="text/html;charset=UTF-8" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
    .sidebar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        color: white;
    }
    .sidebar .nav-link {
        color: rgba(255, 255, 255, 0.85);
        padding: 12px 20px;
        border-radius: 8px;
        margin: 2px 0;
        transition: all 0.3s ease;
    }
    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
        color: white;
        background-color: rgba(255, 255, 255, 0.15);
        transform: translateX(5px);
    }
    .sidebar h4 {
        font-weight: bold;
    }
    .sidebar small {
        font-size: 0.85rem;
    }
</style>
<div class="col-md-3 col-lg-2 sidebar p-0">
    <div class="p-3">
        <h4 class="mb-0">
            <i class="fas fa-university me-2"></i>
            UiTM Activity
        </h4>
        <small class="text-light opacity-75">Student Panel</small>
    </div>
                        
    <nav class="nav flex-column px-3">
        <!-- ✅ FIXED: Check for both dashboard action and empty param -->
        <a class="nav-link ${param.action == 'dashboard' || empty param.action ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=dashboard">
            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
        </a>
        
        <!-- ✅ FIXED: Check for events action AND currentPage attribute -->
        <a class="nav-link ${param.action == 'events' || currentPage == 'events' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=events">
            <i class="fas fa-calendar-alt me-3"></i>Browse Events
        </a>
        
        <a class="nav-link ${param.action == 'myRegistration' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=myRegistration">
            <i class="notification-badge"></i>My Registrations
        </a>
        
        <a class="nav-link ${param.action == 'certificate' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=certificate">
            <i class="fas fa-certificate me-3"></i>Certificates
        </a>
        
        <a class="nav-link ${param.action == 'feedback' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=feedback">
            <i class="fas fa-comment-alt me-3"></i>Feedback
        </a>
        
        <a class="nav-link ${param.action == 'profile' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/student?action=profile">
            <i class="fas fa-user me-2"></i>Profile
        </a>
        
        <hr class="my-3">
        <a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout">
            <i class="fas fa-sign-out-alt me-2"></i>Logout
        </a>
    </nav>
</div>