<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Profile</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Profile Details</h1>
    <p>Username: ${user.userName}</p>
    <p>Email: ${user.email}</p>
    <p>Role: ${user.role}</p>
    <a href="editProfile.jsp">Edit Profile</a>
</body>
</html>