<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Dashboard</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
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