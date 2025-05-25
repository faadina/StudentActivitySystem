<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Resource Booking</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f6fa;
      display: flex;
    }

    .main-content {
      flex-grow: 1;
      padding: 40px 60px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    h1 {
      font-size: 28px;
      color: #4b2e83;
      margin-bottom: 30px;
    }

    .form-container {
      background-color: #ffffff;
      padding: 30px 40px;
      border-radius: 12px;
      width: 100%;
      max-width: 700px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    label {
      font-weight: 600;
      color: #333;
      display: block;
      margin-bottom: 6px;
    }

    input[type="text"],
    input[type="date"],
    input[type="time"],
    input[type="number"] {
      padding: 10px;
      font-size: 14px;
      border-radius: 6px;
      border: 1px solid #ccc;
      width: 100%;
      box-sizing: border-box;
    }

    .full-width {
      grid-column: span 2;
    }

    .submit-btn {
      grid-column: span 2;
      text-align: right;
      margin-top: 10px;
    }

    .submit-btn button {
      background-color: #0047b3;
      color: white;
      padding: 12px 24px;
      border: none;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .submit-btn button:hover {
      background-color: #003580;
    }
  </style>
</head>
<body>

<jsp:include page="orgSidebar.jsp" />

<div class="main-content">
  <h1>Resource Booking</h1>
  <div class="form-container">
    <form action="BookResourceServlet" method="post">
      <div class="full-width">
        <label for="date">Date</label>
        <input type="date" id="date" name="date" required />
      </div>

      <div>
        <label for="duration">Duration</label>
        <input type="text" id="duration" name="duration" placeholder="e.g., 2 hours" required />
      </div>

      <div>
        <label for="time">Time</label>
        <input type="time" id="time" name="time" required />
      </div>

      <div class="full-width">
        <label for="resourceName">Resource Name</label>
        <input type="text" id="resourceName" name="resourceName" placeholder="e.g., Projector" required />
      </div>

      <div class="full-width">
        <label for="quantity">Resource Quantity</label>
        <input type="number" id="quantity" name="quantity" min="1" required />
      </div>

      <div class="submit-btn">
        <button type="submit">Submit</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
