<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Event List</title>
  <style>
    .event-list {
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

    .event-item h3 {
      margin: 0;
      color: #4b2e83;
    }

    .event-item p {
      margin: 5px 0;
      color: #333;
    }

    .event-item button {
      margin-top: 5px;
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
  </style>
</head>
<body>
  <jsp:include page="studentSidebar.jsp" />

  <div class="main-content">
    <h1>All Events</h1>

    <div class="event-list">
      <c:forEach var="event" items="${allEvents}">
        <div class="event-item">
          <h3>${event.title}</h3>
          <p>Date: ${event.date}</p>
          <p>Venue: ${event.venue}</p>
          <button onclick="location.href='RegisterEventServlet?id=${event.id}'">Register</button>
        </div>
      </c:forEach>

      <c:if test="${empty allEvents}">
        <p>No events available at the moment.</p>
      </c:if>
    </div>
  </div>
</body>
</html>
