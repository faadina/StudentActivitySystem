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
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 20px;
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

    .sidebar ul li a {
      display: block;
      padding: 10px;
      text-decoration: none;
      color: white;
      border-radius: 4px;
    }

    .sidebar ul li a:hover {
      background-color: #321b5c;
    }

    .sidebar .bottom-links {
      padding-top: 20px;
      border-top: 1px solid #6c5b7b;
    }
</style>

<div class="sidebar">
  <div>
    <img class="logo" src="images/Logo UiTM- WHITE.png" alt="UiTM Logo" />
    <ul>
      <li><a href="StudentDashboardServlet">Dashboard</a></li>
      <li><a href="EventListServlet">Event List</a></li>
      <li><a href="RegisterEventServlet">Register for Event</a></li>
      <li><a href="CertificateServlet">My Certificates</a></li>
      <li><a href="MyRegistrationsServlet">Registration History</a></li>
      <li><a href="FeedbackFormServlet">Feedback</a></li>
    </ul>
  </div>
  <div class="bottom-links">
    <a href="LogoutServlet" style="color:white; text-decoration:none; display:block; padding:10px;">Logout</a>
  </div>
</div>
