<%@ page import="com.quizkar.entities.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% Users user = (Users) session.getAttribute("user"); %>

<link rel="stylesheet" href="components/css/nav-style.css">

<nav class="navbar">
    <div class="nav-container">
        <a class="nav-brand" href="./">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
            </svg>
            Quizkar
        </a>
        
        <button class="mobile-menu-btn" id="mobileMenuBtn" aria-label="Toggle navigation">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="3" y1="12" x2="21" y2="12"></line>
                <line x1="3" y1="6" x2="21" y2="6"></line>
                <line x1="3" y1="18" x2="21" y2="18"></line>
            </svg>
        </button>
        
        <ul class="nav-links" id="navLinks">
            <% if (user != null) { %>
                <% if ("user".equals(user.getRole())) { %>
                	<li><a class="nav-link" href="<%= (user != null && "admin".equals(user.getRole())) ? "admindashboard" : "UserDashboard" %>">Home</a></li>
                    <li><a class="nav-link" href="UserStudyPlanServlet">Study Plans</a></li>
                    <li><a class="nav-link" href="UserQuizzes">Quizzes</a></li>
                    <li><a class="nav-link" href="UserLeaderboard">Leaderboard</a></li>
                    <li><a class="nav-link" href="UserProfile">Profile</a></li>
                    <li><a class="nav-link" href="DeleteAccountServlet">Settings</a></li>
                <% } else if ("admin".equals(user.getRole())) { %>
                    <li><a class="nav-link" href="AdminStudyPlanServlet">Add Plans</a></li>
                    <li><a class="nav-link" href="AdminAddQuizServlet">Add Quizzes</a></li>
                <% } %>
                
                <li><a class="nav-link" href="LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a class="nav-link" href="login">Login</a></li>
                <li><a class="nav-link" href="register">Register</a></li>
            <% } %>
        </ul>
    </div>
</nav>

<script>
    // Enhanced mobile menu with touch support
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navLinks = document.getElementById('navLinks');
    const navItems = document.querySelectorAll('.nav-link');
    
    // Toggle mobile menu
    mobileMenuBtn.addEventListener('click', function() {
        navLinks.classList.toggle('active');
        mobileMenuBtn.setAttribute('aria-expanded', navLinks.classList.contains('active'));
    });
    
    // Handle touch/click events for links
    navItems.forEach(link => {
        // Add active class on touch/click
        link.addEventListener('touchstart', function() {
            this.classList.add('active');
        }, {passive: true});
        
        // Remove active class after delay for visual feedback
        link.addEventListener('touchend', function() {
            setTimeout(() => {
                this.classList.remove('active');
            }, 300);
        }, {passive: true});
        
        // Close menu when a link is clicked
        link.addEventListener('click', function() {
            navLinks.classList.remove('active');
            mobileMenuBtn.setAttribute('aria-expanded', 'false');
        });
    });
    
    // Close menu when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.nav-container') && navLinks.classList.contains('active')) {
            navLinks.classList.remove('active');
            mobileMenuBtn.setAttribute('aria-expanded', 'false');
        }
    });
</script>