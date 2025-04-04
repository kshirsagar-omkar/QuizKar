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
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Study Plans CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study-plans.css">
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

    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h1 class="h3 mb-0"><i class="bi bi-journal-bookmark-fill me-2"></i>Available Study Plans</h1>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty studyPlans}">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle-fill me-2"></i>
                                    No study plans available at the moment. Please check back later.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                                    <c:forEach items="${studyPlans}" var="plan">
                                        <div class="col">
                                            <div class="card h-100 study-plan-card">
                                                <div class="card-header bg-light">
                                                    <h3 class="h5 mb-0">${plan.name}</h3>
                                                </div>
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <p class="text-muted mb-1">
                                                            <i class="bi bi-calendar-event me-2"></i>
                                                            <fmt:parseDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                                                            <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy - hh:mm a"/>
                                                        </p>
                                                    </div>
                                                    <div class="mb-3">
                                                        <a href="${plan.link}" target="_blank" class="btn btn-outline-primary w-100">
                                                            <i class="bi bi-link-45deg me-2"></i>View Study Materials
                                                        </a>
                                                    </div>
                                                    <button class="btn btn-success w-100 enroll-btn" 
                                                            onclick="enrollInStudyPlan(${plan.studyPlanId}, '<%= user.getUserId() %>')">
                                                        <i class="bi bi-journal-check me-2"></i>Enroll
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/pages/user/js/studyPlans.js"></script>
</body>
</html>