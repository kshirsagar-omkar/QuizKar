<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Leaderboard</title>
</head>
<body>

	<%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>

    <h1>Global Leaderboard</h1>

    <c:set var="lastQuizTitle" value="" />

    <c:forEach var="entry" items="${leaderboard}">
        <!-- Check if we need to create a new table for a different quiz -->
        <c:if test="${entry.quizTitle ne lastQuizTitle}">
            <c:if test="${lastQuizTitle ne ''}">
                </table> <!-- Close the previous table if not the first quiz -->
            </c:if>

            <h2>Quiz: <c:out value="${entry.quizTitle}" /></h2>
            <table border="1">
                <tr>
                    <th>Rank</th>
                    <th>Username</th>
                    <th>Score</th>
                    <th>Participation Date</th>
                    <th>Time Limit</th>
                    <th>Time Taken</th>
                </tr>

            <!-- Update the lastQuizTitle variable -->
            <c:set var="lastQuizTitle" value="${entry.quizTitle}" />
        </c:if>

        <!-- Display leaderboard entry -->
        <tr>
            <td><c:out value="${entry.rank}" /></td>
            <td><c:out value="${entry.username}" /></td>
            <td><c:out value="${entry.score}" /></td>
            <td><c:out value="${entry.participationDate}" /></td>
            <td><c:out value="${entry.timeLimit}" /></td>
            <td><c:out value="${entry.timeTaken}" /></td>
        </tr>

    </c:forEach>

    <!-- Close the last table -->
    <c:if test="${not empty leaderboard}">
        </table>
    </c:if>
    

</body>
</html>
