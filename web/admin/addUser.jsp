<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-content { background-color: #f8f9fa; min-height: 100vh; }
        .card-header { background-color: #fff; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <jsp:include page="adminSidebar.jsp">
                    <jsp:param name="active" value="users"/>
                </jsp:include>
            </div>

            <div class="col-md-10 main-content">
                <div class="p-4">
                    <div class="d-flex align-items-center mb-4">
                        <a href="admin?action=users" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
                        <h2 class="mb-0">Add New User</h2>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="card shadow-sm">
                        <div class="card-header"><h5 class="mb-0">User Details (ID will be auto-generated)</h5></div>
                        <div class="card-body">
                            <form id="addUserForm" action="admin" method="post">
                                <input type="hidden" name="action" value="createUser">
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="userName" class="form-label">Full Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="userName" name="userName" required>
                                    </div>
                                     <div class="col-md-6 mb-3">
                                        <label for="userEmail" class="form-label">Email Address <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" id="userEmail" name="userEmail" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="userPhoneNo" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control" id="userPhoneNo" name="userPhoneNo">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="userRole" class="form-label">User Role <span class="text-danger">*</span></label>
                                        <select class="form-select" id="userRole" name="userRole" required>
                                            <option value="" disabled selected>-- Select Role --</option>
                                            <option value="staff">Staff</option>
                                            <option value="organization">Organization</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                     <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                     <div class="col-md-6 mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="confirmPassword" required>
                                        <div id="passwordMatch" class="form-text"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="userStatus" class="form-label">User Status</label>
                                        <select class="form-select" id="userStatus" name="userStatus">
                                            <option value="active" selected>Active</option>
                                            <option value="inactive">Inactive</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="mt-3 text-end">
                                    <a href="admin?action=users" class="btn btn-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-primary" id="submitBtn">Create User</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
    const passwordField = document.getElementById('password');
    const confirmPasswordField = document.getElementById('confirmPassword');
    const matchDiv = document.getElementById('passwordMatch');
    const submitBtn = document.getElementById('submitBtn');

    function checkPasswordMatch() {
        if (confirmPasswordField.value.length > 0 && passwordField.value !== confirmPasswordField.value) {
            matchDiv.textContent = '✗ Passwords do not match.';
            matchDiv.style.color = 'red';
            submitBtn.disabled = true;
        } else {
            matchDiv.textContent = '';
            submitBtn.disabled = false;
        }
    }
    passwordField.addEventListener('input', checkPasswordMatch);
    confirmPasswordField.addEventListener('input', checkPasswordMatch);
</script>
</body>
</html>