<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Available Quizzes</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Quizzes</h1>
    <c:forEach items="${availableQuizzes}" var="quiz">
        <div>
            <h3>${quiz.title}</h3>
            <p>Time Limit: ${quiz.timeLimit} mins</p>
            <form action="StartQuizServlet" method="post">
                <input type="hidden" name="quizId" value="${quiz.quizId}">
                <input type="submit" value="Start Quiz">
            </form>
        </div>
    </c:forEach>
</body>
</html>