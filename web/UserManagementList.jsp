<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
        }

        .main-content {
            margin-left: 220px;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            letter-spacing: 1px;
        }

        .cards-container {
            display: flex;
            gap: 40px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card {
            background: linear-gradient(135deg, #c8a2c8 0%, #b39bc8 100%);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            min-width: 280px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .card h2 {
            font-size: 36px;
            font-weight: bold;
            color: #4a4a4a;
            margin-bottom: 25px;
            letter-spacing: 2px;
        }

        .view-btn {
            background: #6a1b9a;
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .view-btn:hover {
            background: #4a148c;
            transform: scale(1.05);
        }

        .view-btn:active {
            transform: scale(0.98);
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .container {
                padding: 20px;
            }

            .cards-container {
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }

            .card {
                width: 100%;
                max-width: 300px;
            }

            .header h1 {
                font-size: 24px;
            }

            .card h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="admSidebar.jsp" />

<div class="main-content">
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-users-cog"></i> USER MANAGEMENT</h1>
        </div>

        <div class="cards-container">
            <div class="card" onclick="location.href='ADMINliststaff.jsp'">
                <h2>STAFF</h2>
                <button class="view-btn" type="button">VIEW</button>
            </div>

            <div class="card" onclick="location.href='ADMINlistclub.jsp'">
                <h2>CLUB</h2>
                <button class="view-btn" type="button">VIEW</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
