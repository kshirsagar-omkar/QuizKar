<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Study Plan</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Create New Study Plan</h1>
    <form action="AddStudyPlanServlet" method="post">
        Name: <input type="text" name="name" required><br>
        Link: <input type="text" name="link" required><br>
        <input type="submit" value="Create Plan">
    </form>
</body>
</html>