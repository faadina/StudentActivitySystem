<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - UiTM Activity System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .payment-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .payment-header {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .payment-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .event-summary {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .price-breakdown {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .payment-methods {
            margin-bottom: 30px;
        }
        
        .payment-option {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-option:hover {
            border-color: #3498db;
            background: rgba(52, 152, 219, 0.05);
        }
        
        .payment-option.selected {
            border-color: #3498db;
            background: rgba(52, 152, 219, 0.1);
        }
        
        .payment-option input[type="radio"] {
            display: none;
        }
        
        .payment-icon {
            width: 60px;
            height: 40px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }
        
        .bank-transfer-details {
            background: #e8f4f8;
            border: 1px solid #bee5eb;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            display: none;
        }
        
        .bank-info {
            background: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
        }
        
        .upload-section {
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            margin-top: 20px;
        }
        
        .upload-section.dragover {
            border-color: #3498db;
            background: rgba(52, 152, 219, 0.05);
        }
        
        .btn-payment {
            background: linear-gradient(45deg, #27ae60, #229954);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-payment:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(39, 174, 96, 0.3);
            color: white;
        }
        
        .btn-back {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            color: #27ae60;
            font-size: 0.9rem;
            margin-top: 15px;
        }
        
        .progress-steps {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .step {
            display: flex;
            align-items: center;
            margin: 0 20px;
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 10px;
        }
        
        .step.active .step-number {
            background: #3498db;
            color: white;
        }
        
        .step.completed .step-number {
            background: #27ae60;
            color: white;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .payment-option {
                flex-direction: column;
                text-align: center;
            }
            
            .payment-icon {
                margin-right: 0;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="studentSidebar.jsp" />
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Mobile Menu Button -->
        <button class="btn btn-primary d-md-none mb-3" type="button" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <div class="payment-container">
            <!-- Payment Header -->
            <div class="payment-header">
                <h2 class="mb-3">
                    <i class="fas fa-credit-card me-2 text-primary"></i>
                    Complete Your Registration
                </h2>
                <p class="text-muted mb-0">Secure payment for ${event.eventTitle}</p>
            </div>
            
            <!-- Progress Steps -->
            <div class="progress-steps">
                <div class="step completed">
                    <div class="step-number">1</div>
                    <span>Event Selection</span>
                </div>
                <div class="step active">
                    <div class="step-number">2</div>
                    <span>Payment</span>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <span>Confirmation</span>
                </div>
            </div>
            
            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Event Summary -->
            <div class="event-summary">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h4 class="mb-2">${event.eventTitle}</h4>
                        <p class="mb-1 opacity-75">
                            <i class="fas fa-calendar me-2"></i>
                            <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy"/>
                        </p>
                        <p class="mb-0 opacity-75">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            ${event.eventLocation}
                        </p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <div class="h3 mb-0">RM ${event.registrationFee}</div>
                        <small class="opacity-75">Registration Fee</small>
                    </div>
                </div>
            </div>
            
            <!-- Payment Form -->
            <form id="paymentForm" method="POST" action="student" enctype="multipart/form-data">
                <input type="hidden" name="action" value="processPayment">
                <input type="hidden" name="eventId" value="${event.eventId}">
                
                <div class="payment-card">
                    <!-- Price Breakdown -->
                    <div class="price-breakdown">
                        <h5 class="mb-3">Payment Summary</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Registration Fee:</span>
                            <span>RM ${event.registrationFee}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Processing Fee:</span>
                            <span>RM 2.00</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between h5">
                            <strong>Total Amount:</strong>
                            <strong>RM <span id="totalAmount">${event.registrationFee + 2}</span></strong>
                        </div>
                    </div>
                    
                    <!-- Payment Methods -->
                    <div class="payment-methods">
                        <h5 class="mb-3">Select Payment Method</h5>
                        
                        <!-- Bank Transfer -->
                        <div class="payment-option" onclick="selectPaymentMethod('bank_transfer')">
                            <input type="radio" name="paymentMethod" value="bank_transfer" id="bank_transfer">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon">
                                    <i class="fas fa-university text-primary"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">Bank Transfer</h6>
                                    <small class="text-muted">Transfer directly to university account</small>
                                </div>
                                <div class="ms-auto">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Online Banking -->
                        <div class="payment-option" onclick="selectPaymentMethod('online_banking')">
                            <input type="radio" name="paymentMethod" value="online_banking" id="online_banking">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon">
                                    <i class="fas fa-globe text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">Online Banking</h6>
                                    <small class="text-muted">Pay using your online banking</small>
                                </div>
                                <div class="ms-auto">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- E-Wallet -->
                        <div class="payment-option" onclick="selectPaymentMethod('ewallet')">
                            <input type="radio" name="paymentMethod" value="ewallet" id="ewallet">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon">
                                    <i class="fas fa-mobile-alt text-info"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">E-Wallet</h6>
                                    <small class="text-muted">GrabPay, TouchNGo, Boost</small>
                                </div>
                                <div class="ms-auto">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Bank Transfer Details -->
                    <div class="bank-transfer-details" id="bankTransferDetails">
                        <h6 class="mb-3">
                            <i class="fas fa-university me-2"></i>
                            Bank Transfer Details
                        </h6>
                        <p class="text-muted mb-3">
                            Please transfer the exact amount to the following account and upload your payment receipt.
                        </p>
                        
                        <div class="bank-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Bank Name:</strong><br>
                                    Maybank Islamic Berhad
                                </div>
                                <div class="col-md-6">
                                    <strong>Account Number:</strong><br>
                                    564778912345
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <strong>Account Name:</strong><br>
                                    UiTM Student Activities Fund
                                </div>
                                <div class="col-md-6">
                                    <strong>Reference:</strong><br>
                                    ${sessionScope.userID}-${event.eventId}
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Important:</strong> Please include the reference number in your transfer description.
                        </div>
                        
                        <!-- Upload Receipt -->
                        <div class="upload-section" id="uploadSection">
                            <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                            <h6>Upload Payment Receipt</h6>
                            <p class="text-muted mb-3">
                                Drag and drop your receipt here, or click to browse
                            </p>
                            <input type="file" name="paymentReceipt" id="paymentReceipt" 
                                   accept="image/*,application/pdf" style="display: none;">
                            <button type="button" class="btn btn-outline-primary" 
                                    onclick="document.getElementById('paymentReceipt').click()">
                                <i class="fas fa-folder-open me-2"></i>Choose File
                            </button>
                            <div id="uploadedFile" class="mt-3" style="display: none;">
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <span id="fileName"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Payment Reference -->
                    <div class="mb-3" id="referenceSection" style="display: none;">
                        <label for="paymentReference" class="form-label">Payment Reference Number</label>
                        <input type="text" class="form-control" name="paymentReference" id="paymentReference"
                               placeholder="Enter transaction reference number">
                        <div class="form-text">
                            Enter the reference number from your payment confirmation.
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <a href="student?action=eventDetails&eventId=${event.eventId}" class="btn btn-back w-100">
                                <i class="fas fa-arrow-left me-2"></i>Back to Event
                            </a>
                        </div>
                        <div class="col-md-6">
                            <button type="submit" class="btn-payment" id="paymentBtn" disabled>
                                <i class="fas fa-credit-card me-2"></i>Complete Payment
                            </button>
                        </div>
                    </div>
                    
                    <!-- Security Badge -->
                    <div class="security-badge">
                        <i class="fas fa-shield-alt me-2"></i>
                        Your payment information is secure and encrypted
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        let selectedPaymentMethod = null;
        
        // Toggle sidebar for mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
        }
        
        // Select payment method
        function selectPaymentMethod(method) {
            // Remove previous selection
            document.querySelectorAll('.payment-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Add selection to clicked option
            event.currentTarget.classList.add('selected');
            
            // Check radio button
            document.getElementById(method).checked = true;
            selectedPaymentMethod = method;
            
            // Show/hide relevant sections
            const bankDetails = document.getElementById('bankTransferDetails');
            const referenceSection = document.getElementById('referenceSection');
            
            if (method === 'bank_transfer') {
                bankDetails.style.display = 'block';
                referenceSection.style.display = 'none';
            } else {
                bankDetails.style.display = 'none';
                referenceSection.style.display = 'block';
            }
            
            validateForm();
        }
        
        // Handle file upload
        document.getElementById('paymentReceipt').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                document.getElementById('fileName').textContent = file.name;
                document.getElementById('uploadedFile').style.display = 'block';
                validateForm();
            }
        });
        
        // Drag and drop functionality
        const uploadSection = document.getElementById('uploadSection');
        
        uploadSection.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadSection.classList.add('dragover');
        });
        
        uploadSection.addEventListener('dragleave', function(e) {
            e.preventDefault();
            uploadSection.classList.remove('dragover');
        });
        
        uploadSection.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadSection.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                document.getElementById('paymentReceipt').files = files;
                document.getElementById('fileName').textContent = files[0].name;
                document.getElementById('uploadedFile').style.display = 'block';
                validateForm();
            }
        });
        
        // Validate form
        function validateForm() {
            const paymentBtn = document.getElementById('paymentBtn');
            let isValid = false;
            
            if (selectedPaymentMethod === 'bank_transfer') {
                const fileUploaded = document.getElementById('paymentReceipt').files.length > 0;
                isValid = fileUploaded;
            } else if (selectedPaymentMethod === 'online_banking' || selectedPaymentMethod === 'ewallet') {
                const reference = document.getElementById('paymentReference').value.trim();
                isValid = reference.length > 0;
            }
            
            paymentBtn.disabled = !isValid;
        }
        
        // Payment reference input validation
        document.getElementById('paymentReference').addEventListener('input', validateForm);
        
        // Form submission
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            const paymentBtn = document.getElementById('paymentBtn');
            paymentBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing Payment...';
            paymentBtn.disabled = true;
        });
        
        // Auto-hide mobile sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const isClickInsideSidebar = sidebar.contains(event.target);
            const isClickOnMenuButton = event.target.closest('.btn') && 
                                       event.target.closest('.btn').onclick === toggleSidebar;
            
            if (!isClickInsideSidebar && !isClickOnMenuButton && sidebar.classList.contains('show')) {
                sidebar.classList.remove('show');
            }
        });
    </script>
</body>
</html>