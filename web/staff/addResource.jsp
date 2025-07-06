<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Resource – Staff Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .form-step { display: none; }
        .form-step.active { display: block; animation: fadeIn 0.5s; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .progress-bar { transition: width 0.4s ease; background-color: #6D5BBA; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp">
                <jsp:param name="active" value="resourceManagement"/>
            </jsp:include>
        </div>
        <!-- Main content -->
        <div class="col-md-9 col-lg-10 p-4">
            <div class="d-flex align-items-center mb-4">
                <a href="staff?action=resourceManagement" class="btn btn-outline-secondary me-3">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <h2 class="mb-0">Add New Resource</h2>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="card">
                <div class="card-body p-4 p-md-5">
                    <div class="mb-4">
                        <h6 id="progress-text">Step 1 of 3: Basic Information</h6>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" id="progressBar" role="progressbar" style="width: 33%;"></div>
                        </div>
                    </div>

                    <form action="staff" method="post" id="addResourceForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="createResource"/>

                        <!-- Step 1 -->
                        <div class="form-step active" id="step-1">
                            <div class="mb-3">
                                <label for="resourceName" class="form-label">Resource Name*</label>
                                <input type="text" class="form-control" id="resourceName" name="resourceName" required>
                            </div>
                            <div class="mb-3">
                                <label for="category" class="form-label">Category*</label>
                                <input type="text" class="form-control" id="category" name="category"
                                       placeholder="e.g., Audio-Visual, Furniture" required>
                            </div>
                            <div class="mb-3">
                                <label for="location" class="form-label">Storage Location*</label>
                                <input type="text" class="form-control" id="location" name="location" required>
                            </div>
                        </div>

                        <!-- Step 2 -->
                        <div class="form-step" id="step-2">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="totalQuantity" class="form-label">Total Quantity*</label>
                                    <input type="number" class="form-control" id="totalQuantity" name="totalQuantity"
                                           min="1" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="condition" class="form-label">Condition*</label>
                                    <select class="form-select" id="condition" name="condition" required>
                                        <option value="Good" selected>Good</option>
                                        <option value="Fair">Fair</option>
                                        <option value="Damaged">Damaged</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Step 3 -->
                        <div class="form-step" id="step-3">
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="usageInstructions" class="form-label">Usage Instructions</label>
                                <textarea class="form-control" id="usageInstructions" name="usageInstructions"
                                          rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="imageFile" class="form-label">Upload Image (PNG only)*</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile"
                                    accept=".png, .jpg, .jpeg" required>
                            </div>
                        </div>

                        <!-- Navigation Buttons -->
                        <div class="mt-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" id="prevBtn" style="display: none;">
                                Previous
                            </button>
                            <div>
                                <a href="staff?action=resourceManagement" class="btn btn-outline-secondary">
                                    Cancel
                                </a>
                                <button type="button" class="btn btn-primary" id="nextBtn">Next</button>
                                <button type="submit" class="btn btn-success" id="submitBtn" style="display: none;">
                                    Add Resource
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        let currentStep = 1, totalSteps = 3;
        const steps      = document.querySelectorAll('.form-step'),
              nextBtn    = document.getElementById('nextBtn'),
              prevBtn    = document.getElementById('prevBtn'),
              submitBtn  = document.getElementById('submitBtn'),
              progressBar= document.getElementById('progressBar'),
              progressText = document.getElementById('progress-text');

        function showStep(n) {
            steps.forEach(s => s.classList.remove('active'));
            document.getElementById('step-' + n).classList.add('active');
            updateUI(n);
        }

        function updateUI(n) {
            const pct = (n / totalSteps) * 100;
            progressBar.style.width = pct + '%';
            progressText.textContent = `Step ${n} of ${totalSteps}: ` +
                (n === 1 ? 'Basic Information' :
                 n === 2 ? 'Inventory & Condition' :
                           'Details & Media');
            prevBtn.style.display   = n > 1 ? 'inline-block' : 'none';
            nextBtn.style.display   = n < totalSteps ? 'inline-block' : 'none';
            submitBtn.style.display = n === totalSteps ? 'inline-block' : 'none';
        }

        function validateStep(n) {
            const inputs = document.querySelectorAll(`#step-${n} [required]`);
            for (let inp of inputs) {
                if (!inp.value.trim()) {
                    alert('Please fill out all required fields.');
                    inp.focus();
                    return false;
                }
            }
            return true;
        }

        nextBtn.addEventListener('click', () => {
            if (validateStep(currentStep) && currentStep < totalSteps) {
                currentStep++;
                showStep(currentStep);
            }
        });
        prevBtn.addEventListener('click', () => {
            if (currentStep > 1) {
                currentStep--;
                showStep(currentStep);
            }
        });

        showStep(currentStep);
    });
</script>
</body>
</html>
