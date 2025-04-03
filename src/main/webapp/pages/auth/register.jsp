<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - QuizKar</title>
</head>
<body>

	<jsp:include page="../../components/navbar.jsp"/>
	
	<div>
	
	    <h1>User Registration</h1>
	    <form action="register" method="post">
	        Username: <input type="text" name="username" required><br>
	        Email: <input type="email" name="email" required><br>
	        Password: <input type="password" name="password" required><br>
	        <input type="hidden" name="role" value="user">
	        <input type="submit" value="Register">
	    </form>
	    
	    <!-- Display error message if registration fails -->
	    <% if (request.getAttribute("error") != null) { %>
	    <div>
	        <%= request.getAttribute("error") %>
	    </div>
	    <% } %>
	    
	    <div>
	    	<p>Already have an account? <a href="login">Login here</a></p>
		</div>
		
	</div>
</body>
</html>