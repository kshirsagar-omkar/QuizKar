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
        	
        	<!-- Textarea for the question -->
            <textarea class="questionText" rows="5" cols="50" oninput="adjustTextareaHeight(this)" readonly>
                ${loop.index+1}. ${q.questionText}
            </textarea><br>
        	
            <!-- <p>${loop.index+1}. ${q.questionText}</p>	 -->
            <input type="radio" name="${q.questionId}" value="A"> <c:out value='${q.optionA}'/> <br>
            <input type="radio" name="${q.questionId}" value="B"> <c:out value='${q.optionB}'/> <br>
            <input type="radio" name="${q.questionId}" value="C"> <c:out value='${q.optionC}'/> <br>
            <input type="radio" name="${q.questionId}" value="D"> <c:out value='${q.optionD}'/> <br>
        </div>
    </c:forEach>
    
    
    <input type="hidden" value="${user.userId}" id="userId">
    <input type="hidden" value="${quiz.quizId}" id="quizId">
    <input type="hidden" value="${quiz.timeLimit}" id="timeLimit">

    <!-- Pass JSP values into the JavaScript function -->
    <button onclick="submitQuiz()">Submit Quiz</button>



	<!-- Load external JavaScript file first
	<script src="./pages/user/js/quizQuestions.js"></script>  -->
	
	<!-- Now call the function after it's loaded -->
	<script>
	    
	    
	    
	    let totalTime, timeTakenSeconds = 0;
	    let timerInterval;

	    function startQuiz(quizTimeLimit) {
	        totalTime = quizTimeLimit * 60; // Convert minutes to seconds

	    	
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

	        timerInterval = setInterval(updateTimer, 1000);
	    }

	    function submitQuiz() {
	        clearInterval(timerInterval); // Stop the timer

	        
	        let userId = document.getElementById("userId").value;    
			let quizId = document.getElementById("quizId").value;
	        
	        // Convert seconds to whole minutes (round up)
	        let timeTakenMinutes = Math.ceil(timeTakenSeconds / 60);

	        let quizData = {
	            userId: userId,
	            quizId: quizId,
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
	    
	    
	    startQuiz(document.getElementById("timeLimit").value);
	</script>
	

</body>
</html>
