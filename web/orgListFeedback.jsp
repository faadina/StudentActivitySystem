<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="orgSidebar.jsp" />

<style>
  .main-content {
    padding: 40px;
    background-color: #f5f6fa;
    min-height: 100vh;
  }

  h1 {
    color: #4b2e83;
    margin-bottom: 30px;
  }

  .feedback-table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
    overflow: hidden;
  }

  .feedback-table th, .feedback-table td {
    padding: 16px;
    border-bottom: 1px solid #ddd;
    text-align: left;
  }

  .feedback-table th {
    background-color: #f0f0f0;
  }

  .feedback-table td {
    vertical-align: top;
  }

  .feedback-comment {
    color: #333;
    font-style: italic;
  }

  .rating-pill {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    color: white;
  }

  .Excellent { background-color: #2ecc71; }
  .Good { background-color: #3498db; }
  .Average { background-color: #f1c40f; }
  .Poor { background-color: #e74c3c; }
</style>

<div class="main-content">
  <h1>Student Feedback</h1>

  <c:choose>
    <c:when test="${not empty feedbackList}">
      <table class="feedback-table">
        <thead>
          <tr>
            <th>Event Name</th>
            <th>Experience</th>
            <th>Comment</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="fb" items="${feedbackList}">
            <tr>
              <td>${fb.eventName}</td>
              <td><span class="rating-pill ${fb.experienceRating}">${fb.experienceRating}</span></td>
              <td><div class="feedback-comment">${fb.comment}</div></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <p>No feedback submitted yet.</p>
    </c:otherwise>
  </c:choose>
</div>
