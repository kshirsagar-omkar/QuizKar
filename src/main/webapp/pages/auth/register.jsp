<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css">
    <!-- Registration-specific CSS -->
    <link rel="stylesheet" href="css/auth.css?v6">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body class="bg-light">
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card auth-card shadow">
                    <div class="card-body p-4 p-md-5">
                        <h1 class="text-center mb-4">Create Your Account</h1>
                        
                        <div id="alertContainer">
                            <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-custom mb-4">
                                <%= request.getAttribute("error") %>
                            </div>
                            <% } %>
                        </div>
                        
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
                                <div class="input-group">
                                    <input type="email" class="form-control" id="email" name="email" required>
                                    <button class="btn btn-custom" type="button" id="sendOtpBtn">
                                        Send OTP
                                    </button>
                                </div>
                                <div class="invalid-feedback">
                                    Please provide a valid email.
                                </div>
                                <div id="emailHelpBlock" class="form-text mt-1">
                                    We'll send a verification code to this email address.
                                </div>
                            </div>

                            <!-- OTP Verification Section (Initially Hidden) -->
                            <div class="mb-3 otp-section" id="otpSection" style="display: none;">
                                <div class="verification-badge">
                                    <span class="badge-text">Verification in progress</span>
                                </div>
                                <div class="otp-header mb-2">
                                    <span>We've sent a code to <span id="emailDisplay" class="fw-bold"></span></span>
                                </div>
                                <div class="otp-input-container mb-2">
                                    <label for="otpInput" class="form-label">Enter 6-digit verification code</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="otpInput" maxlength="6" pattern="\d{6}" placeholder="Enter code" required>
                                        <button class="btn btn-custom" type="button" id="verifyOtpBtn">Verify</button>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between mt-2">
                                    <small id="otpStatus" class="text-muted"></small>
                                    <small id="otpAttempts" class="text-muted"></small>
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
                            <input type="hidden" id="emailVerified" name="emailVerified" value="false">
                            
                            <button type="submit" class="btn btn-custom w-100 py-2 mb-3" id="registerBtn" disabled>Create Account</button>
                            
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
    
    <!-- Registration and OTP Verification Script -->
    <script src="${pageContext.request.contextPath}/pages/auth/js/register.js?v6"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>