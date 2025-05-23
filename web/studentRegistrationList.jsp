<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>My Registration</title>
  <style>
    .registration-container {
      background-color: #f0f2f5;
      padding: 30px;
      border-radius: 10px;
    }

    h1 {
      color: #4b2e83;
    }

    .section-title {
      font-weight: bold;
      margin-top: 30px;
      margin-bottom: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
      overflow: hidden;
    }

    th, td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #eaeaea;
    }

    th {
      background-color: #fafafa;
      color: #555;
    }

    .badge {
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: bold;
    }

    .completed {
      background-color: #d6eaff;
      color: #1f7dd8;
    }

    .confirmed {
      background-color: #d4edda;
      color: #218838;
    }

    .pending {
      background-color: #fff3cd;
      color: #856404;
    }

    .paid {
      color: green;
      font-weight: bold;
    }

    .unpaid {
      color: red;
      font-weight: bold;
    }

    .action-btn {
      border: none;
      background: transparent;
      font-size: 18px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<jsp:include page="studentSidebar.jsp"/>

<div class="main-content">
  <div class="registration-container">
    <h1>My Registration</h1>

    <div class="section-title">📌 Done Events</div>
    <table>
      <tr>
        <th>Event Name</th>
        <th>Date</th>
        <th>Status</th>
        <th>Payment</th>
        <th>Action</th>
      </tr>
      <c:forEach var="event" items="${doneEvents}">
        <tr>
          <td>${event.name}</td>
          <td>${event.date}</td>
          <td><span class="badge completed">Completed</span></td>
          <td><span class="paid">Paid</span></td>
          <td><button class="action-btn">⋮</button></td>
        </tr>
      </c:forEach>
    </table>

    <div class="section-title">📅 Upcoming Events</div>
    <table>
      <tr>
        <th>Event Name</th>
        <th>Date</th>
        <th>Status</th>
        <th>Payment</th>
        <th>Action</th>
      </tr>
      <c:forEach var="event" items="${upcomingEvents}">
        <tr>
          <td>${event.name}</td>
          <td>${event.date}</td>
          <td>
            <span class="badge ${event.status eq 'Confirmed' ? 'confirmed' : 'pending'}">
              ${event.status}
            </span>
          </td>
          <td>
            <span class="${event.payment eq 'Paid' ? 'paid' : 'unpaid'}">
              ${event.payment}
            </span>
          </td>
          <td><button class="action-btn">⋮</button></td>
        </tr>
      </c:forEach>
    </table>
  </div>
</div>
</body>
</html>
