<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Create Event</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, sans-serif;
      background-color: #f9f9fb;
    }

    .main-content {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      padding: 30px;
      min-height: 100vh;
    }

    .form-container {
      background: white;
      padding: 30px;
      border-radius: 12px;
      max-width: 1000px;
      width: 100%;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
    }

    form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    form label {
      font-weight: bold;
      margin-bottom: 5px;
      display: block;
    }

    form input[type="text"],
    form input[type="date"],
    form input[type="time"],
    form input[type="number"],
    form textarea,
    form select {
      width: 100%;
      padding: 8px;
      border-radius: 5px;
      border: 1px solid #ccc;
      box-sizing: border-box;
    }

    form textarea {
      resize: vertical;
      min-height: 80px;
    }

    .full-width {
      grid-column: span 2;
    }

    .switch-group {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .file-upload {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .submit-btn {
      grid-column: span 2;
      justify-self: end;
    }

    .submit-btn button {
      padding: 10px 20px;
      background-color: #0052cc;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
    }

    .submit-btn button:hover {
      background-color: #003e99;
    }

    .toggle-btn {
      padding: 8px 20px;
      border: none;
      border-radius: 20px;
      background-color: #ddd;
      cursor: pointer;
    }

    .toggle-btn.active {
      background-color: #4b2e83;
      color: white;
    }
  </style>

  <script>
    function toggleDepartment(selected) {
      document.getElementById("HEA").classList.remove("active");
      document.getElementById("HEP").classList.remove("active");
      document.getElementById(selected).classList.add("active");
      document.getElementById("dept").value = selected;
    }
  </script>
</head>
<body>

  <jsp:include page="orgSidebar.jsp" />
  <div class="main-content">
    <h1>Create Event</h1>

    <div class="form-container">
      <form action="CreateEventServlet" method="post" enctype="multipart/form-data">
        <div class="full-width">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" required />
        </div>

        <div>
          <label for="date">Date</label>
          <input type="date" id="date" name="date" required />
        </div>

        <div>
          <label for="time">Time</label>
          <input type="time" id="time" name="time" required />
        </div>

        <div class="full-width">
          <label for="description">Description</label>
          <textarea id="description" name="description" required></textarea>
        </div>

        <div>
          <label for="participants">Participant Needed</label>
          <input type="number" id="participants" name="participants" required />
        </div>

        <div>
          <label for="category">Category</label>
          <select id="category" name="category" required>
            <option value="Sports">Sports</option>
            <option value="Education">Education</option>
            <option value="Community">Community</option>
            <option value="Cultural">Cultural</option>
          </select>
        </div>

        <div>
          <label for="fee">Registration Fee</label>
          <input type="number" id="fee" name="fee" step="0.01" />
        </div>

        <div>
          <label>To Department</label>
          <div class="switch-group">
            <button type="button" id="HEA" class="toggle-btn active" onclick="toggleDepartment('HEA')">HEA</button>
            <button type="button" id="HEP" class="toggle-btn" onclick="toggleDepartment('HEP')">HEP</button>
          </div>
          <input type="hidden" id="dept" name="department" value="HEA" />
        </div>

        <div class="full-width">
          <label for="paperwork">Paperwork <small>(PDF only, max 2MB)</small></label>
          <div class="file-upload">
            <input type="file" id="paperwork" name="paperwork" accept=".pdf" required />
          </div>
        </div>

        <div class="submit-btn">
          <button type="submit">Submit</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
