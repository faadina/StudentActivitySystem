<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }
        .main-content {
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
            box-sizing: border-box;
        }
        h1 {
            color: #4b2e83;
            font-size: 28px;
            margin-bottom: 25px;
        }
        .feedback-box {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input, select, textarea {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }
        textarea {
            resize: vertical;
            height: 120px;
        }
        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }
        .btn-reset, .btn-send {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-reset {
            background-color: #f8c471;
            color: black;
        }
        .btn-send {
            background-color: #f5b041;
            color: white;
        }
        .btn-reset:hover {
            background-color: #f5b041;
        }
        .btn-send:hover {
            background-color: #e67e22;
        }
    </style>
</head>
<body>
<jsp:include page="studentSidebar.jsp"/>

<c:if test="${feedbackSuccess}">
    <script>alert('Thank you! Your feedback has been submitted.');</script>
</c:if>

<div class="main-content">
    <h1>Feedback Form</h1>

    <div class="feedback-box">
        <form action="SubmitFeedbackServlet" method="post">
            <select name="eventName" required>
                <option value="">Select an event</option>
                <c:forEach var="event" items="${eventList}">
                    <option value="${event.name}">${event.name}</option>
                </c:forEach>
            </select>

            <select name="experienceRating" required>
                <option value="">Rate your experience</option>
                <option value="Excellent">Excellent</option>
                <option value="Good">Good</option>
                <option value="Average">Average</option>
                <option value="Poor">Poor</option>
            </select>

            <textarea name="comment" placeholder="Leave your comment..." required></textarea>

            <div class="button-group">
                <button type="reset" class="btn-reset">Reset</button>
                <button type="submit" class="btn-send">Send</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
