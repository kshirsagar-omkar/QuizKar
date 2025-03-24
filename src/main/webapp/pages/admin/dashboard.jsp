<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Admin Dashboard</h1>
    
    <h2>Study Plans</h2>
    <c:forEach items="${studyPlans}" var="plan">
        <div>
            <h3>${plan.name}</h3>
            <form action="DeletePlanServlet" method="post" style="display:inline">
                <input type="hidden" name="planId" value="${plan.studyplanId}">
                <input type="submit" value="Delete">
            </form>
            <a href="editStudyPlan.jsp?id=${plan.studyplanId}">Edit</a>
        </div>
    </c:forEach>
    
    <h2>Quizzes</h2>
    <c:forEach items="${quizzes}" var="quiz">
        <div>
            <h3>${quiz.title}</h3>
            <form action="DeleteQuizServlet" method="post">
                <input type="hidden" name="quizId" value="${quiz.quizId}">
                <input type="submit" value="Delete">
            </form>
        </div>
    </c:forEach>
</body>
</html>