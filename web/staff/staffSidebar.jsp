<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
    .sidebar{background:linear-gradient(180deg,#6D5BBA 0%,#5B4A9A 100%);box-shadow:3px 0 15px rgba(0,0,0,0.1);display:flex;flex-direction:column;justify-content:space-between;min-height:100vh}.sidebar .nav-link{color:rgba(255,255,255,0.75);padding:13px 25px;margin:2px 0;border-radius:8px;font-weight:500;transition:all 0.3s;border-left:4px solid transparent}.sidebar .nav-link:hover{background-color:rgba(255,255,255,0.1);color:#fff}.sidebar .nav-link.active{background-color:rgba(0,0,0,0.2);color:#fff;font-weight:700;border-left:4px solid #48D1CC}.sidebar .sidebar-header h4{color:#fff}.sidebar .sidebar-header small{color:rgba(255,255,255,0.7)}.sidebar hr{border-color:rgba(255,255,255,0.15);margin:1rem}.sidebar .nav-heading{padding:0 1.5rem;font-size:0.8rem;text-transform:uppercase;color:rgba(255,255,255,0.4);letter-spacing:1px;margin-top:1rem;}
</style>
<div class="sidebar">
    <div>
        <div class="p-4 text-center sidebar-header"><h4 class="mb-0"><i class="fas fa-clipboard-check"></i> Staff Panel</h4><small>Management & Approvals</small></div>
        <nav class="nav flex-column px-3">
            <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="staff?action=dashboard"><i class="fas fa-tachometer-alt fa-fw me-2"></i> Dashboard</a>
            <div class="nav-heading mt-3">Approvals</div>
            <a class="nav-link ${param.active == 'venueBookings' ? 'active' : ''}" href="staff?action=venueBookings"><i class="fas fa-calendar-check fa-fw me-2"></i> Venue Bookings</a>
            <a class="nav-link ${param.active == 'resourceBookings' ? 'active' : ''}" href="staff?action=resourceBookings"><i class="fas fa-hand-holding-box fa-fw me-2"></i> Resource Bookings</a>
            <div class="nav-heading mt-3">Asset Management</div>
            <a class="nav-link ${param.active == 'venueManagement' ? 'active' : ''}" href="staff?action=venueManagement"><i class="fas fa-building fa-fw me-2"></i> Venues</a>
            <a class="nav-link ${param.active == 'resourceManagement' ? 'active' : ''}" href="staff?action=resourceManagement"><i class="fas fa-box fa-fw me-2"></i> Resources</a>
            <div class="nav-heading mt-3">Account</div>
            <a class="nav-link ${param.active == 'profile' ? 'active' : ''}" href="staff?action=profile"><i class="fas fa-user-cog fa-fw me-2"></i> Profile</a>
        </nav>
    </div>
    <div class="logout-section">
        <hr><nav class="nav flex-column px-3 pb-3"><a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout"><i class="fas fa-sign-out-alt fa-fw me-2"></i> Logout</a></nav>
    </div>
</div>