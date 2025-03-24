<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% if(session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
} %>

<html>
<head>
    <title>Quiz Session</title>
    <script>
        let timeLeft = ${quiz.timeLimit};
        const timer = setInterval(() => {
            document.getElementById('timer').innerHTML = timeLeft--;
            if(timeLeft < 0) {
                clearInterval(timer);
                document.forms['quizForm'].submit();
            }
        }, 60000);
    </script>
</head>
<body>
    <h1>${quiz.title}</h1>
    <p>Time Remaining: <span id="timer">${quiz.timeLimit}</span> minutes</p>
    
    <form id="quizForm" action="SubmitQuizServlet" method="post">
        <input type="hidden" name="quizId" value="${quiz.quizId}">
        <c:forEach items="${questions}" var="q" varStatus="loop">
            <div>
                <p>${loop.index+1}. ${q.questionText}</p>
                <input type="radio" name="q${q.questionId}" value="A"> ${q.optionA}<br>
                <input type="radio" name="q${q.questionId}" value="B"> ${q.optionB}<br>
                <input type="radio" name="q${q.questionId}" value="C"> ${q.optionC}<br>
                <input type="radio" name="q${q.questionId}" value="D"> ${q.optionD}<br>
            </div>
        </c:forEach>
        <input type="submit" value="Submit Quiz">
    </form>
</body>
</html>