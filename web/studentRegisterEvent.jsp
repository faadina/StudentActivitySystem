<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Payment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            overflow-x: hidden; 
            overflow-y: auto;   
            height: 100%;
        }

        .main-content {
            padding: 40px;
            max-width: 900px;
            margin: 0 auto;
            box-sizing: border-box;
            min-height: 100vh; 
}

        .payment-card {
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.08);
        }

        h1 {
            color: #4b2e83;
            font-size: 24px;
            margin-bottom: 30px;
        }

        .step {
            margin-bottom: 30px;
        }

        .step-number {
            background-color: #3498db;
            color: white;
            border-radius: 50%;
            display: inline-block;
            width: 28px;
            height: 28px;
            text-align: center;
            line-height: 28px;
            font-weight: bold;
            margin-right: 10px;
        }

        .step-title {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .info-box {
            background-color: #f1f5f9;
            border: 1px solid #e1e8ed;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .info-label {
            font-weight: 500;
            color: #2c3e50;
        }

        .info-value {
            color: #7f8c8d;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: 500;
        }

        input[type="date"],
        input[type="text"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        .submit-btn {
            margin-top: 30px;
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #2d7fbf;
        }
    </style>
</head>
<body>
<jsp:include page="studentSidebar.jsp" />

<div class="main-content">
    <div class="payment-card">
        <h1>Submit Payment for <c:out value="${event.title}" /></h1>

        <!-- Step 1: Payment Info -->
        <div class="step">
            <div class="step-title"><span class="step-number">1</span> Payment Information</div>
            <div class="info-box">
                <div class="info-row">
                    <div class="info-label">Event:</div>
                    <div class="info-value"><c:out value="${event.title}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Amount:</div>
                    <div class="info-value">RM <c:out value="${event.fee}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Registration ID:</div>
                    <div class="info-value"><c:out value="${registrationId}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Payment Status:</div>
                    <div class="info-value" style="color:#e74c3c;">Pending</div>
                </div>
            </div>
        </div>

        <!-- Step 2: Bank Info -->
        <div class="step">
            <div class="step-title"><span class="step-number">2</span> Bank Transfer Details</div>
            <div class="info-box">
                <div class="info-row">
                    <div class="info-label">Bank Name:</div>
                    <div class="info-value"><c:out value="${event.bankName}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Account Number:</div>
                    <div class="info-value"><c:out value="${event.accountNumber}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Account Holder:</div>
                    <div class="info-value"><c:out value="${event.accountHolder}" /></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Reference:</div>
                    <div class="info-value"><c:out value="${event.reference}" /></div>
                </div>
            </div>
            <p style="font-size: 13px; color: #7f8c8d;">Include the registration ID in the payment reference.</p>
        </div>

        <!-- Step 3: Upload Proof -->
        <form action="SubmitPaymentServlet" method="post" enctype="multipart/form-data">
            <div class="step">
                <div class="step-title"><span class="step-number">3</span> Upload Payment Proof</div>

                <label for="paymentDate">Payment Date</label>
                <input type="date" id="paymentDate" name="paymentDate" required>

                <label for="transactionId">Transaction ID / Reference</label>
                <input type="text" id="transactionId" name="transactionId" placeholder="e.g. MB123456789" required>

                <label for="receipt">Upload Receipt</label>
                <input type="file" id="receipt" name="receipt" accept=".pdf,.jpg,.jpeg,.png" required>

                <input type="hidden" name="eventId" value="${event.id}" />
                <input type="hidden" name="registrationId" value="${registrationId}" />

                <button type="submit" class="submit-btn">Submit Payment Proof</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
