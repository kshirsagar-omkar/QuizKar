<%@ page import="com.quizkar.entities.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Get user from session
    Users user = (Users) session.getAttribute("user");
%>

<div>
    <%--     --%>
    
    <a href="<%= (user != null && "admin".equals(user.getRole())) ? "admindashboard" : "UserDashboard" %>">Home</a>
    
    <%--	 <a href="dashboard.jsp">Home</a>	--%>
    
   
    
    <% if (user != null) { %>
        <% if ("user".equals(user.getRole())) { %>
            <!-- User Links -->
            <a href="UserStudyPlanServlet">Study Plans</a>
            <a href="pages/user/quizzes.jsp">Quizzes</a>
            <a href="pages/user/profile.jsp">Profile</a>
        <% } else if ("admin".equals(user.getRole())) { %>
            <!-- Admin Links -->
            <a href="AdminStudyPlanServlet">Add Plans</a>
            <a href="AdminAddQuizServlet">Add Quizzes</a>
        <% } %>
        
        <%-- 	<a href="pages/user/profile.jsp">Profile</a>	 --%>
        
        <a href="LogoutServlet">Logout</a>
    <% } else { %>
        <!-- If no user is logged in -->
        <a href="login">Login</a>
        <a href="register">Register</a>
    <% } %>
</div>
