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
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Quizzes-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quizzes.css">
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
        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h1 class="h3 mb-0"><i class="bi bi-patch-question-fill me-2"></i>Available Quizzes</h1>
                    </div>
                    <div class="card-body">
                        <% if(request.getAttribute("quizzes") == null) { %>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                No quizzes available at the moment. Please check back later.
                            </div>
                        <% } else { %>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                                <c:forEach items="${quizzes}" var="quiz">
                                    <div class="col">
                                        <div class="card h-100 quiz-card">
                                            <div class="card-header bg-light">
                                                <h3 class="h5 mb-0">${quiz.title}</h3>
                                            </div>
                                            <div class="card-body">
                                                <ul class="list-group list-group-flush mb-3">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span><i class="bi bi-clock-history me-2"></i>Time Limit</span>
                                                        <span class="badge bg-primary rounded-pill">${quiz.timeLimit} mins</span>
                                                    </li>
                                                     <%--
                                                     <li class="list-group-item d-flex justify-content-between align-items-center">
                                                       <span><i class="bi bi-question-circle me-2"></i>Questions</span>
                                                        <span class="badge bg-primary rounded-pill">${quiz.questionCount}</span> 
                                                    </li> 
                                                    --%>
                                                </ul>
                                                <form action="UserStartQuiz" method="post">
                                                    <input type="hidden" name="quizId" value="${quiz.quizId}">
                                                    <input type="hidden" name="quizTitle" value="${quiz.title}">
                                                    <input type="hidden" name="quizTimeLimit" value="${quiz.timeLimit}">
                                                    <button type="submit" class="btn btn-success w-100">
                                                        <i class="bi bi-play-fill me-2"></i>Start Quiz
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>