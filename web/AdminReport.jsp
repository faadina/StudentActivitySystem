<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Report</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px 30px;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 26px;
        }

        .search-container {
            text-align: left;
            margin-bottom: 20px;
        }

        .search-input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
            font-size: 14px;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .report-table th {
            background-color: #f8f9fa;
            color: #444;
            font-weight: 600;
            padding: 12px 15px;
            text-align: left;
            border-bottom: 2px solid #ddd;
            font-size: 14px;
        }

        .report-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }

        .report-table tr:hover {
            background-color: #f1f5f9;
        }

        .view-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }

        .view-link:hover {
            text-decoration: underline;
        }

        .no-reports {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }

        .report-count {
            margin-bottom: 10px;
            color: #666;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .search-input {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="admSidebar.jsp"/>

    <div class="main-content">
        <h1><i class="fas fa-file-alt"></i> List Report</h1>

        <div class="search-container">
            <input type="text" class="search-input" placeholder="Search Report" 
                   id="searchInput" onkeyup="searchReports()">
        </div>

        <c:choose>
            <c:when test="${not empty reportList}">
                <div class="report-count">
                    Total Reports: ${reportList.size()}
                </div>

                <table class="report-table" id="reportTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Report ID</th>
                            <th>Name</th>
                            <th>Action</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="report" items="${reportList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${report.reportId}</td>
                                <td>${report.name}</td>
                                <td>
                                    <a href="viewReport.jsp?id=${report.reportId}" class="view-link">View</a>
                                </td>
                                <td>
                                    <fmt:formatDate value="${report.dateCreated}" pattern="dd.MM.yyyy"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-reports">
                    <p>No reports available at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function searchReports() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("reportTable");
            var rows = table.getElementsByTagName("tr");

            for (var i = 1; i < rows.length; i++) {
                var cells = rows[i].getElementsByTagName("td");
                var found = false;

                for (var j = 0; j < cells.length; j++) {
                    var cellText = cells[j].textContent || cells[j].innerText;
                    if (cellText.toLowerCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }

                rows[i].style.display = found ? "" : "none";
            }
        }
    </script>
</body>
</html>
