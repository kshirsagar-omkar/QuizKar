<div>
    <a href="dashboard.jsp">Home</a>
    <c:if test="${user.role == 'user'}">
        <a href="studyPlans.jsp">Study Plans</a>
        <a href="quizzes.jsp">Quizzes</a>
    </c:if>
    <c:if test="${user.role == 'admin'}">
        <a href="manageStudyPlans.jsp">Manage Plans</a>
        <a href="manageQuizzes.jsp">Manage Quizzes</a>
    </c:if>
    <a href="profile.jsp">Profile</a>
    <a href="LogoutServlet">Logout</a>
</div>