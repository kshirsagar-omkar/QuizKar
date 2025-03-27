<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Add Study Plan</title>
</head>
<body>

	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>

 
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div>
    	<h1>Create New Study Plan</h1>
    	
    	<div>
	        Name: <input type="text" name="studyPlanName" required id="studyPlanName"><br>
	        Link: <input type="text" name="studyPlanLink" required id="studyPlanLink"><br>
	        
	        <input type="button" name="addStudyPlanBtn" value="Add StudyPlan" onclick="addStudyPlan(<%= user.getUserId() %>)" >
        </div>
        
	</div>
    
    
    <script src="./pages/admin/js/addStudyPlan.js"> </script>
    
</body>
</html>