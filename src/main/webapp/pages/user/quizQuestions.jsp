<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title>Quiz Session</title>
    <script>
        let totalTime = ${quiz.timeLimit} * 60; // Convert minutes to seconds
        let timeTaken = 0;
        
        function updateTimer() {
            let minutes = Math.floor(totalTime / 60);
            let seconds = totalTime % 60;

            // Format time display
            document.getElementById('timer').innerHTML = 
                (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

            if (totalTime <= 0) {
                clearInterval(timerInterval);
                document.getElementById('timeTaken').value = timeTaken;
                document.forms['quizForm'].submit();
            } else {
                totalTime--;
                timeTaken++;
            }
        }

        const timerInterval = setInterval(updateTimer, 1000);

        function submitQuiz() {
            clearInterval(timerInterval);
            document.getElementById('timeTaken').value = timeTaken;
            document.forms['quizForm'].submit();
        }
    </script>
</head>
<body>

    <%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
    %>

    <h1>${quiz.title}</h1>
    <p>Time Remaining: <span id="timer"></span></p>

    <form id="quizForm" action="SubmitQuizServlet" method="post">
        <input type="hidden" name="quizId" value="${quiz.quizId}">
        <input type="hidden" id="timeTaken" name="timeTaken" value="0"> <!-- Stores time taken -->

        <c:forEach items="${questions}" var="q" varStatus="loop">
            <div style="border: 1px solid black; padding: 10px; margin: 10px;">
                <p>${loop.index+1}. ${q.questionText}</p>
                <input type="radio" name="q${q.questionId}" value="A"> <c:out value='${q.optionA}'/> <br>
                <input type="radio" name="q${q.questionId}" value="B"> <c:out value='${q.optionB}'/> <br>
                <input type="radio" name="q${q.questionId}" value="C"> <c:out value='${q.optionC}'/> <br>
                <input type="radio" name="q${q.questionId}" value="D"> <c:out value='${q.optionD}'/> <br>
            </div>
        </c:forEach>

        <button type="button" onclick="submitQuiz()">Submit Quiz</button>
    </form>

</body>
</html>
