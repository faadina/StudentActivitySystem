<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Form</title>
    <style>
        .feedback-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #f0f2f5;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }

        h1 {
            text-align: center;
            color: #4b2e83;
            font-size: 32px;
            font-weight: bold;
            text-shadow: 1px 1px #ccc;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-reset {
            background-color: #f8c471;
        }

        .btn-send {
            background-color: #f5b041;
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

<div class="main-content">
    <div class="feedback-container">
        <h1>FEEDBACK FORM</h1>
        <form action="SubmitFeedbackServlet" method="post">
            <input type="text" name="eventName" placeholder="Name Event" required>

            <select name="experienceRating" required>
                <option value="">Rate your experience</option>
                <option value="Excellent">Excellent</option>
                <option value="Good">Good</option>
                <option value="Average">Average</option>
                <option value="Poor">Poor</option>
            </select>

            <textarea name="comment" rows="5" placeholder="Leave your comment" required></textarea>

            <button type="reset" class="btn-reset">Reset</button>
            <button type="submit" class="btn-send">Send</button>
        </form>
    </div>
</div>
</body>
</html>
