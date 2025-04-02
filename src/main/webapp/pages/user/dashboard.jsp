<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <title>User Dashboard</title>
</head>
<body>

    <%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>

   <h1>Welcome, <%= user.getUserName() %>!</h1>
	
	<!-- Ongoing Study Plans -->
	<div id="ongoing-study-plans">
	    <h2>Ongoing Study Plans</h2>
	    <% if (request.getAttribute("ongoingStudyPlans") == null) { %>
	        <h2 style="text-align:center;">No ongoing Study Plans</h2>
	    <% } else { %>
	        <c:forEach items="${ongoingStudyPlans}" var="plan">
	            <div style="border: 1px solid black; padding: 10px; margin: 10px;">
	                <h3>${plan.name}</h3>
	                <p>Status: ${plan.status}</p>
	                <p>Link: <a href="${plan.link}" target="_blank">Click Here</a></p>
	                <button onclick="updateStudyPlanStatus(${plan.studyPlanId}, this, <%= user.getUserId() %>)" value="complete">Mark Complete</button>
	            </div>
	        </c:forEach>
	    <% } %>
	</div>
	
	<!-- Completed Study Plans -->
	<div id="completed-study-plans">
	    <h2>Completed Study Plans</h2>
	    <% if (request.getAttribute("completedStudyPlans") == null) { %>
	        <h2 style="text-align:center;">No completed Study Plans</h2>
	    <% } else { %>
	        <c:forEach items="${completedStudyPlans}" var="plan">
	            <div style="border: 1px solid black; padding: 10px; margin: 10px;">
	                <h3>${plan.name}</h3>
	                <p>Status: ${plan.status}</p>
	                <p>Link: <a href="${plan.link}" target="_blank">Click Here</a></p>
	                <button onclick="updateStudyPlanStatus(${plan.studyPlanId}, this, <%= user.getUserId() %>)" value="not_complete">Mark Incomplete</button>
	            </div>
	        </c:forEach>
	    <% } %>
	</div>
	
	<!-- Completed Quizzes -->
	<div id="completed-quizzes">
	    <h2>Completed Quizzes</h2>
	    <% if (request.getAttribute("completedQuizzes") == null) { %>
	        <h2 style="text-align:center;">No completed quizzes</h2>
	    <% } else { %>
	        <c:forEach items="${completedQuizzes}" var="quiz">
	            <div style="border: 1px solid black; padding: 10px; margin: 10px;">
	                <h3>${quiz.quizTitle}</h3>
	                <p>Time Limit: ${quiz.quizTimeLimit} mins</p>
	                <p>Score: ${quiz.leaderBoardScore}</p>
	                <p>Participation Date:  
	                	<fmt:parseDate value="${quiz.leaderBoardParticipationDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                		<fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy - hh:mm a"/>
                	</p>	                
	                <p>Time Taken: ${quiz.leaderBoardTimeTaken} mins</p>
	            </div>
	        </c:forEach>
	    <% } %>
	</div>
	
	    
    
    
	<script src="./pages/user/js/dashboard.js"> </script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>
