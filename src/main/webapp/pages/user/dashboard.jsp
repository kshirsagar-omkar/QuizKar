<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <title>User Dashboard - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">

    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <!-- Notification Toast -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="statusToast" class="toast align-items-center text-white" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="toastMessage">
                    <!-- Message will be inserted here -->
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <div class="container-fluid px-4 py-4">
        <!-- Welcome Header with Stats -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="welcome-card animate__animated animate__fadeIn">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h1 class="welcome-title">
                                <span class="wave-hand">👋</span> Welcome back, <span class="username-highlight"><%= user.getUserName() %></span>!
                            </h1>
                            <p class="welcome-subtitle">Track your learning progress and achievements</p>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-container">
                                <div class="stat-card">
                                    <div class="stat-icon bg-primary">
                                        <i class="bi bi-journal-bookmark"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>${ongoingStudyPlans != null ? ongoingStudyPlans.size() : 0}</h3>
                                        <p>Active Plans</p>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon bg-success">
                                        <i class="bi bi-check-circle"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>${completedStudyPlans != null ? completedStudyPlans.size() : 0}</h3>
                                        <p>Completed</p>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon bg-info">
                                        <i class="bi bi-patch-question"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>${completedQuizzes != null ? completedQuizzes.size() : 0}</h3>
                                        <p>Quizzes Taken</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Study Plans Row (Split Layout) -->
        <div class="row mb-4">
            <!-- Ongoing Study Plans -->
            <div class="col-lg-6 mb-4 mb-lg-0">
                <div class="card shadow study-plans-card animate__animated animate__fadeInLeft">
                    <div class="card-header bg-gradient-primary">
                        <div class="d-flex justify-content-between align-items-center">
                            <h2 class="h5 mb-0"><i class="bi bi-journal-bookmark me-2"></i>Ongoing Study Plans</h2>
                            <span class="badge bg-white text-primary">${ongoingStudyPlans != null ? ongoingStudyPlans.size() : 0}</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty ongoingStudyPlans}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="bi bi-journal-x"></i>
                                    </div>
                                    <h4>No active study plans</h4>
                                    <p>Get started by enrolling in a new study plan</p>
                                    <a href="UserStudyPlanServlet" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Browse Plans
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="study-plans-list">
                                    <c:forEach items="${ongoingStudyPlans}" var="plan">
                                        <div class="study-plan-item">
                                            <div class="study-plan-header">
                                                <h3 class="study-plan-title">${plan.name}</h3>
                                                <span class="badge bg-warning">In Progress</span>
                                            </div>
                                            <div class="study-plan-actions">
                                                <a href="${plan.link}" target="_blank" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-link-45deg me-1"></i>Materials
                                                </a>
                                                <button class="btn btn-sm btn-success" 
                                                        onclick="updateStudyPlanStatus(${plan.studyPlanId}, this, '<%= user.getUserId() %>')" 
                                                        value="complete">
                                                    <i class="bi bi-check-circle me-1"></i>Complete
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Completed Study Plans -->
            <div class="col-lg-6">
                <div class="card shadow study-plans-card animate__animated animate__fadeInRight">
                    <div class="card-header bg-gradient-success">
                        <div class="d-flex justify-content-between align-items-center">
                            <h2 class="h5 mb-0"><i class="bi bi-journal-check me-2"></i>Completed Study Plans</h2>
                            <span class="badge bg-white text-success">${completedStudyPlans != null ? completedStudyPlans.size() : 0}</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty completedStudyPlans}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="bi bi-emoji-frown"></i>
                                    </div>
                                    <h4>No completed plans yet</h4>
                                    <p>Complete your ongoing plans to see them here</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="study-plans-list">
                                    <c:forEach items="${completedStudyPlans}" var="plan">
                                        <div class="study-plan-item completed">
                                            <div class="study-plan-header">
                                                <h3 class="study-plan-title">${plan.name}</h3>
                                                <span class="badge bg-success">Completed</span>
                                            </div>
                                            <div class="study-plan-actions">
                                                <a href="${plan.link}" target="_blank" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-link-45deg me-1"></i>Review
                                                </a>
                                                <button class="btn btn-sm btn-warning" 
                                                        onclick="updateStudyPlanStatus(${plan.studyPlanId}, this, '<%= user.getUserId() %>')" 
                                                        value="not_complete">
                                                    <i class="bi bi-arrow-counterclockwise me-1"></i>Reopen
                                                </button>
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
        
        <!-- Completed Quizzes (Full Width) -->
        <div class="row">
            <div class="col-12">
                <div class="card shadow quizzes-card animate__animated animate__fadeInUp">
                    <div class="card-header bg-gradient-info">
                        <div class="d-flex justify-content-between align-items-center">
                            <h2 class="h5 mb-0"><i class="bi bi-clipboard-check-fill me-2"></i>Completed Quizzes</h2>
                            <span class="badge bg-white text-info">${completedQuizzes != null ? completedQuizzes.size() : 0}</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty completedQuizzes}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="bi bi-patch-question"></i>
                                    </div>
                                    <h4>No quiz results yet</h4>
                                    <p>Take some quizzes to see your results here</p>
                                    <a href="UserQuizzes" class="btn btn-info">
                                        <i class="bi bi-arrow-right-circle me-2"></i>Take a Quiz
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover quizzes-table">
                                        <thead>
                                            <tr>
                                                <th>Quiz</th>
                                                <th>Score</th>
                                                <th>Time Limit</th>
                                                <th>Time Taken</th>
                                                <th>Date Completed</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${completedQuizzes}" var="quiz">
                                                <tr class="quiz-row">
                                                    <td>
                                                        <div class="quiz-title">${quiz.quizTitle}</div>
                                                    </td>
                                                    <td>
                                                        ${quiz.leaderBoardScore}
                                                    </td>
                                                    <td>${quiz.quizTimeLimit} mins</td>
                                                    <td>${quiz.leaderBoardTimeTaken} mins</td>
                                                    <td>                                                        
                                                        <p>  
										                	<fmt:parseDate value="${quiz.leaderBoardParticipationDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
									                		<fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy - hh:mm a"/>
									                	</p>
                                                    </td>
                                                    <td>
                                                        <a href="UserLeaderboard?filter=${quiz.quizTitle}" class="btn btn-sm btn-outline-info">
                                                            <i class="bi bi-trophy me-1"></i>Leaderboard
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../../components/chatbot.jsp"/>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Dashboard JS -->
    <script src="${pageContext.request.contextPath}/pages/user/js/dashboard.js"></script>
</body>
</html>