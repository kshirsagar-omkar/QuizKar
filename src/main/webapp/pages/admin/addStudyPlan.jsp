<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>

<html>
<head>
    <title>Add Study Plan - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Page Specific CSS -->
    <style>
        .study-plan-container {
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        
        .study-plan-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .study-plan-card:hover {
            transform: translateY(-5px);
        }
        
        .study-plan-header {
            background-color: #2c3e50;
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn-theme-primary {
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        
        .btn-theme-primary:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
    </style>
</head>
<body class="study-plan-container">

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
                <div class="card study-plan-card">
                    <div class="card-header study-plan-header">
                        <h2 class="h4 mb-0"><i class="bi bi-journal-bookmark me-2"></i>Create New Study Plan</h2>
                    </div>
                    <div class="card-body">
                        <form id="studyPlanForm" onsubmit="event.preventDefault(); addStudyPlan(<%= user.getUserId() %>)">
						    <div class="mb-4">
						        <label for="studyPlanName" class="form-label">Plan Name</label>
						        <input type="text" class="form-control form-control-lg" id="studyPlanName" required>
						        <div class="invalid-feedback">Please provide a plan name.</div>
						    </div>
						    
						    <div class="mb-4">
						        <label for="studyPlanLink" class="form-label">Resource Link</label>
						        <input type="url" class="form-control form-control-lg" id="studyPlanLink" required>
						        <div class="invalid-feedback">Please provide a valid URL.</div>
						    </div>
						    
						    <input type="hidden" id="adminId" value="<%= user.getUserId() %>">
						    
						    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
						        <button type="submit" class="btn btn-theme-primary">
						            <i class="bi bi-save me-2"></i>Create Study Plan
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
    <!-- Page Specific JS -->
    <script src="${pageContext.request.contextPath}/pages/admin/js/addStudyPlan.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>