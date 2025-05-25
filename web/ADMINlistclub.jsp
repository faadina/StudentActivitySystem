<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Club List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f8fafc;
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

        .club-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .club-table th, .club-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }

        .club-table th {
            background-color: #f1f5f9;
            color: #334155;
            text-align: left;
        }

        .club-table tr:hover {
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

        .action-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            margin-right: 10px;
        }

        .action-link:hover {
            text-decoration: underline;
        }

        .no-clubs {
            text-align: center;
            color: #64748b;
            font-size: 16px;
            padding: 40px;
        }

        .club-count {
            color: #475569;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .category-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .category-sports { background-color: #d4edda; color: #155724; }
        .category-academic { background-color: #d1ecf1; color: #0c5460; }
        .category-cultural { background-color: #f8d7da; color: #721c24; }
        .category-social { background-color: #fff3cd; color: #856404; }
        .category-technology { background-color: #e0f7fa; color: #006064; }

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

<jsp:include page="admSidebar.jsp"/>

<div class="main-content">
    <div class="container">
        <h1><i class="fas fa-users"></i> Club List</h1>

        <div class="filters-container">
            <input type="text" class="search-input" placeholder="Search by name or ID..." 
                   id="searchInput" onkeyup="filterClubs()">

            <select class="filter-select" id="categoryFilter" onchange="filterClubs()">
                <option value="">Category</option>
                <option value="Sports">Sports</option>
                <option value="Academic">Academic</option>
                <option value="Cultural">Cultural</option>
                <option value="Social">Social</option>
                <option value="Technology">Technology</option>
            </select>

            <select class="filter-select" id="statusFilter" onchange="filterClubs()">
                <option value="">Status</option>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
        </div>

        <c:choose>
            <c:when test="${not empty clubList}">
                <div class="club-count">
                    Total Clubs: ${clubList.size()}
                </div>

                <table class="club-table" id="clubTable">
                    <thead>
                        <tr>
                            <th>Club ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="club" items="${clubList}">
                            <tr>
                                <td>${club.clubId}</td>
                                <td>${club.name}</td>
                                <td>
                                    <span class="category-badge category-${club.category.toLowerCase()}">
                                        ${club.category}
                                    </span>
                                </td>
                                <td>
                                    <span class="${club.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                        ${club.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="viewClub.jsp?id=${club.clubId}" class="action-link">View</a>
                                    <a href="editClub.jsp?id=${club.clubId}" class="action-link">Edit</a>
                                    <c:if test="${club.status == 'Active'}">
                                        <a href="deactivateClub.jsp?id=${club.clubId}" class="action-link">Deactivate</a>
                                    </c:if>
                                    <c:if test="${club.status == 'Inactive'}">
                                        <a href="activateClub.jsp?id=${club.clubId}" class="action-link">Activate</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-clubs">
                    <p>No clubs found.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function filterClubs() {
        const searchInput = document.getElementById("searchInput").value.toLowerCase();
        const categoryFilter = document.getElementById("categoryFilter").value;
        const statusFilter = document.getElementById("statusFilter").value;
        const rows = document.querySelectorAll("#clubTable tbody tr");

        rows.forEach(row => {
            const clubId = row.children[0].textContent.toLowerCase();
            const name = row.children[1].textContent.toLowerCase();
            const category = row.children[2].textContent.trim();
            const status = row.children[3].textContent.trim();

            const matchSearch = !searchInput || clubId.includes(searchInput) || name.includes(searchInput);
            const matchCategory = !categoryFilter || category === categoryFilter;
            const matchStatus = !statusFilter || status === statusFilter;

            row.style.display = (matchSearch && matchCategory && matchStatus) ? "" : "none";
        });
    }
</script>

</body>
</html>
