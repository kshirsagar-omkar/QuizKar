<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.quizkar.constants.Role"%>
<%@page import="com.quizkar.util.SessionUtil"%>
<%
	//Prevent unauthorized access
	Users user = SessionUtil.getUser(request);
	if (user == null || ! user.getRole().equals(Role.ADMIN)  ) {
		response.sendRedirect( request.getContextPath() + "/LogoutServlet");
		return;
	}
%>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Admin Dashboard - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Admin Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v2">
</head>
<body class="admin-dashboard">

    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
    
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container-fluid px-4 py-4">
        <!-- Admin Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-4 mb-4 mb-md-0">
                <div class="admin-stat-card bg-primary-gradient animate__animated animate__fadeInLeft">
                    <div class="stat-icon">
                        <i class="bi bi-journal-bookmark"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${studyPlans != null ? studyPlans.size() : 0}</h3>
                        <p>Study Plans</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4 mb-md-0">
                <div class="admin-stat-card bg-success-gradient animate__animated animate__fadeInUp">
                    <div class="stat-icon">
                        <i class="bi bi-patch-question"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${quizzes != null ? quizzes.size() : 0}</h3>
                        <p>Quizzes</p>
                    </div>
                </div>
            </div>
            <!--  -->
            <div class="col-md-4">
                <div class="admin-stat-card bg-danger-gradient animate__animated animate__fadeInRight">
                    <div class="stat-icon">
                        <i class="bi bi-people"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${userCount}</h3>
                        <p>Users</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="admin-welcome-card animate__animated animate__fadeIn">
                    <div class="welcome-content">
                        <h1><i class="bi bi-shield-lock"></i> Admin Dashboard</h1>
                        <p>Welcome back, <span class="admin-username"><%= user.getUserName() %></span>. Manage your platform with ease.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Study Plans Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="admin-section-card animate__animated animate__fadeInUp">
                    <div class="section-header">
                        <h2><i class="bi bi-journal-bookmark"></i> Study Plans</h2>
                        <a href="AdminStudyPlanServlet" class="btn btn-admin-add">
                            <i class="bi bi-plus-lg"></i> Add New
                        </a>
                    </div>
                    <div class="section-body">
                        <div class="table-responsive">
                            <table class="table admin-table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Link</th>
                                        <th>Created At</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty studyPlans}">
                                            <tr>
                                                <td colspan="4" class="text-center py-4 empty-message">
                                                    <i class="bi bi-journal-x fs-1"></i>
                                                    <h4>No Study Plans Found</h4>
                                                    <a href="AdminStudyPlanServlet" class="btn btn-admin-primary mt-2">
                                                        <i class="bi bi-plus-lg"></i> Create First Plan
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${studyPlans}" var="plan">
                                                <tr id="studyPlanRow_${plan.studyPlanId}" class="admin-table-row">
                                                    <td class="fw-semibold">${plan.name}</td>
                                                    <td>
                                                        <a href="${plan.link}" target="_blank" class="resource-link">
                                                            <i class="bi bi-box-arrow-up-right"></i> View
                                                        </a>
                                                    </td>
                                                    <td>
                                                    	<fmt:parseDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                                        				<fmt:formatDate value="${parsedDate}" pattern="MMM dd, hh:mm a"/>
                                                    
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button id="editSPButton_${plan.studyPlanId}" onclick="editStudyPlan(${plan.studyPlanId})" 
                                                                    class="btn btn-admin-edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button id="saveSPButton_${plan.studyPlanId}" onclick="saveStudyPlan(${plan.studyPlanId})" 
                                                                    style="display:none;" class="btn btn-admin-save">
                                                                <i class="bi bi-check"></i>
                                                            </button>
                                                            <button id="cancelSPButton_${plan.studyPlanId}" onclick="cancelStudyPlanEdit(${plan.studyPlanId})" 
                                                                    style="display:none;" class="btn btn-admin-cancel">
                                                                <i class="bi bi-x"></i>
                                                            </button>
                                                            <button onclick="deleteStudyPlan(${plan.studyPlanId})" 
                                                                    class="btn btn-admin-delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quizzes Section -->
        <div class="row">
            <div class="col-12">
                <div class="admin-section-card animate__animated animate__fadeInUp">
                    <div class="section-header">
                        <h2><i class="bi bi-mortarboard"></i> Quizzes</h2>
                        <a href="AdminAddQuizServlet" class="btn btn-admin-add">
                            <i class="bi bi-plus-lg"></i> Add New
                        </a>
                    </div>
                    <div class="section-body">
                        <div class="table-responsive">
                            <table class="table admin-table">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Time Limit</th>
                                        <th>Created At</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty quizzes}">
                                            <tr>
                                                <td colspan="4" class="text-center py-4 empty-message">
                                                    <i class="bi bi-question-circle fs-1"></i>
                                                    <h4>No Quizzes Found</h4>
                                                    <a href="AdminAddQuizServlet" class="btn btn-admin-primary mt-2">
                                                        <i class="bi bi-plus-lg"></i> Create First Quiz
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${quizzes}" var="quiz">
                                                <tr id="quizRow_${quiz.quizId}" class="admin-table-row">
                                                    <td class="fw-semibold">${quiz.title}</td>
                                                    <td>${quiz.timeLimit} mins</td>
                                                    <td>
                                                    	<fmt:parseDate value="${quiz.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                                        				<fmt:formatDate value="${parsedDate}" pattern="MMM dd, hh:mm a"/>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button id="editQButton_${quiz.quizId}" onclick="editQuiz(${quiz.quizId})" 
                                                                    class="btn btn-admin-edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button id="saveQButton_${quiz.quizId}" onclick="saveQuiz(${quiz.quizId})" 
                                                                    style="display:none;" class="btn btn-admin-save">
                                                                <i class="bi bi-check"></i>
                                                            </button>
                                                            <button id="cancelQButton_${quiz.quizId}" onclick="cancelQuizEdit(${quiz.quizId})" 
                                                                    style="display:none;" class="btn btn-admin-cancel">
                                                                <i class="bi bi-x"></i>
                                                            </button>
                                                            <button onclick="deleteQuiz(${quiz.quizId})" 
                                                                    class="btn btn-admin-delete">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/pages/admin/js/dashboard.js?v2"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>