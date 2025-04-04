<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quizkar.entities.Users" %>

<% Users user = (Users) session.getAttribute("user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    
     <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css">
</head>
<body>

	<%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <!-- Navbar -->
    
    <jsp:include page="./components/navbar.jsp"/>
    

    <!-- Hero Section -->
    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Welcome to the Student Portal</h1>
                <p>Your one-stop solution for managing academic records, courses, and more.</p>
                <% if(user == null) { %>
                    <a href="login" class="btn btn-custom ms-2">Login to Continue</a>
                <% } else { %>
                    <a href="<%= "admin".equals(user.getRole()) ? "admindashboard" : "UserDashboard" %>" class="btn">Go to Dashboard</a>
                <% } %>
            </div>
        </section>
    </main>
    
    <!-- Bootstrap Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>