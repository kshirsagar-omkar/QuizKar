<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.quizkar.entities.Users" %>

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
    <title>Edit Profile</title>
</head>
<body>

    <%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
    %>

    <jsp:include page="../../components/navbar.jsp"/>

    <h1>Edit Profile</h1>

    <!-- Step 1: Verify User Credentials -->
    <div id="verifySection">
        <h3>Verify Your Credentials</h3>
        <p style="color: red;" id="errorMessage"></p>
        <input type="hidden" id="username" value="${user.userName}">
        Password: <input type="password" id="password" required><br>
        <button onclick="validateCredentials(<%= user.getUserId() %>)">Verify</button>
    </div>

    <!-- Step 2: Edit Profile (Initially Hidden) -->
    <div id="editSection" style="display: none;">
        <h3>Edit Your Profile</h3>
        New Username: <input type="text" id="newUsername" value="${user.userName}" required><br>
        New Email: <input type="email" id="newEmail" value="${user.email}" required><br>
        New Password: 
			<input type="password" id="newPassword" value="#" required>
			<input type="checkbox" onclick="togglePassword()"> Show Password
			<br>
        <button onclick="updateProfile(<%= user.getUserId() %>)">Update Profile</button>
    </div>



	<script src="./pages/user/js/editProfile.js"> </script>
</body>
</html>
