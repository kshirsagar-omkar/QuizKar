<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%@page import="com.quizkar.constants.Role"%>
<%@page import="com.quizkar.util.SessionUtil"%>

<%
	// Prevent unauthorized access
	Users user = SessionUtil.getUser(request);
	if (user == null || ! user.getRole().equals(Role.USER)  ) {
		response.sendRedirect( request.getContextPath() + "/LogoutServlet");
   		return;
	}
    
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>User Profile - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Profile-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css?v1">
</head>
<body class="bg-light">
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card profile-card shadow">
                    <div class="card-header bg-primary text-white">
                        <h2 class="mb-0">My Profile</h2>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <div class="profile-picture mb-3">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="#2c3e50" class="bi bi-person-circle" viewBox="0 0 16 16">
                                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                    </svg>
                                </div>
                                <a href="UserEditProfile" class="btn btn-custom btn-sm">Edit Profile</a>
                            </div>
                            <div class="col-md-8">
                                <div class="profile-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Username:</span>
                                        <span class="detail-value">${user.userName}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Email:</span>
                                        <span class="detail-value">${user.email}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Account Type:</span>
                                        <span class="detail-value badge text-bg-info" style="width:60px">${user.role}</span>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-light">
                        <div class="d-flex justify-content-between">
                            <a href="UserDashboard" class="btn btn-outline-primary">
                                < Back to Dashboard
                            </a>
                            <button type="button" class="btn btn-danger">
	                            <a href="DeleteAccountServlet" style="color:white; text-decoration: none;">
	                                Delete Account
	                            </a>
	                        </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>