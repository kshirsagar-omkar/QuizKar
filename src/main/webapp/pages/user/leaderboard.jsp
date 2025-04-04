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
    <title>Leaderboard - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Leaderboard-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaderboard.css">
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
                        <h1 class="h3 mb-0"><i class="bi bi-trophy-fill me-2"></i>Global Leaderboard</h1>
                    </div>
                    <div class="card-body">
                        <!-- Search form -->
                        <form action="UserLeaderboard" method="GET" class="mb-4">
                            <div class="input-group">
                                <input type="text" class="form-control" name="filter" placeholder="Search by quiz title..." value="${param.filter}">
                                <button class="btn btn-outline-secondary" type="submit" name="btn" value="search">
                                    <i class="bi bi-search"></i> Search
                                </button>
                                <button class="btn btn-secondary" type="submit" name="btn" value="resfresh">
                                    <i class="bi bi-arrow-clockwise"></i> Refresh
                                </button>
                            </div>
                        </form>
                        
                        
                        
                        
                        <c:choose>
                            <c:when test="${empty leaderboard}">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle-fill me-2"></i>
                                    No records found for "<c:out value='${param.filter}'/>". Try another search.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:set var="lastQuizTitle" value="" />

                                <c:forEach var="entry" items="${leaderboard}">
                                    <!-- Check if we need to create a new table for a different quiz -->
                                    <c:if test="${entry.quizTitle ne lastQuizTitle}">
                                        <c:if test="${lastQuizTitle ne ''}">
                                            </table> <!-- Close the previous table if not the first quiz -->
                                            </div> <!-- Close card -->
                                        </c:if>

                                        <div class="card mb-4">
                                            <div class="card-header bg-light">
                                                <h2 class="h4 mb-0"><i class="bi bi-patch-question-fill me-2"></i><c:out value="${entry.quizTitle}" /></h2>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>Rank</th>
                                                                <th>Username</th>
                                                                <th>Score</th>
                                                                <th>Date</th>
                                                                <th>Time Limit</th>
                                                                <th>Time Taken</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                        <!-- Update the lastQuizTitle variable -->
                                        <c:set var="lastQuizTitle" value="${entry.quizTitle}" />
                                    </c:if>

                                    <!-- Display leaderboard entry -->
                                    <tr class="${entry.username eq user.userName ? 'table-primary' : ''}">
                                        <td>
                                            <c:choose>
                                                <c:when test="${entry.rank == 1}">
                                                    <span class="badge bg-warning text-dark"><i class="bi bi-trophy-fill"></i> ${entry.rank}</span>
                                                </c:when>
                                                <c:when test="${entry.rank == 2}">
                                                    <span class="badge bg-secondary"><i class="bi bi-award-fill"></i> ${entry.rank}</span>
                                                </c:when>
                                                <c:when test="${entry.rank == 3}">
                                                    <span class="badge bg-danger"><i class="bi bi-award-fill"></i> ${entry.rank}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${entry.rank}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${entry.username eq user.userName}">
                                                <strong><i class="bi bi-person-fill"></i> ${entry.username}</strong>
                                            </c:if>
                                            <c:if test="${entry.username ne user.userName}">
                                                ${entry.username}
                                            </c:if>
                                        </td>
                                        <td>${entry.score}</td>
                                        <td>
                                        	 <p>  
							                	<fmt:parseDate value="${entry.participationDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
						                		<fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy - hh:mm a"/>
						                	</p>	
                                        </td>
                                        <td>${entry.timeLimit} mins</td>
                                        <td>${entry.timeTaken} mins</td>
                                    </tr>

                                </c:forEach>

                                <!-- Close the last table -->
                                <c:if test="${not empty leaderboard}">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>