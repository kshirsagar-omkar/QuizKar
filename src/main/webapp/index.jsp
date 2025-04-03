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
</head>
<body>
    <!-- Navbar -->
    <header>
        <div class="container">
            <h2>Student Portal</h2>
            <nav>
                <ul>
                    <li><a href="#">Home</a></li>
                    <% if(user != null) { %>
                        <li><a href="<%= "admin".equals(user.getRole()) ? "admindashboard" : "UserDashboard" %>">DashBoard</a></li>
                        <li><a href="LogoutServlet">Logout</a></li>
                    <% } else { %>
                        <li><a href="register">Register</a></li>
                        <li><a href="login">Login</a></li>
                    <% } %>
                    <li><a href="#">About</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Welcome to the Student Portal</h1>
                <p>Your one-stop solution for managing academic records, courses, and more.</p>
                <% if(user == null) { %>
                    <a href="login" class="btn">Login to Continue</a>
                <% } else { %>
                    <a href="<%= "admin".equals(user.getRole()) ? "admindashboard" : "UserDashboard" %>" class="btn">Go to Dashboard</a>
                <% } %>
            </div>
        </section>
    </main>
</body>
</html>