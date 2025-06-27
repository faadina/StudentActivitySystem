<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Pautan ke pustaka CSS luaran --%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .sidebar {
        /* Latar belakang gradient ungu gelap */
        background: linear-gradient(180deg, #58247D 0%, #3A1854 100%);
        box-shadow: 3px 0 15px rgba(0,0,0,0.2);
        
        /* Susun atur Flexbox untuk menolak logout ke bawah */
        display: flex;
        flex-direction: column;
        justify-content: space-between;

        /* ======= PEMBETULAN DI SINI ======= */
        min-height: 100vh; /* Pastikan sidebar sentiasa penuh tinggi skrin */
    }
    .sidebar .nav-link {
        color: #d8bfd8;
        padding: 13px 25px;
        margin: 4px 0;
        border-radius: 8px;
        font-weight: 500;
        transition: background-color 0.3s, color 0.3s, padding-left 0.3s;
        border-left: 4px solid transparent; 
    }

    .sidebar .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.05);
        color: #ffffff; 
    }

    .sidebar .nav-link.active {
        background-color: rgba(255, 215, 0, 0.1);
        color: #ffffff; 
        font-weight: 700;
        border-left: 4px solid #FFD700; /* Warna emas UiTM */
        padding-left: 21px;
    }
    
    .sidebar .sidebar-header h4 {
        color: #ffffff;
        font-weight: 600;
    }
    .sidebar .sidebar-header small {
        color: #d8bfd8;
    }
    .sidebar hr {
        border-color: rgba(255, 255, 255, 0.15);
        margin-left: 1rem;
        margin-right: 1rem;
    }
    .sidebar .logout-section .nav-link:hover {
        background-color: rgba(231, 76, 60, 0.2);
        color: #ffffff;
    }
</style>

<div class="sidebar">
    <div>
        <div class="p-4 text-center sidebar-header">
            <h4 class="text-white mb-0">
                <i class="fas fa-cogs"></i> Admin Panel
            </h4>
            <small>Activity Management</small>
        </div>
        
        <nav class="nav flex-column px-3">
            <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="admin?action=dashboard">
                <i class="fas fa-tachometer-alt fa-fw me-2"></i> Dashboard
            </a>
            <a class="nav-link ${param.active == 'users' ? 'active' : ''}" href="admin?action=users">
                <i class="fas fa-users fa-fw me-2"></i> User Management
            </a>
            <a class="nav-link ${param.active == 'events' ? 'active' : ''}" href="admin?action=events">
                <i class="fas fa-calendar-alt fa-fw me-2"></i> Event Management
            </a>
            <a class="nav-link ${param.active == 'systemReports' ? 'active' : ''}" href="admin?action=systemReports">
                <i class="fas fa-chart-bar fa-fw me-2"></i> System Reports
            </a>
            <a class="nav-link ${param.active == 'profile' ? 'active' : ''}" href="admin?action=profile">
                <i class="fas fa-user-cog fa-fw me-2"></i> Profile Settings
            </a>
        </nav>
    </div>

    <div class="logout-section">
        <hr>
        <nav class="nav flex-column px-3 pb-3">
            <a class="nav-link" href="${pageContext.request.contextPath}/controller?action=logout">
                <i class="fas fa-sign-out-alt fa-fw me-2"></i> Logout
            </a>
        </nav>
    </div>
</div>