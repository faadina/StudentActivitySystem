<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
    .sidebar {
        background: linear-gradient(180deg, #007bff 0%, #0056b3 100%);
        box-shadow: 3px 0 15px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        min-height: 100vh;
    }
    .sidebar .nav-link {
        color: rgba(255,255,255,0.8);
        padding: 13px 25px;
        margin: 2px 0;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s;
        border-left: 4px solid transparent;
    }
    .sidebar .nav-link:hover {
        background-color: rgba(255,255,255,0.1);
        color: #fff;
    }
    .sidebar .nav-link.active {
        background-color: rgba(0,0,0,0.2);
        color: #fff;
        font-weight: 700;
        border-left: 4px solid #8cf;
    }
    .sidebar .sidebar-header h4 {
        color: #fff;
    }
    .sidebar .sidebar-header small {
        color: rgba(255,255,255,0.7);
    }
    .sidebar hr {
        border-color: rgba(255,255,255,0.15);
        margin: 1rem;
    }
</style>
<div class="sidebar">
    <div>
        <div class="p-4 text-center sidebar-header">
            <h4 class="mb-0"><i class="fas fa-user-graduate"></i> Student Panel</h4>
            <small>UiTM Activity System</small>
        </div>
        <nav class="nav flex-column px-3">
            <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/student?action=dashboard"><i class="fas fa-tachometer-alt fa-fw me-2"></i> Dashboard</a>
            <a class="nav-link ${param.active == 'events' ? 'active' : ''}" href="${pageContext.request.contextPath}/student?action=events"><i class="fas fa-calendar-alt fa-fw me-2"></i> All Events</a>
            <a class="nav-link ${param.active == 'myEvents' ? 'active' : ''}" href="${pageContext.request.contextPath}/student?action=myEvents"><i class="fas fa-calendar-check fa-fw me-2"></i> My Events</a>
            <a class="nav-link ${param.active == 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/student?action=profile"><i class="fas fa-user-cog fa-fw me-2"></i> My Profile</a>
        </nav>
    </div>
    <div class="logout-section">
        <hr>
        <nav class="nav flex-column px-3 pb-3">
            <a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout"><i class="fas fa-sign-out-alt fa-fw me-2"></i> Logout</a>
        </nav>
    </div>
</div>