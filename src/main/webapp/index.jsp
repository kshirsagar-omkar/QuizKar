<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hello World JSTL Example</title>
</head>
<body>

<h2>Printing Hello World 10 times using JSTL:</h2>

<c:forEach var="i" begin="1" end="10">
    <p>${i}. Hello World</p>
</c:forEach>

</body>
</html>
