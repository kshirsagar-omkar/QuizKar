<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Leaderboard - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Leaderboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaderboard.css?v2">
</head>
<body class="leaderboard-page">

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container py-4">
        <div class="row">
            <div class="col-12">
                <div class="leaderboard-header animate__animated animate__fadeInDown">
                    <h1><i class="bi bi-trophy-fill"></i> Quiz Leaderboard</h1>
                    <p>See how you rank against other participants</p>
                </div>
                
                <!-- Search and Filter -->
                <div class="leaderboard-search animate__animated animate__fadeIn">
                    <form id="searchForm" action="UserLeaderboard" method="GET" class="search-form">
                        <div class="input-group">
                            <input type="text" class="form-control" id="searchInput" name="filter" placeholder="Search quizzes..." value="${param.filter}">
                            <button class="btn btn-search" type="submit" name="btn" value="search">
                                <i class="bi bi-search"></i> Search
                            </button>
                            <button class="btn btn-reset" type="button" id="resetButton">
                                <i class="bi bi-arrow-clockwise"></i> Refresh
                            </button>
                        </div>
                    </form>
                </div>
                
                <c:choose>
                    <c:when test="${empty leaderboard}">
                        <div class="no-results animate__animated animate__fadeIn">
                            <i class="bi bi-emoji-frown"></i>
                            <h3>No results found</h3>
                            <p>Try a different search term</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="leaderboard-container">
                            <c:set var="lastQuizTitle" value="" />
                            <c:set var="quizCount" value="0" />
                            
                            <c:forEach var="entry" items="${leaderboard}">
                                <c:if test="${entry.quizTitle ne lastQuizTitle}">
                                    <c:if test="${lastQuizTitle ne ''}">
                                        </div> <!-- Close leaderboard-table -->
                                        <!-- Quiz Separator -->
                                        <div class="quiz-separator">
                                            <div class="separator-line"></div>
                                            <div class="separator-icon">
                                                <i class="bi bi-stars"></i>
                                            </div>
                                            <div class="separator-line"></div>
                                        </div>
                                    </c:if>
                                    
                                    <c:set var="quizCount" value="${quizCount + 1}" />
                                    <div class="quiz-section animate__animated animate__fadeInUp" style="animation-delay: ${quizCount * 0.1}s">
                                        <div class="quiz-header">
                                            <h2><i class="bi bi-mortarboard"></i> ${entry.quizTitle}</h2>
                                            <span class="badge">${entry.timeLimit} mins</span>
                                        </div>
                                        
                                        <div class="leaderboard-table">
                                            <div class="table-header">
                                                <div class="rank-col">Rank</div>
                                                <div class="user-col">User</div>
                                                <div class="score-col">Score</div>
                                                <div class="date-col">Date</div>
                                                <div class="time-col">Time Taken</div>
                                            </div>
                                            
                                            <c:set var="lastQuizTitle" value="${entry.quizTitle}" />
                                </c:if>
                                
                                <div class="table-row ${entry.username eq user.userName ? 'current-user' : ''}">
                                    <div class="rank-col">
                                        <c:choose>
                                            <c:when test="${entry.rank == 1}">
                                                <span class="rank first"><i class="bi bi-trophy-fill"></i> ${entry.rank}</span>
                                            </c:when>
                                            <c:when test="${entry.rank == 2}">
                                                <span class="rank second"><i class="bi bi-award-fill"></i> ${entry.rank}</span>
                                            </c:when>
                                            <c:when test="${entry.rank == 3}">
                                                <span class="rank third"><i class="bi bi-award-fill"></i> ${entry.rank}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="rank">${entry.rank}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="user-col">
                                        <c:if test="${entry.username eq user.userName}">
                                            <i class="bi bi-person-fill"></i> <strong>You</strong>
                                        </c:if>
                                        <c:if test="${entry.username ne user.userName}">
                                            ${entry.username}
                                        </c:if>
                                    </div>
                                    <div class="score-col">${entry.score}</div>
                                    <div class="date-col">
                                        <fmt:parseDate value="${entry.participationDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="MMM dd, hh:mm a"/>
                                    </div>
                                    <div class="time-col">
                                        ${entry.timeTaken} mins
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <c:if test="${not empty leaderboard}">
                                        </div> <!-- Close leaderboard-table -->
                                    </div> <!-- Close quiz-section -->
                                </div> <!-- Close leaderboard-container -->
                            </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JS -->
    <script>
        // Clear search field on refresh
        document.getElementById('resetButton').addEventListener('click', function() {
            document.getElementById('searchInput').value = '';
            document.getElementById('searchForm').submit();
        });
    </script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>