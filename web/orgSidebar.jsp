<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      display: flex;
      height: 100vh;
      overflow: hidden;
      background-color: #f5f6fa;
    }

    .sidebar {
        background-color: #4b2e83;
        color: white;
        width: 220px; 
        min-width: 220px; 
        max-width: 250px;
        height: 100vh;
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
        margin: 0;
    }

    .sidebar ul li {
        margin-bottom: 10px;
    }

    .sidebar ul li a {
        display: block;
        padding: 10px 15px;
        text-decoration: none;
        color: white;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .sidebar ul li a:hover {
        background-color: #321b5c;
    }

    .sidebar .bottom-links {
        padding-top: 20px;
        border-top: 1px solid #6c5b7b;
    }

    .bottom-links a {
        display: block;
        padding: 10px 15px;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .bottom-links a:hover {
        background-color: #321b5c;
    }

    .main-content {
        flex-grow: 1;
        padding: 30px;
        overflow-y: auto;
    }

    h1 {
        color: #4b2e83;
    }
</style>

<div class="sidebar">
  <div>
    <img class="logo" src="images/Logo UiTM- WHITE.png" alt="UiTM Logo" />
    <ul>
      <li><a href="orgDashboard.jsp">Dashboard</a></li>
      <li><a href="orgListEvent.jsp">List Events</a></li>
      <li><a href="orgCreateEvent.jsp">Create Event</a></li>
      <li><a href="ListParticipantsServlet">List Participant</a></li>
      <li><a href="CertificatesServlet">Certificates</a></li>
      <li><a href="orgListFeedback.jsp">Feedback</a></li>
      <li><a href="ReportsServlet">Report</a></li>
    </ul>
  </div>
  <div class="bottom-links">
    <a href="LogoutServlet">Logout</a>
  </div>
</div>
