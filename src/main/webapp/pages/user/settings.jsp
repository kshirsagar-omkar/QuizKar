<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <title>Account Settings</title>
</head>
<body>

	<jsp:include page="../../components/cacheControl.jsp"/>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Account Settings</h1>
    <form action="DeleteAccountServlet" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        <input type="submit" value="Delete My Account" 
               onclick="return confirm('Are you sure you want to delete your account?')">
    </form>
</body>
</html>