<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Staff</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: white;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px 30px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(45deg, #8e44ad, #9b59b6);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        .form-container {
            padding: 30px;
            background: #f8f9fa;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #8e44ad;
            box-shadow: 0 0 5px rgba(142, 68, 173, 0.3);
        }

        .status-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .status-group label {
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 25px;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-back {
            background-color: #95a5a6;
            color: white;
        }

        .btn-back:hover {
            background-color: #7f8c8d;
        }

        .btn-update {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
        }

        .btn-update:hover {
            background: linear-gradient(45deg, #2980b9, #1f5f8b);
        }

        .error-message,
        .success-message {
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
        }

        .error-message {
            background-color: #e74c3c;
            color: white;
        }

        .success-message {
            background-color: #2ecc71;
            color: white;
        }

        @media (max-width: 600px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .button-group {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<jsp:include page="adminSidebar.jsp" />

<div class="main-content">
    <div class="container">
        <div class="header">
            <h1>Update Staff</h1>
        </div>

        <div class="form-container">
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success-message">${success}</div>
            </c:if>

            <form action="updateStaff" method="post">
                <div class="form-group">
                    <label for="staffId">Staff ID</label>
                    <input type="text" id="staffId" name="staffId" value="${staff.staffId}" readonly />
                </div>

                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" value="${staff.name}" required />
                </div>

                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="">Select Role</option>
                        <option value="HEA" <c:if test="${staff.role == 'HEA'}">selected</c:if>>HEA</option>
                        <option value="HEP" <c:if test="${staff.role == 'HEP'}">selected</c:if>>HEP</option>
                        <option value="STAFF" <c:if test="${staff.role == 'STAFF'}">selected</c:if>>STAFF</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${staff.email}" required />
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <div class="status-group">
                        <label><input type="radio" name="status" value="Active" <c:if test="${staff.status == 'Active'}">checked</c:if>> Active</label>
                        <label><input type="radio" name="status" value="Inactive" <c:if test="${staff.status == 'Inactive'}">checked</c:if>> Inactive</label>
                    </div>
                </div>

                <div class="button-group">
                    <a href="adminListStaff.jsp" class="btn btn-back">Back</a>
                    <button type="submit" class="btn btn-update">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
