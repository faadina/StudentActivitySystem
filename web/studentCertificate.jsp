<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Certificates</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .main-content {
            padding: 30px;
        }

        h1 {
            color: #4b2e83;
            margin-left: 30px;
        }

        .certificates-box {
            background-color: white;
            margin: 20px 30px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .search-input {
            width: 95%;
            padding: 10px 15px;
            margin-bottom: 30px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .certificate-card {
            max-width: 700px;
            margin: 0 auto;
            border: 1px solid #ccc;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .certificate-card h4 {
            margin: 0;
            font-size: 16px;
            color: #555;
        }

        .certificate-card h2 {
            font-size: 28px;
            color: #4b2e83;
            margin: 10px 0;
        }

        .certificate-card h3 {
            font-size: 18px;
            color: #666;
            margin-bottom: 20px;
        }

        .certificate-card .name {
            font-weight: bold;
            font-size: 22px;
            margin: 15px 0;
        }

        .certificate-card .description {
            font-size: 16px;
            margin-bottom: 30px;
        }

        .certificate-card .date {
            margin-top: 30px;
            font-style: italic;
            color: #333;
        }

        .download-btn {
            float: right;
            font-size: 20px;
            background: none;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="studentSidebar.jsp" />

<div class="main-content">
    <h1>Certificates</h1>

    <div class="certificates-box">
        <input type="text" id="searchInput" class="search-input" placeholder="Search certificates..." onkeyup="filterCertificates()"/>

        <c:forEach var="cert" items="${certificates}" varStatus="loop">
            <div class="certificate-card cert-item" data-title="${cert.title}">
                <h4>Certificate of Achievement</h4>
                <h2>${cert.title}</h2>
                <h3>${cert.subtitle}</h3>
                <p>This certificate is awarded to</p>
                <div class="name">${cert.recipient}</div>
                <p class="description">for their outstanding participation and contribution</p>
                <div class="date">Date: ${cert.date}</div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    function filterCertificates() {
        const input = document.getElementById("searchInput").value.toLowerCase();
        const items = document.querySelectorAll(".cert-item");

        items.forEach(item => {
            const title = item.getAttribute("data-title").toLowerCase();
            item.style.display = title.includes(input) ? "block" : "none";
        });
    }
</script>
</body>
</html>
