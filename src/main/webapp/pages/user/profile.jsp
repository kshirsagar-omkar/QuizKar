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
    <title>User Profile</title>
</head>
<body>
	
	<jsp:include page="../../components/cacheControl.jsp"/>
    
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Profile Details</h1>
    <p>Username: ${user.userName}</p>
    <p>Email: ${user.email}</p>
    <p>Role: ${user.role}</p>
    <a href="editProfile.jsp">Edit Profile</a>
</body>
</html>