<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Quiz Session</title>
    <script>
	    let totalTime = ${quiz.timeLimit} * 60; // Convert minutes to seconds
	    let timeTakenSeconds = 0; // Track time taken in seconds
	
	    function updateTimer() {
	        let minutes = Math.floor(totalTime / 60);
	        let seconds = totalTime % 60;
	
	        document.getElementById('timer').innerText = 
	            (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
	
	        if (totalTime <= 0) {
	            clearInterval(timerInterval);
	            submitQuiz(); // Auto-submit on timeout
	        } else {
	            totalTime--;
	            timeTakenSeconds++; // Increment time taken in seconds
	        }
	    }
	
	    const timerInterval = setInterval(updateTimer, 1000);
	
	    function submitQuiz() {
	        clearInterval(timerInterval); // Stop the timer
	
	        // Convert seconds to whole minutes (round up)
	        let timeTakenMinutes = Math.ceil(timeTakenSeconds / 60);
	
	        let quizData = {
	            userId: ${user.userId},
	            quizId: ${quiz.quizId},
	            timeTaken: timeTakenMinutes, // Send rounded minutes
	            answers: {}
	        };
	
	        // Collect user-selected answers
	        document.querySelectorAll("input[type=radio]:checked").forEach((radio) => {
	            quizData.answers[radio.name] = radio.value; // Store { questionId: answer }
	        });
	
	        // Send JSON to the servlet
	        fetch("UserSubmitQuiz", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify(quizData)
	        })
	        .then(response => response.text())
	        .then(data => {
	            if (data.trim() === "success") {
	                alert("Quiz submitted successfully!");
	                window.location.href = "UserDashboard"; // Redirect after submission
	            } else {
	                alert("Failed to submit quiz. Please try again.");
	            }
	        })
	        .catch(error => console.error("Error submitting quiz:", error));
	    }

    </script>
</head>
<body>

    <%
        // Prevent Browsing from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma", "no-cache"); 
        response.setDateHeader("Expires", 0); 
    %>

    <h1>${quiz.title}</h1>
    <p>Time Remaining: <span id="timer"></span></p>

    <c:forEach items="${questions}" var="q" varStatus="loop">
        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <p>${loop.index+1}. ${q.questionText}</p>
            <input type="radio" name="${q.questionId}" value="A"> <c:out value='${q.optionA}'/> <br>
            <input type="radio" name="${q.questionId}" value="B"> <c:out value='${q.optionB}'/> <br>
            <input type="radio" name="${q.questionId}" value="C"> <c:out value='${q.optionC}'/> <br>
            <input type="radio" name="${q.questionId}" value="D"> <c:out value='${q.optionD}'/> <br>
        </div>
    </c:forEach>

    <button onclick="submitQuiz()">Submit Quiz</button>

</body>
</html>
