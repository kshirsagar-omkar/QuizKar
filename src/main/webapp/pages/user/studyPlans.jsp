<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>Study Plans - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Study Plans CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study-plans.css?v2">
</head>
<body class="bg-light">

    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <!-- Notification Toast -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="enrollToast" class="toast align-items-center text-white" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="toastMessage">
                    <!-- Message will be inserted here -->
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <main class="container py-5">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex align-items-center mb-3">
                    <h1 class="display-5 fw-bold text-dark mb-0"><i class="bi bi-journal-bookmark-fill me-3"></i>Study Plans</h1>
                    <span class="badge bg-primary rounded-pill ms-3 fs-6">${studyPlans.size()} Available</span>
                </div>
                <p class="lead text-muted">Enroll in structured learning paths to enhance your knowledge</p>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${empty studyPlans}">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-body text-center py-5">
                                <i class="bi bi-journal-x display-4 text-muted mb-4"></i>
                                <h3 class="h4 text-dark mb-3">No Study Plans Available</h3>
                                <p class="text-muted mb-4">We're working on creating new study plans. Please check back soon!</p>
                                <button class="btn btn-primary" onclick="location.reload()">
                                    <i class="bi bi-arrow-repeat me-2"></i>Refresh
                                </button>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach items="${studyPlans}" var="plan">
                                <div class="col">
                                    <div class="card h-100 study-plan-card border-0 shadow-sm overflow-hidden">
                                        <div class="card-header bg-gradient-primary text-white py-3">
                                            <h3 class="h5 mb-0 d-flex align-items-center">
                                                <i class="bi bi-journal-text me-2"></i>
                                                <span class="text-truncate">${plan.name}</span>
                                            </h3>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <div class="mb-3">
                                                <span class="badge bg-light text-dark mb-2">
                                                    <i class="bi bi-calendar-event me-1"></i>
                                                    <fmt:parseDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy"/>
                                                </span>
                                                <p class="text-muted mb-4">Enroll to access comprehensive learning materials for this topic.</p>
                                            </div>
                                            <div class="mt-auto">
                                                <div class="d-grid gap-2">
                                                    <a href="${plan.link}" target="_blank" class="btn btn-outline-primary btn-sm rounded-pill">
                                                        <i class="bi bi-link-45deg me-2"></i>Preview Materials
                                                    </a>
                                                    <button class="btn btn-success btn-sm rounded-pill enroll-btn" 
                                                            onclick="enrollInStudyPlan(${plan.studyPlanId}, '<%= user.getUserId() %>')">
                                                        <i class="bi bi-journal-check me-2"></i>Enroll Now
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/pages/user/js/studyPlans.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>