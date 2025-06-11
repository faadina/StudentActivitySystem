<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        display: flex;
        height: 100vh;
        overflow: hidden;
        background-color: #f5f6fa;
    }

    .sidebar {
        background-color: #4b2e83;
        color: white;
        width: 220px;
        min-width: 220px;
        max-width: 250px;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 20px;
        box-sizing: border-box;
    }

    .sidebar .logo {
        display: block;
        width: 180px;
        margin: 10px auto 20px;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }

    .sidebar ul li a {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        text-decoration: none;
        color: white;
        border-radius: 4px;
        cursor: pointer;
    }

    .sidebar ul li a:hover {
        background-color: #321b5c;
    }

    .sidebar .bottom-links {
        padding-top: 20px;
        border-top: 1px solid #6c5b7b;
    }

    .main-content {
        flex-grow: 1;
        padding: 30px;
        overflow-y: auto;
    }

    h1 {
        color: #4b2e83;
    }

    .submenu {
        display: none;
        margin-left: 15px;
    }

    .submenu li a {
        padding: 8px 10px;
        font-size: 14px;
    }

    .arrow {
        font-size: 12px;
    }
</style>

<script>
    function toggleSubmenu(id, arrowId) {
        const submenu = document.getElementById(id);
        const arrow = document.getElementById(arrowId);
        if (submenu.style.display === "block") {
            submenu.style.display = "none";
            arrow.innerHTML = "▶";
        } else {
            submenu.style.display = "block";
            arrow.innerHTML = "▼";
        }
    }
</script>

<div class="sidebar">
  <div>
    <img class="logo" src="images/Logo UiTM- WHITE.png" alt="UiTM Logo" />
    <ul>
      <li><a href="orgDashboard.jsp">Dashboard</a></li>
      <li><a href="Aprofile.jsp">Profile</a></li>
      <li><a href="orgListEvent.jsp">List Events</a></li>
      <li><a href="orgCreateEvent.jsp">Create Event</a></li>
      <li><a href="ListParticipantsServlet">List Participant</a></li>
      <li><a href="CertificatesServlet">Certificates</a></li>
      <li><a href="orgListFeedback.jsp">Feedback</a></li>
      <li><a href="ReportsServlet">Report</a></li>

      <!-- Venue Section -->
      <li>
        <a onclick="toggleSubmenu('venueSub', 'venueArrow')">
          Venue Department <span id="venueArrow" class="arrow">▶</span>
        </a>
      </li>
      <ul class="submenu" id="venueSub">
        <li><a href="VenueListServlet">List Venue</a></li>
        <li><a href="VenueBookingForm.jsp">Form Booking</a></li>
      </ul>

      <!-- Resources Section -->
      <li>
        <a onclick="toggleSubmenu('resourceSub', 'resourceArrow')">
          Resources Department <span id="resourceArrow" class="arrow">▶</span>
        </a>
      </li>
      <ul class="submenu" id="resourceSub">
        <li><a href="orgListResourceBookings.jsp">List Resources</a></li>
        <li><a href="orgBookResources.jsp">Form Booking</a></li>
      </ul>
    </ul>
  </div>
  <div class="bottom-links">
    <a href="signoutController" style="color:white; text-decoration:none; display:block; padding:10px;">Logout</a>
  </div>
</div>
