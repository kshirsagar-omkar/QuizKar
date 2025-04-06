<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css">
    <!-- Registration-specific CSS -->
    <link rel="stylesheet" href="css/auth.css?v2">
</head>
<body class="bg-light">
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card auth-card shadow">
                    <div class="card-body p-4 p-md-5">
                        <h1 class="text-center mb-4">Create Your Account</h1>
                        
                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger mb-4">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>
                        
                        <form action="register" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                                <div class="invalid-feedback">
                                    Please choose a username.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <div class="invalid-feedback">
                                    Please provide a valid email.
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                                <div class="invalid-feedback">
                                    Please provide a password.
                                </div>
                            </div>
                            
                            <input type="hidden" name="role" value="user">
                            
                            <button type="submit" class="btn btn-custom w-100 py-2 mb-3">Register</button>
                            
                            <div class="text-center mt-3">
                                <p class="text-muted">Already have an account? <a href="login" class="text-decoration-none">Login here</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Form validation script -->
    <script>
    (function () {
      'use strict'
      
      var forms = document.querySelectorAll('.needs-validation')
      
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