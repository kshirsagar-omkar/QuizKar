<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
    
</head>
<body>

	<jsp:include page="../../components/cacheControl.jsp"/>
    <!-- Navbar Include -->
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Welcome, Admin <%= user.getUserName() + " (ID: " + user.getUserId() + ")" %>!</h1>
    <h1>Admin Dashboard</h1>
    
    <!-- Study Plans Section -->
    <h2>Study Plans</h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Link</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        
        <% if( request.getAttribute("studyPlans") == null ) {%>
        	<tr>
				<td colspan="4" >
					No Study Plans Found !!
				</td>
			</tr>
		<%} else { %>
        
	        <c:forEach items="${studyPlans}" var="plan">
	            <tr id="studyPlanRow_${plan.studyPlanId}">
	                <td>${plan.name}</td>
	                <td>
	                    <a href="${plan.link}" target="_blank">click here</a>
	                </td>
	                <td>${plan.createdAt}</td>
	                <td>
	                    <button id="editSPButton_${plan.studyPlanId}" onclick="editStudyPlan(${plan.studyPlanId})">Edit</button>
	                    <button id="saveSPButton_${plan.studyPlanId}" onclick="saveStudyPlan(${plan.studyPlanId})" style="display:none;">Save</button>
	                    <button id="cancelSPButton_${plan.studyPlanId}" onclick="cancelStudyPlanEdit(${plan.studyPlanId})" style="display:none;">Cancel</button>
	                    <button onclick="deleteStudyPlan(${plan.studyPlanId})">Delete</button>
	                </td>
	            </tr>
	        </c:forEach>
        <%} %>
        
    </table>
    
    <!-- Quizzes Section -->
    <h2>Quizzes</h2>
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Time Limit</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        
        
        <% if( request.getAttribute("quizzes") == null ) {%>
        	<tr>
				<td colspan="4" >
					No Quizzes Found !!
				</td>
			</tr>
		<%} else { %>
        
	        <c:forEach items="${quizzes}" var="quiz">
	            <tr id="quizRow_${quiz.quizId}">
	                <td>${quiz.title}</td>
	                <td>${quiz.timeLimit} mins</td>
	                <td>${quiz.createdAt}</td>
	                <td>
	                	<button id="editQButton_${quiz.quizId}" onclick="editQuiz(${quiz.quizId})">Edit</button>
	                    <button id="saveQButton_${quiz.quizId}" onclick="saveQuiz(${quiz.quizId})" style="display:none;">Save</button>
	                    <button id="cancelQButton_${quiz.quizId}" onclick="cancelQuizEdit(${quiz.quizId})" style="display:none;">Cancel</button>
	                    <button onclick="deleteQuiz(${quiz.quizId})">Delete</button>
	                </td>
	            </tr>
	        </c:forEach>
        <%} %>


    </table>
    
    
  
    <script src="./pages/admin/js/dashboard.js"> </script>
</body>
</html>
