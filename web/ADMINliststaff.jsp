<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
            margin: 0;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px 30px;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        h1 {
            font-size: 26px;
            margin-bottom: 20px;
            color: #1e293b;
        }

        .filters-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        .search-input, .filter-select {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background-color: #f9fafb;
        }

        .staff-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .staff-table th, .staff-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }

        .staff-table th {
            background-color: #f1f5f9;
            color: #334155;
            text-align: left;
        }

        .staff-table tr:hover {
            background-color: #f8fafc;
        }

        .status-active {
            color: #16a34a;
            font-weight: 600;
        }

        .status-inactive {
            color: #dc2626;
            font-weight: 600;
        }

        .change-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }

        .change-link:hover {
            text-decoration: underline;
        }

        .role-badge {
            background-color: #e2e8f0;
            color: #1e293b;
            padding: 4px 8px;
            font-size: 13px;
            border-radius: 4px;
        }

        .no-staff {
            text-align: center;
            color: #64748b;
            font-size: 16px;
            padding: 40px;
        }

        .staff-count {
            color: #475569;
            font-size: 14px;
            margin-bottom: 8px;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .filters-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<jsp:include page="admSidebar.jsp" />

<div class="main-content">
    <div class="container">
        <h1><i class="fas fa-user-tie"></i> Staff List</h1>

        <div class="filters-container">
            <input type="text" class="search-input" placeholder="Search staff..." id="searchInput" onkeyup="filterStaff()">

            <select class="filter-select" id="roleFilter" onchange="filterStaff()">
                <option value="">Role</option>
                <option value="HEP">HEP</option>
                <option value="HEA">HEA</option>
                <option value="Resources Department">Resources Department</option>
                <option value="Venue Department">Venue Department</option>
            </select>

            <select class="filter-select" id="statusFilter" onchange="filterStaff()">
                <option value="">Status</option>
                <option value="Active">Active</option>
                <option value="deactive">Inactive</option>
            </select>
        </div>

        <c:choose>
            <c:when test="${not empty staffList}">
                <div class="staff-count">
                    Total Staff: ${staffList.size()}
                </div>

                <table class="staff-table" id="staffTable">
                    <thead>
                        <tr>
                            <th>Staff ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="staff" items="${staffList}">
                        <tr>
                            <td>${staff.staffId}</td>
                            <td>${staff.name}</td>
                            <td><span class="role-badge">${staff.role}</span></td>
                            <td>${staff.email}</td>
                            <td>
                                <span class="${staff.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                    ${staff.status}
                                </span>
                            </td>
                            <td>
                                <a href="changeStaffStatus.jsp?id=${staff.staffId}" class="change-link">Change</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-staff">
                    <p>No staff members found.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function filterStaff() {
        var searchInput = document.getElementById("searchInput").value.toLowerCase();
        var roleFilter = document.getElementById("roleFilter").value;
        var statusFilter = document.getElementById("statusFilter").value;
        var table = document.getElementById("staffTable");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var cells = rows[i].getElementsByTagName("td");
            var staffId = cells[0].textContent.toLowerCase();
            var name = cells[1].textContent.toLowerCase();
            var role = cells[2].textContent.trim();
            var email = cells[3].textContent.toLowerCase();
            var status = cells[4].textContent.trim();

            var searchMatch = searchInput === "" || staffId.includes(searchInput) || name.includes(searchInput) || email.includes(searchInput);
            var roleMatch = roleFilter === "" || role === roleFilter;
            var statusMatch = statusFilter === "" || status === statusFilter;

            rows[i].style.display = (searchMatch && roleMatch && statusMatch) ? "" : "none";
        }
    }
</script>
</body>
</html>
