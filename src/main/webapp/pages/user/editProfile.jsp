<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Edit Profile - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Profile-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile-edit.css?v2">
</head>
<body class="bg-light">
    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h2 class="h4 mb-0"><i class="bi bi-person-gear me-2"></i>Edit Profile</h2>
                    </div>
                    
                    <!-- Verification Section -->
                    <div class="card-body" id="verifySection">
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle-fill me-2"></i>Please verify your identity before making changes
                        </div>
                        
                        <div id="errorMessage" ></div>
                        
                        <input type="hidden" id="username" value="${user.userName}">
                        
                        <form id="verifyForm" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback">
                                    Please enter your current password
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-primary" onclick="validateCredentials(<%= user.getUserId() %>)">
                                    <i class="bi bi-shield-lock me-2"></i>Verify Identity
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Edit Section (Initially Hidden) -->
                    <div class="card-body" id="editSection" style="display: none;">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>Leave password field unchanged if you don't want to update it
                        </div>
                        
                        <form id="editForm" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="newUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="newUsername" value="${user.userName}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid username
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="newEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="newEmail" value="${user.email}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid email
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" placeholder="Leave blank to keep current">
                                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                                
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-success" onclick="updateProfile(<%= user.getUserId() %>)">
                                    <i class="bi bi-save me-2"></i>Save Changes
                                </button>
                                <button type="button" class="btn btn-outline-secondary" onclick="location.reload()">
                                    <i class="bi bi-x-circle me-2"></i>Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/pages/user/js/editProfile.js?v2"></script>
    
    <script>
        // Password visibility toggle
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
            }
        });
        
        // New password visibility toggle
        document.getElementById('toggleNewPassword').addEventListener('click', function() {
            const password = document.getElementById('newPassword');
            const icon = this.querySelector('i');
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
            }
        });
        
        // Form validation
        (function () {
            'use strict'
            
            // Fetch forms to apply custom Bootstrap validation styles to
            var forms = document.querySelectorAll('.needs-validation')
            
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>