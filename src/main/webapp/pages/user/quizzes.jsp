<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login");
    }
%>

<html>
<head>
    <title>Available Quizzes - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Quizzes-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quizzes.css?v1">
</head>
<body class="bg-light">
    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <main class="container py-5">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex align-items-center mb-3">
                    <h1 class="display-5 fw-bold text-dark mb-0"><i class="bi bi-mortarboard me-3"></i>Available Quizzes</h1>
                    <c:if test="${not empty quizzes}">
                        <span class="badge bg-primary rounded-pill ms-3 fs-6">${quizzes.size()} Available</span>
                    </c:if>
                </div>
                <p class="lead text-muted">Test your knowledge with these interactive quizzes</p>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${empty quizzes}">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-body text-center py-5">
                                <i class="bi bi-patch-question display-4 text-muted mb-4"></i>
                                <h3 class="h4 text-dark mb-3">No Quizzes Available</h3>
                                <p class="text-muted mb-4">New quizzes are being prepared. Check back soon!</p>
                                <button class="btn btn-primary" onclick="location.reload()">
                                    <i class="bi bi-arrow-repeat me-2"></i>Refresh
                                </button>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach items="${quizzes}" var="quiz">
                                <div class="col">
                                    <div class="card h-100 quiz-card border-0 shadow-sm overflow-hidden">
                                        <div class="card-header bg-gradient-primary text-white py-3">
                                            <h3 class="h5 mb-0 d-flex align-items-center">
                                                <i class="bi bi-pencil-square me-2"></i>
                                                <span class="text-truncate">${quiz.title}</span>
                                            </h3>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <div class="mb-3">
                                                <div class="d-flex align-items-center mb-3">
                                                    <div class="me-3">
                                                        <div class="icon-circle bg-light-primary">
                                                            <i class="bi bi-clock-history text-primary"></i>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0">Time Limit</h6>
                                                        <p class="text-muted mb-0">${quiz.timeLimit} minutes</p>
                                                    </div>
                                                </div>
                                                <%--
                                                <div class="d-flex align-items-center">
                                                    <div class="me-3">
                                                        <div class="icon-circle bg-light-info">
                                                            <i class="bi bi-question-circle text-info"></i>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0">Questions</h6>
                                                        <p class="text-muted mb-0">${quiz.questionCount}</p>
                                                    </div>
                                                </div>
                                                --%>
                                            </div>
                                            <div class="mt-auto">
                                                <form action="UserStartQuiz" method="post" class="d-grid gap-2">
                                                    <input type="hidden" name="quizId" value="${quiz.quizId}">
                                                    <input type="hidden" name="quizTitle" value="${quiz.title}">
                                                    <input type="hidden" name="quizTimeLimit" value="${quiz.timeLimit}">
                                                    <button type="submit" class="btn btn-success btn-lg rounded-pill">
                                                        <i class="bi bi-play-fill me-2"></i>Start Quiz
                                                    </button>
                                                </form>
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
</body>
</html>