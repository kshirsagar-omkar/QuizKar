<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>

<html>
<head>
    <title>Create New Quiz</title>
</head>
<body>

	<%
	//Prevent Browsing from caching the page
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // Proxies
	%>


    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Create New Quiz</h1>
    <form onsubmit="submitQuiz(event)">
        <label>Title:</label> <input type="text" id="quizTitle" required><br>
        <label>Time Limit:</label> <input type="number" id="timeLimit" required> mins<br>
		
		<input type="hidden" value = "<%=user.getUserId()%>" id="adminId">

        <div id="questions">
            <h2>Questions</h2>
            <div class="question-block">
                <h3>Question 1</h3>
                <label>Question:</label> <input type="text" class="questionText" required><br>
                <label>Option A:</label> <input type="text" class="optionA" required><br>
                <label>Option B:</label> <input type="text" class="optionB" required><br>
                <label>Option C:</label> <input type="text" class="optionC" required><br>
                <label>Option D:</label> <input type="text" class="optionD" required><br>
                <label>Correct Answer:</label>
                <select class="correctAnswer" required>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select><br>
                <hr>
            </div>
        </div>

        <button type="button" onclick="addQuestion()">Add Another Question</button>
        <input type="submit" value="Create Quiz">
    </form>
    
    
    <script src="./pages/admin/js/addQuiz.js" ></script>
</body>
</html>
