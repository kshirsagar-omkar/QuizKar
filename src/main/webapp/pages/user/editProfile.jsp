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
    <title>Edit Profile</title>
</head>
<body>

	<jsp:include page="../../components/cacheControl.jsp"/>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Edit Profile</h1>
    <form action="UpdateProfileServlet" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        Username: <input type="text" name="username" value="${user.userName}" required><br>
        Email: <input type="email" name="email" value="${user.email}" required><br>
        Password: <input type="password" name="password" placeholder="New password"><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>