<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Organization Dashboard</title>
  <style>
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

    .quick-actions {
      display: flex;
      flex-wrap: wrap;
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
      padding: 10px 0;
      border-bottom: 1px solid #ddd;
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
      margin-top: 5px;
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
    
  <jsp:include page="orgSidebar.jsp" />
  <div class="main-content">
    <h1>Organization Dashboard</h1>

    <div class="summary-cards">
      <div class="card">Venue Bookings <span>${venueCount}</span></div>
      <div class="card">Resource Requests <span>${resourceCount}</span></div>
      <div class="card">Pending Proposals <span>${pendingProposals}</span></div>
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
