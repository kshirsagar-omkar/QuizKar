<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>

<html>
<head>
    <title>Study Plans</title>
    <script>
        function enrollInStudyPlan(planId, userId){

            let params = new URLSearchParams({
                planId: planId,
                userId: userId,
                action: "enroll"
            });

            fetch("UserStudyPlanServlet", {
                method: "POST",
                body: params
            })
            .then(response => response.text())
            .then(data => {
                if (data.trim() === "success") {
                    alert("Enrolled Successfully!");
                    location.reload(); // Refresh the page to reflect changes
                } else if( data.trim() === "alreadyEnrolled" ){
                	alert("Already Enrolled");
                }else {
                    alert("Failed to enroll. Please try again.");
                }
            })
            .catch(error => console.error("Error enrolling in study plan:", error));
        }
    </script>
</head>
<body>

    <%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
    %>

    <jsp:include page="../../components/navbar.jsp"/>

    <h1>Available Study Plans</h1>
    <c:forEach items="${studyPlans}" var="plan">
        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <h3>${plan.name}</h3>
            <p>Created At: 
                <fmt:parseDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both"/>
                <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy - hh:mm a"/>
            </p>
            <p>Link: <a href="${plan.link}" target="_blank">${plan.link}</a></p>
            <button onclick="enrollInStudyPlan(${plan.studyPlanId}, '<%= user.getUserId() %>')">Enroll</button>
        </div>
    </c:forEach>

</body>
</html>
