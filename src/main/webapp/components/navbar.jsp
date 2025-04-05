<%@ page import="com.quizkar.entities.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% Users user = (Users) session.getAttribute("user"); %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="./">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="me-2">
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
      </svg>
      Quizkar
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <% if (user != null) { %>
          <li class="nav-item">
            <a class="nav-link" href="<%= ("admin".equals(user.getRole())) ? "admindashboard" : "UserDashboard" %>">Dashboard</a>
          </li>
          <% if ("user".equals(user.getRole())) { %>
            <li class="nav-item"><a class="nav-link" href="UserStudyPlanServlet">Study Plans</a></li>
            <li class="nav-item"><a class="nav-link" href="UserQuizzes">Quizzes</a></li>
            <li class="nav-item"><a class="nav-link" href="UserLeaderboard">Leaderboard</a></li>
            <li class="nav-item"><a class="nav-link" href="UserProfile">Profile</a></li>
            <li class="nav-item"><a class="nav-link" href="DeleteAccountServlet">Settings</a></li>
          <% } else if ("admin".equals(user.getRole())) { %>
            <li class="nav-item"><a class="nav-link" href="AdminStudyPlanServlet">Add Plans</a></li>
            <li class="nav-item"><a class="nav-link" href="AdminAddQuizServlet">Add Quizzes</a></li>
          <% } %>
        <% } else { %>
           <li class="nav-item"><a class="nav-link" href="AboutUs">About Us</a></li>
         <% } %>
      </ul>
      
      <ul class="navbar-nav">
        <% if (user != null) { %>
          <li class="nav-item">
            <a class="nav-link" href="LogoutServlet">Logout</a>
          </li>
        <% } else { %>
          <li class="nav-item">
            <a class="nav-link" href="login">Login</a>
          </li>
          <li class="nav-item">
            <a class="btn btn-custom ms-2" href="register">Register</a>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>