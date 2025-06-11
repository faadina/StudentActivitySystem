<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Event List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px 30px;
        }

        h1 {
            font-size: 26px;
            margin-bottom: 20px;
            color: #1e293b;
        }

        .filter-buttons {
            margin-bottom: 20px;
        }

        .filter-buttons button {
            background-color: #e2e8f0;
            color: #334155;
            border: none;
            padding: 8px 16px;
            margin-right: 8px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .filter-buttons button:hover {
            background-color: #cbd5e1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        thead {
            background-color: #f1f5f9;
        }

        th, td {
            padding: 16px;
            text-align: left;
            font-size: 14px;
            border-bottom: 1px solid #e2e8f0;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
        }

        .approved {
            background-color: #b2f2bb;
            color: #2f9e44;
        }

        .pending {
            background-color: #fff3bf;
            color: #f59f00;
        }

        .rejected {
            background-color: #ffc9c9;
            color: #c92a2a;
        }

        .action-btn {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: #64748b;
        }

        .action-btn:hover {
            color: #1e293b;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="adminSidebar.jsp"/>

<div class="main-content">
    <h1><i class="fas fa-calendar-alt"></i> Event List</h1>

    <div class="filter-buttons">
        <button>All</button>
        <button>Approve</button>
        <button>Reject</button>
        <button>Pending</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>Event Name</th>
                <th>Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="event" items="${eventList}">
            <tr>
                <td>${event.name}</td>
                <td>${event.date}</td>
                <td>
                    <c:choose>
                        <c:when test="${event.status == 'Approved'}">
                            <span class="status-badge approved">Approved</span>
                        </c:when>
                        <c:when test="${event.status == 'Pending'}">
                            <span class="status-badge pending">Pending</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge rejected">Rejected</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <button class="action-btn" title="More options">⋮</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
