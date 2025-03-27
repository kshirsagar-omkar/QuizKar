<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.quizkar.entities.Users" %>


<%
	//Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
    	response.sendRedirect("../../login");
    }
%>


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

	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>
	

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