<%@ page contentType="text/html;charset=UTF-8" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
    .sidebar {
        background: linear-gradient(135deg, 
#667eea 0%, 
#764ba2 100%);
        min-height: 100vh;
        color: white;
    }
    .sidebar {
        display: flex;
        flex-direction: column;
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
    .logout-section {
        padding: 1rem 0;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        margin-top: auto;
    }
    
    .logout-section .nav-link {
        color: rgba(255, 255, 255, 0.9);
        font-weight: 500;
    }
    
    .logout-section .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.2);
        color: #ff6b6b;
        transform: translateX(5px);
    }
    
        /* Responsive adjustments */
    @media (max-width: 768px) {
        .sidebar {
            position: relative;
            width: 100%;
            min-height: auto;
        }
        
        .sidebar-content {
            padding: 0.5rem;
        }
        
        .main-nav {
            padding-top: 0.5rem;
        }
        
        .logout-section {
            padding: 0.5rem 0;
            margin-top: 1rem;
        }
    }
</style>
<div class="col-md-3 col-lg-2 sidebar p-0">
    <div class="p-3 text-center">
        <img src="${pageContext.request.contextPath}/images/Logo UiTM - Black.png" 
             alt="UiTM Logo" 
             class="img-fluid mb-2" 
             style="max-width: 180px;">
    </div>

    <nav class="nav flex-column px-3">
        <!-- ✅ FIXED: Check for both dashboard action and empty param -->
        <a class="nav-link ${param.action == 'dashboard' || empty param.action ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=dashboard">
            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
        </a>

        <a class="nav-link ${param.action == 'events' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=events">
            <i class="fas fa-calendar-alt me-2"></i>My Events
        </a>
        <a class="nav-link ${param.action == 'createEvent' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=createEvent">
            <i class="fas fa-plus-circle me-2"></i>Create Event
        </a>

        <a class="nav-link ${param.action == 'venues' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=venues">
            <i class="fas fa-building me-2"></i>Venue Booking
        </a>

        <a class="nav-link ${param.action == 'resources' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=resources">
            <i class="fas fa-boxes me-2"></i>Resource Booking
        </a>

        <a class="nav-link ${param.action == 'profile' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/organization?action=profile">
            <i class="fas fa-user me-2"></i>Profile
        </a>
    </nav>

        <div class="logout-section">
            <a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout" 
               onclick="return confirm('Are you sure you want to logout?')">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
</div>