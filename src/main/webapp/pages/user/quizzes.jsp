<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.quizkar.entities.Users" %>


<%
	//Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
    	response.sendRedirect("login");
    }
%>


<html>
<head>
    <title>Available Quizzes</title>
</head>
<body>

	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>
	

    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Quizzes</h1>
    <% if(request.getAttribute("quizzes") == null) {%>
    	<h3>No Quizes Available</h3>
    <%} else{ %>
    
	    <c:forEach items="${quizzes}" var="quiz">
	        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
	            <h3>${quiz.title}</h3>
	            <p>Time Limit: ${quiz.timeLimit} mins</p>
	            <form action="UserStartQuiz" method="post">
	                <input type="hidden" name="quizId" value="${quiz.quizId}">
	                <input type="hidden" name="quizTitle" value="${quiz.title}">
	                <input type="hidden" name="quizTimeLimit" value="${quiz.timeLimit}">
	                <input type="submit" value="Start Quiz">
	            </form>
	        </div>
	    </c:forEach>
    <%} %>
    
</body>
</html>