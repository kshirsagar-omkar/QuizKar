<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% if(session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
} %>

<html>
<head>
    <title>Create New Quiz</title>
    <script>
        function addQuestion() {
            const container = document.getElementById("questions");
            const newQuestion = document.createElement("div");
            newQuestion.innerHTML = `
                <h3>New Question</h3>
                Question: <input type="text" name="questionText" required><br>
                Option A: <input type="text" name="optionA" required><br>
                Option B: <input type="text" name="optionB" required><br>
                Option C: <input type="text" name="optionC" required><br>
                Option D: <input type="text" name="optionD" required><br>
                Correct Answer: 
                <select name="correctAnswer" required>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select><br>
            `;
            container.appendChild(newQuestion);
        }
    </script>
</head>
<body>
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Create New Quiz</h1>
    <form action="AddQuizServlet" method="post">
        Title: <input type="text" name="title" required><br>
        Time Limit: <input type="number" name="timeLimit" required> mins<br>
        
        <div id="questions">
            <h2>Questions</h2>
            <div>
                <h3>Question 1</h3>
                Question: <input type="text" name="questionText" required><br>
                Option A: <input type="text" name="optionA" required><br>
                Option B: <input type="text" name="optionB" required><br>
                Option C: <input type="text" name="optionC" required><br>
                Option D: <input type="text" name="optionD" required><br>
                Correct Answer: 
                <select name="correctAnswer" required>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select><br>
            </div>
        </div>
        
        <button type="button" onclick="addQuestion()">Add Another Question</button>
        <input type="submit" value="Create Quiz">
    </form>
</body>
</html>