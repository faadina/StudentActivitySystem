<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Organization Dashboard</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      display: flex;
      height: 100vh;
      overflow: hidden;
    }
    .sidebar {
      background-color: #4b2e83;
      color: white;
      width: 220px;
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 20px;
    }
    .sidebar .logo {
      margin: 10px auto 20px;
      display: block;
      width: 180px;
    }
    .sidebar ul {
      list-style-type: none;
      padding: 0;
      flex-grow: 1;
    }
    .sidebar ul li a {
      display: block;
      padding: 10px;
      text-decoration: none;
      color: white;
    }
    .sidebar ul li a:hover {
      background-color: #321b5c;
    }
    .sidebar .bottom-links {
      padding-top: 20px;
      border-top: 1px solid #6c5b7b;
      margin-bottom: 20px;
    }
    .main-content {
      flex-grow: 1;
      padding: 30px;
      background-color: #f5f6fa;
      overflow-y: auto;
    }
    .summary-cards {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
    }
    .card {
      background: white;
      border-radius: 8px;
      padding: 20px;
      flex: 1;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .card span {
      font-size: 24px;
      font-weight: bold;
      display: block;
      margin-top: 10px;
    }
    .quick-actions {
      display: flex;
      gap: 10px;
      margin-bottom: 30px;
    }
    .quick-actions button {
      padding: 10px 15px;
      border: none;
      border-radius: 6px;
      background-color: #4b2e83;
      color: white;
      cursor: pointer;
    }
    .quick-actions button:hover {
      background-color: #321b5c;
    }
    .created-events {
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .event-card {
      padding: 10px;
      border-bottom: 1px solid #ccc;
    }
    .event-card:last-child {
      border-bottom: none;
    }
    .event-card button {
      padding: 5px 10px;
      background-color: orange;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .view-all {
      display: block;
      text-align: right;
      margin-top: 10px;
      color: #4b2e83;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <div class="sidebar">
    <div>
      <img class="logo" src="images/Logo UiTM- WHITE.png" alt="UiTM Logo">
      <ul>
        <li><a href="OrgDashboardServlet">Dashboard</a></li>
        <li><a href="ListEventsServlet">Events</a></li>
        <li><a href="CreateEventServlet">Create Event</a></li>
        <li><a href="ListParticipantsServlet">List Participant</a></li>
        <li><a href="CertificatesServlet">Certificates</a></li>
        <li><a href="FeedbackServlet">Feedback</a></li>
        <li><a href="ReportsServlet">Report</a></li>
        <li><a href="VenuesServlet">Venue Department</a></li>
        <li><a href="ResourcesServlet">Resources Department</a></li>
        <li><a href="ProfileServlet">Profile</a></li>
      </ul>
    </div>
    <div class="bottom-links">
      <a href="LogoutServlet" style="color:white; text-decoration:none; display:block; padding:10px;">Logout</a>
    </div>
  </div>
  <div class="main-content">
    <h1>Organization Dashboard</h1>
    <div class="summary-cards">
      <div class="card">Venue Bookings <span>${venueCount}</span></div>
      <div class="card">Resource Requests <span>${resourceCount}</span></div>
      <div class="card">Pending Proposal <span>${pendingProposals}</span></div>
      <div class="card">Active Proposals <span>${activeProposals}</span></div>
    </div>
    <div class="quick-actions">
      <button onclick="location.href='NewProposalServlet'">New Proposal</button>
      <button onclick="location.href='BookVenueServlet'">Book Venue</button>
      <button onclick="location.href='RequestResourcesServlet'">Request Resources</button>
      <button onclick="location.href='ListEventsServlet'">View Events</button>
      <button onclick="location.href='CertificatesServlet'">Certificates</button>
      <button onclick="location.href='FeedbackServlet'">Feedback</button>
    </div>
    <div class="created-events">
      <h3>Created Events</h3>
      <c:forEach var="event" items="${createdEvents}">
        <div class="event-card">
          <h4>${event.title}</h4>
          <p>${event.date} – ${event.venue}</p>
          <p>Status: ${event.status}</p>
          <c:if test="${event.status eq 'Rejected'}">
            <button onclick="location.href='AppealServlet?id=${event.id}'">Appeal</button>
          </c:if>
        </div>
      </c:forEach>
      <a href="ListEventsServlet" class="view-all">View All</a>
    </div>
  </div>
</body>
</html>
