<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="orgSidebar.jsp" />

<style>
  .main-content {
    padding: 40px;
    max-width: 800px;
    margin: auto;
  }
  .form-container {
    background-color: white;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  }
  form {
    display: grid;
    gap: 20px;
  }
  label {
    font-weight: bold;
  }
  input[type="text"],
  input[type="date"],
  input[type="time"],
  input[type="number"] {
    padding: 10px;
    width: 100%;
    border-radius: 6px;
    border: 1px solid #ccc;
  }
  button {
    background-color: #0047b3;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    float: right;
  }
  button:hover {
    background-color: #003580;
  }
</style>

<div class="main-content">
  <h1>Edit Resource Booking</h1>
  <div class="form-container">
    <form action="UpdateResourceBookingServlet" method="post">
      <input type="hidden" name="id" value="${res.id}" />

      <label for="date">Date</label>
      <input type="date" name="date" id="date" value="${res.date}" required />

      <label for="duration">Duration</label>
      <input type="text" name="duration" id="duration" value="${res.duration}" required />

      <label for="time">Time</label>
      <input type="time" name="time" id="time" value="${res.time}" required />

      <label for="resourceName">Resource Name</label>
      <input type="text" name="resourceName" id="resourceName" value="${res.resourceName}" required />

      <label for="quantity">Quantity</label>
      <input type="number" name="quantity" id="quantity" value="${res.quantity}" min="1" required />

      <div style="display: flex; justify-content: space-between;">
        <a href="ListResourceServlet"
           style="background-color: #ccc; color: black; padding: 12px 20px; text-decoration: none;
                  border-radius: 6px; font-weight: bold;">
           Cancel
        </a>

        <button type="submit" style="background-color: #0047b3; color: white;">Update</button>
      </div>

    </form>
  </div>
</div>
