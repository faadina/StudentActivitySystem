<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <style>
      body {
          margin: 0;
          font-family: Arial, sans-serif;
          background-color: #f8fafc;
          color: #334155;
      }

      .main-content {
          margin-left: 220px;
          padding: 2rem;
      }

      h1 {
          font-size: 2rem;
          margin-bottom: 2rem;
      }

      .metrics-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 1.5rem;
      }

      .metric-card {
          background: white;
          border-radius: 8px;
          padding: 1.5rem;
          box-shadow: 0 1px 3px rgba(0,0,0,0.1);
          border-left: 5px solid;
      }

      .metric-card.active { border-color: #3b82f6; }
      .metric-card.registrations { border-color: #10b981; }
      .metric-card.pending { border-color: #f59e0b; }
      .metric-card.certificates { border-color: #ef4444; }

      .metric-number {
          font-size: 2rem;
          font-weight: bold;
      }

      .metric-label {
          font-size: 0.875rem;
          color: #64748b;
      }

      .section-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin: 2rem 0 1rem;
      }

      .table-container {
          background: white;
          border-radius: 8px;
          overflow: hidden;
          box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      }

      table {
          width: 100%;
          border-collapse: collapse;
      }

      th, td {
          padding: 1rem;
          text-align: left;
          border-bottom: 1px solid #e2e8f0;
      }

      th {
          background-color: #f1f5f9;
      }

      .action-buttons button {
          margin-right: 0.5rem;
          padding: 6px 12px;
          border: none;
          border-radius: 4px;
          font-size: 0.75rem;
          cursor: pointer;
      }

      .btn-approve {
          background-color: #10b981;
          color: white;
      }

      .btn-reject {
          background-color: #ef4444;
          color: white;
      }

      .btn-view {
          background-color: #3b82f6;
          color: white;
      }

      .status-badge {
          display: inline-block;
          padding: 0.25rem 0.75rem;
          border-radius: 9999px;
          font-size: 0.75rem;
          font-weight: 600;
          background-color: #fef3c7;
          color: #92400e;
      }
  </style>
</head>
<body>

<jsp:include page="adminSidebar.jsp" />

<div class="main-content">
    <h1>Welcome, ${adminName}!</h1>

    <div class="metrics-grid">
        <div class="metric-card active">
            <div class="metric-number">${activeCount}</div>
            <div class="metric-label">Active Events</div>
        </div>
        <div class="metric-card registrations">
            <div class="metric-number">${registrationCount}</div>
            <div class="metric-label">Event Registrations</div>
        </div>
        <div class="metric-card pending">
            <div class="metric-number">${pendingCount}</div>
            <div class="metric-label">Pending Approvals</div>
        </div>
        <div class="metric-card certificates">
            <div class="metric-number">${certificatesIssued}</div>
            <div class="metric-label">Certificates Issued</div>
        </div>
    </div>

    <div class="section-header">
        <h2>Pending Approvals</h2>
        <div>
            <button class="btn-view"><i class="fas fa-sync-alt"></i> Refresh</button>
        </div>
    </div>

    <c:if test="${not empty pendingList}">
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Event</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${pendingList}">
                        <tr>
                            <td>
                                <strong>${item.studentId}</strong><br/>
                                <small>${item.studentName}</small>
                            </td>
                            <td>${item.eventName}</td>
                            <td>${item.registrationDate}</td>
                            <td><span class="status-badge">Pending</span></td>
                            <td class="action-buttons">
                                <button class="btn-approve" onclick="approveStudent(this)">Approve</button>
                                <button class="btn-reject" onclick="rejectStudent(this)">Reject</button>
                                <button class="btn-view" onclick="viewStudent(this)">View</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>

<script>
    function approveStudent(button) {
        const row = button.closest('tr');
        const badge = row.querySelector('.status-badge');
        const actions = row.querySelector('.action-buttons');

        badge.textContent = 'Approved';
        badge.style.backgroundColor = '#dcfce7';
        badge.style.color = '#166534';

        actions.innerHTML = '<span style="color:#10b981;font-weight:bold;">✓ Approved</span>';
    }

    function rejectStudent(button) {
        const row = button.closest('tr');
        const badge = row.querySelector('.status-badge');
        const actions = row.querySelector('.action-buttons');

        badge.textContent = 'Rejected';
        badge.style.backgroundColor = '#fecaca';
        badge.style.color = '#991b1b';

        actions.innerHTML = '<span style="color:#ef4444;font-weight:bold;">✗ Rejected</span>';
    }

    function viewStudent(button) {
        const row = button.closest('tr');
        const name = row.querySelector('small').textContent;
        const event = row.children[1].textContent;
        alert(`Student: ${name}\nEvent: ${event}`);
    }
</script>

</body>
</html>
