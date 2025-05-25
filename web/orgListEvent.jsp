<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="orgSidebar.jsp"/>

<div class="main-content">
    <h1>List Event</h1>

    <div style="margin-bottom: 20px;">
        <label>Sort:</label>
        <button>All</button>
        <button>Approve</button>
        <button>Reject</button>
        <button>Pending</button>
    </div>

    <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 8px;">
        <thead style="background-color: #f0f0f0;">
            <tr>
                <th style="padding: 12px;">Event Name</th>
                <th>Date</th>
                <th>Status</th>
                <th>Department</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="event" items="${eventList}">
            <tr>
                <td style="padding: 12px;">${event.name}</td>
                <td>${event.date}</td>
                <td>
                    <c:choose>
                        <c:when test="${event.status == 'Approved'}">
                            <span style="background-color: #b2f2bb; color: #2f9e44; padding: 5px 10px; border-radius: 8px;">Approved</span>
                        </c:when>
                        <c:when test="${event.status == 'Pending'}">
                            <span style="background-color: #fff3bf; color: #f59f00; padding: 5px 10px; border-radius: 8px;">Pending</span>
                        </c:when>
                        <c:otherwise>
                            <span style="background-color: #ffc9c9; color: #c92a2a; padding: 5px 10px; border-radius: 8px;">Reject</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${event.department}</td>
                <td><button style="background: none; border: none;">⋮</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
