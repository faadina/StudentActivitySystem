<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Venue - Staff Panel</title>
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
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="staffSidebar.jsp"><jsp:param name="active" value="venueManagement"/></jsp:include>
        </div>
        <div class="col-md-9 col-lg-10" style="padding: 2rem;">
            <div class="d-flex align-items-center mb-4">
                <a href="staff?action=venueManagement" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
                <h2 class="mb-0">Add New Venue</h2>
            </div>
            <div class="card">
                <div class="card-body p-4 p-md-5">
                    <div class="mb-4">
                        <h6 id="progress-text">Step 1 of 3: Basic Information</h6>
                        <div class="progress" style="height: 10px;"><div class="progress-bar" id="progressBar" style="width: 33%;"></div></div>
                    </div>
                    <form action="staff" method="post" id="addVenueForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="createVenue">
                        <div class="form-step active" id="step-1">
                            <div class="row">
                                <div class="col-md-8 mb-3"><label for="venueName" class="form-label">Venue Name*</label><input type="text" class="form-control" id="venueName" name="venueName" required></div>
                                <div class="col-md-4 mb-3"><label for="venueType" class="form-label">Venue Type*</label><input type="text" class="form-control" id="venueType" name="venueType" required placeholder="e.g., Lecture Hall"></div>
                            </div>
                            <div class="row">
                                 <div class="col-md-6 mb-3"><label for="building" class="form-label">Building*</label><input type="text" class="form-control" id="building" name="building" required></div>
                                <div class="col-md-6 mb-3"><label for="floor" class="form-label">Floor / Level</label><input type="text" class="form-control" id="floor" name="floor"></div>
                            </div>
                        </div>
                        <div class="form-step" id="step-2">
                             <div class="row">
                                 <div class="col-md-6 mb-3"><label for="capacity" class="form-label">Capacity*</label><input type="number" class="form-control" id="capacity" name="capacity" required min="1"></div>
                                <div class="col-md-6 mb-3"><label for="price" class="form-label">Price per Hour (RM)*</label><input type="number" class="form-control" id="price" name="price" required step="0.01" min="0" value="0.00"></div>
                            </div>
                            <div class="mb-3"><label for="description" class="form-label">Description</label><textarea class="form-control" id="description" name="description" rows="5"></textarea></div>
                        </div>
                        <div class="form-step" id="step-3">
                          <div class="mb-3">
                          <div class="mb-3">
                            <label for="facilities" class="form-label">Facilities</label>
                            <input type="text" class="form-control" id="facilities" name="facilities">
                            <div class="form-text">Use commas (e.g., Projector, Whiteboard, WiFi).</div>
                          </div>
                            <label for="imageFile" class="form-label">Upload Image (PNG only)*</label>
                            <input type="file"
                                   class="form-control"
                                   id="imageFile"
                                   name="imageFile"
                                   accept=".png,.jpg,.jpeg"
                                   required>
                          </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" id="prevBtn" style="display: none;">Previous</button>
                            <div>
                                <a href="staff?action=venueManagement" class="btn btn-outline-secondary">Cancel</a>
                                <button type="button" class="btn btn-primary" id="nextBtn">Next</button>
                                <button type="submit" class="btn btn-success" id="submitBtn" style="display: none;">Add Venue</button>
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
document.addEventListener('DOMContentLoaded', () => {
  const steps       = Array.from(document.querySelectorAll('.form-step'));
  const nextBtn     = document.getElementById('nextBtn');
  const prevBtn     = document.getElementById('prevBtn');
  const submitBtn   = document.getElementById('submitBtn');
  const progressBar = document.getElementById('progressBar');
  const progressText= document.getElementById('progress-text');
  let currentStep = 0;

  function updateStep() {
    // show only the active step
    steps.forEach((step, idx) => {
      step.classList.toggle('active', idx === currentStep);
    });
    // update progress bar & text
    const pct = ((currentStep + 1) / steps.length) * 100;
    progressBar.style.width = pct + '%';
    const labels = [
      'Step 1 of 3: Basic Information',
      'Step 2 of 3: Specifications',
      'Step 3 of 3: Additional Info'
    ];
    progressText.textContent = labels[currentStep];
    // show/hide nav buttons
    prevBtn.style.display   = currentStep > 0                ? 'inline-block' : 'none';
    nextBtn.style.display   = currentStep < steps.length-1   ? 'inline-block' : 'none';
    submitBtn.style.display = currentStep === steps.length-1 ? 'inline-block' : 'none';
  }

  nextBtn.addEventListener('click', () => {
    // validate required inputs in this step
    const reqs = steps[currentStep].querySelectorAll('input[required]');
    for (let inp of reqs) {
      if (!inp.value.trim()) {
        alert('Please fill out all required fields.');
        inp.focus();
        return;
      }
    }
    currentStep++;
    updateStep();
  });

  prevBtn.addEventListener('click', () => {
    if (currentStep > 0) {
      currentStep--;
      updateStep();
    }
  });

  // initialize
  updateStep();
});
</script>

</body>
</html>