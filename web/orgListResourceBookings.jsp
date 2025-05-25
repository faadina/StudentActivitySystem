<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="orgSidebar.jsp" />

<c:if test="${statusUpdated}">
  <script>alert('Resource booking updated successfully!');</script>
</c:if>

<style>
  .main-content {
    flex-grow: 1;
    padding: 40px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 8px;
    overflow: hidden;
  }
  thead {
    background-color: #f0f0f0;
  }
  th, td {
    padding: 12px 16px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
  }
  td span {
    font-weight: bold;
  }
  button {
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
    margin-right: 5px;
  }
  .btn-approve {
    background-color: #4CAF50;
    color: white;
  }
  .btn-reject {
    background-color: #e74c3c;
    color: white;
  }
  .status-pending { color: orange; }
  .status-approved { color: green; }
  .status-rejected { color: red; }
</style>

<div class="main-content">
  <h1>Resource Booking List</h1>
  <c:choose>
    <c:when test="${not empty resourceList}">
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Duration</th>
            <th>Resource</th>
            <th>Quantity</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="res" items="${resourceList}">
            <tr>
              <td>${res.date}</td>
              <td>${res.time}</td>
              <td>${res.duration}</td>
              <td>${res.resourceName}</td>
              <td>${res.quantity}</td>
              <td>
                <c:choose>
                  <c:when test="${res.status == 'Approved'}">
                    <span class="status-approved">Approved</span>
                  </c:when>
                  <c:when test="${res.status == 'Rejected'}">
                    <span class="status-rejected">Rejected</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-pending">Pending</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <form action="StatusResourceServlet" method="post" style="display:inline;">
                  <input type="hidden" name="id" value="${res.id}" />
                  <button name="action" value="approve" class="btn-approve">Approve</button>
                  <button name="action" value="reject" class="btn-reject">Reject</button>
                </form>
                <c:if test="${res.status == 'Pending'}">
                  <a href="EditResourceBookingServlet?id=${res.id}"
                     style="background:#f39c12; color:white; padding:6px 12px; border-radius:6px; text-decoration:none; display:inline-block; margin-top:5px;">
                    Edit
                  </a>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <p>No resource bookings found.</p>
    </c:otherwise>
  </c:choose>
</div>