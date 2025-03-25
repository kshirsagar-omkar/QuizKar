<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - QuizKar</title>
</head>
<body>

	<div>
	    <h1>Login</h1>
	    <form action="login" method="post">
	    
	        <label for="role">Role:</label>
	        <select name="role" id="role">
	            <option value="user">User</option>
	            <option value="admin">Admin</option>
	        </select>
	        <br>
	
	        <!-- Accepts either Username or Email -->
	        <label for="identifier">Username or Email:</label>
	        <input type="text" name="identifier" id="identifier" required><br>
	
	        <label for="password">Password:</label>
	        <input type="password" name="password" id="password" required><br>
	
	        <input type="submit" value="Login">
	    </form>
		
		
		
		<!-- Display error message if login fails -->
		<% if(request.getAttribute("error") != null) { %>
			<div>
				<%= request.getAttribute("error") %>
			</div>
		<% } %>
		
		<div>
	    	<p>New user? <a href="register">Register here</a></p>
    	</div>
    </div>
</body>
</html>
