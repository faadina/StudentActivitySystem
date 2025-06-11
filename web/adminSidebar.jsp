<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

<style>
    .sidebar {
        background-color: #4b2e83;
        color: white;
        width: 220px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 20px;
        box-sizing: border-box;
    }

    .sidebar .logo {
        display: block;
        width: 180px;
        margin: 10px auto 20px;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }

    .sidebar ul li {
        margin-bottom: 10px;
    }

    .sidebar ul li a {
        color: white;
        text-decoration: none;
        padding: 10px;
        display: block;
        border-radius: 4px;
        transition: background-color 0.2s;
    }

    .sidebar ul li a:hover {
        background-color: #321b5c;
    }

    .bottom-links {
        border-top: 1px solid #6c5b7b;
        padding-top: 15px;
    }

    .bottom-links a {
        color: white;
        text-decoration: none;
        display: block;
        padding: 10px;
    }

    .bottom-links a:hover {
        background-color: #321b5c;
        border-radius: 4px;
    }
</style>

<div class="sidebar">
    <div>
        <img class="logo" src="images/Logo UiTM- WHITE.png" alt="UiTM Logo" />
        <ul>
            <li><a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="Aprofile.jsp">Profile</a></li>
            <li><a href="adminEventList.jsp"><i class="fas fa-calendar-alt"></i> Events</a></li>
            <li><a href="adminUserManagementList.jsp"><i class="fas fa-users-cog"></i> User Management</a></li>
            <li><a href="adminReport.jsp"><i class="fas fa-file-alt"></i> Report</a></li>
        </ul>
    </div>
    <div class="bottom-links">
        <a href="signoutController"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>
