<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>


<%
	//Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("../../login");
        return;
    }
%>


<html>
<head>
    <title>User Dashboard</title>
</head>
<body>

	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>
	

    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Welcome, <%= user.getUserName() %>!</h1>
    
    <h2>Ongoing Study Plans</h2>
    <c:forEach items="${ongoingPlans}" var="plan">
        <div>
            <h3>${plan.name}</h3>
            <p>Status: ${plan.status}</p>
            <form action="UpdatePlanStatusServlet" method="post">
                <input type="hidden" name="planId" value="${plan.studyplanId}">
                <input type="submit" value="Mark Complete">
            </form>
        </div>
    </c:forEach>

    <h2>Leaderboard</h2>
    <table border="1">
        <tr>
            <th>Rank</th><th>Username</th><th>Score</th><th>Time Taken</th>
        </tr>
        <c:forEach items="${leaderboard}" var="entry">
            <tr>
                <td>${entry.rank}</td>
                <td>${entry.username}</td>
                <td>${entry.score}</td>
                <td>${entry.timeTaken} mins</td>
            </tr>
        </c:forEach>
    </table>
    
    
    
	<%-- 	<jsp:include page="../../components/sidebar.jsp"/>  --%>   
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>