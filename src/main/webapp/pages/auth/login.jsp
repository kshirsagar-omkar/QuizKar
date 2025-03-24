<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - QuizKar</title>
</head>
<body>
    <h1>Login</h1>
    <form action="LoginServlet" method="post">
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <p>New user? <a href="register.jsp">Register here</a></p>
</body>
</html>