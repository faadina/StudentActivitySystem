<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Registered Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="studentSidebar.jsp"><jsp:param name="active" value="myEvents"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <h2 class="mb-4">My Registered Events</h2>
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Event Title</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty myRegistrations}">
                                <tr>
                                    <td colspan="4" class="text-center">You have not registered for any events.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="reg" items="${myRegistrations}">
                                <tr>
                                    <td>${reg.eventTitle}</td>
                                    <td><fmt:formatDate value="${reg.eventDate}" pattern="dd MMM yyyy"/></td>
                                    <td><span class="badge bg-primary">${reg.status}</span></td>
                                    <td>
                                        <a href="student?action=viewEvent&eventId=${reg.eventID}" class="btn btn-sm btn-info">View</a>
                                        <c:if test="${reg.status == 'registered'}">
                                            <form action="student" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel your registration?');">
                                                <input type="hidden" name="action" value="cancelRegistration">
                                                <input type="hidden" name="eventId" value="${reg.eventID}">
                                                <button type="submit" class="btn btn-sm btn-danger">Cancel</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>