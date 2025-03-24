<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Study Plans</title>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Available Study Plans</h1>
    <c:forEach items="${allStudyPlans}" var="plan">
        <div>
            <h3>${plan.name}</h3>
            <form action="EnrollPlanServlet" method="post">
                <input type="hidden" name="planId" value="${plan.studyplanId}">
                <input type="submit" value="Enroll">
            </form>
        </div>
    </c:forEach>
</body>
</html>