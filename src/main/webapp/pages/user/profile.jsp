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
    <title>User Profile</title>
</head>
<body>
	
	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>
	
    
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Profile Details</h1>
    <p>Username: ${user.userName}</p>
    <p>Email: ${user.email}</p>
    <p>Role: ${user.role}</p>
    <a href="UserEditProfile">Edit Profile</a>
</body>
</html>