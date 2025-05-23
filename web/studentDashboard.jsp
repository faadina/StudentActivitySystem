<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Student Dashboard</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      display: flex;
      height: 100vh;
      background-color: #f5f6fa;
    }

    .main-content {
      flex-grow: 1;
      padding: 30px;
      overflow-y: auto;
    }

    h1 {
      color: #4b2e83;
    }

    .summary-cards {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
      margin-bottom: 30px;
    }

    .card {
      background: white;
      border-radius: 8px;
      padding: 20px;
      flex: 1;
      min-width: 200px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .card span {
      font-size: 24px;
      font-weight: bold;
      margin-top: 10px;
      display: block;
      color: #4b2e83;
    }

    .event-section {
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .event-item {
      padding: 10px 0;
      border-bottom: 1px solid #ddd;
    }

    .event-item:last-child {
      border-bottom: none;
    }

    .event-item h4 {
      margin: 0;
      color: #4b2e83;
    }

    .event-item p {
      margin: 5px 0;
      color: #333;
    }

    .event-item button {
      padding: 6px 12px;
      background-color: #4b2e83;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .event-item button:hover {
      background-color: #321b5c;
    }

    .view-all {
      display: block;
      text-align: right;
      margin-top: 10px;
      color: #4b2e83;
      text-decoration: none;
    }

    .view-all:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <jsp:include page="studentSidebar.jsp" />

  <div class="main-content">
    <h1>Welcome, ${studentName}!</h1>

    <div class="summary-cards">
      <div class="card">Events Joined <span>${joinedCount}</span></div>
      <div class="card">Certificates Earned <span>${certificateCount}</span></div>
      <div class="card">Pending Feedback <span>${pendingFeedback}</span></div>
    </div>

    <div class="event-section">
      <h3>Upcoming Events</h3>

      <c:forEach var="event" items="${upcomingEvents}">
        <div class="event-item">
          <h4>${event.title}</h4>
          <p>${event.date} – ${event.venue}</p>
          <button onclick="location.href='RegisterEventServlet?id=${event.id}'">Register</button>
        </div>
      </c:forEach>

      <c:if test="${empty upcomingEvents}">
        <p>No upcoming events at the moment.</p>
      </c:if>

      <a href="EventListServlet" class="view-all">View All Events</a>
    </div>
  </div>
</body>
</html>
