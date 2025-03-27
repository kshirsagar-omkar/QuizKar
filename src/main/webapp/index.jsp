<%--

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("user") != null) {
        if("admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            response.sendRedirect("user/dashboard.jsp");
        }
    } else {
        response.sendRedirect("login");
    }
%>

 --%>







<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal</title>
</head>
<body>

<!-- Navbar -->
<div>
    <h2>Student Portal</h2>
    <nav>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="register">Register</a></li>
            <li><a href="login">Login</a></li>
            <li><a href="#">About</a></li>
        </ul>
    </nav>
</div>

<!-- Hero Section -->
<div>
    <h1>Welcome to the Student Portal</h1>
    <p>Your one-stop solution for managing academic records, courses, and more.</p>
    <a href="login">Login to Continue</a>
</div>


</body>
</html>
