<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
    .sidebar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
<div class="sidebar">
    <div>
            <div class="p-3 text-center">
                <img src="${pageContext.request.contextPath}/images/Logo UiTM - Black.png" 
                     alt="UiTM Logo" 
                     class="img-fluid mb-2" 
                     style="max-width: 180px;">
            </div>
        <nav class="nav flex-column px-3">
            <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="staff?action=dashboard">
                <i class="fas fa-tachometer-alt fa-fw me-2"></i> Dashboard
            </a>
            <div class="nav-heading mt-3">Approvals</div>
            <a class="nav-link ${param.active == 'venueBookings' ? 'active' : ''}" href="staff?action=venueBookings">
                <i class="fas fa-calendar-check fa-fw me-2"></i> Venue Bookings</a>
            <a class="nav-link ${param.active == 'resourceBookings' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/staff?action=resourceBookings">
                <i class="fas fa-calendar-check fa-fw me-2"></i>Resource Bookings
            </a>
            <div class="nav-heading mt-3">Asset Management</div>
            <a class="nav-link ${param.active == 'venueManagement' ? 'active' : ''}" href="staff?action=venueManagement">
                <i class="fas fa-building fa-fw me-2"></i> Venues</a>
            <a class="nav-link ${param.active == 'resourceManagement' ? 'active' : ''}" href="staff?action=resourceManagement">
                <i class="fas fa-box fa-fw me-2"></i> Resources</a>
            <div class="nav-heading mt-3">Account</div>
            <a class="nav-link ${param.active == 'profile' ? 'active' : ''}" href="staff?action=profile">
                <i class="fas fa-user-cog fa-fw me-2"></i> Profile</a>
        </nav>
    </div>
    <div class="logout-section">
        <hr><nav class="nav flex-column px-3 pb-3"><a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout">
                <i class="fas fa-sign-out-alt fa-fw me-2"></i> Logout</a></nav>
    </div>
</div>