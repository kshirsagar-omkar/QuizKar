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
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
    <title>${quiz.title} - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Quiz-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quiz.css?v1">
</head>
<body class="bg-light">
    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <div class="container py-4">
        <div class="row">
            <div class="col-12">
                <div class="quiz-header sticky-top bg-white shadow-sm p-3 mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <h1 class="h3 mb-0 text-primary">${quiz.title}</h1>
                        <div class="timer-container">
                            <span class="badge bg-danger rounded-pill px-3 py-2">
                                <i class="bi bi-clock-fill me-1"></i>
                                <span id="timer" class="fw-bold">00:00</span>
                            </span>
                        </div>
                    </div>
                    <div class="progress mt-3" style="height: 6px;">
                        <div id="timeProgress" class="progress-bar bg-danger" role="progressbar"></div>
                    </div>
                </div>
                
                <div class="quiz-container">
                    <form id="quizForm">
                        <c:forEach items="${questions}" var="q" varStatus="loop">
                            <div class="card question-card mb-4 border-0 shadow-sm">
                                <div class="card-header bg-white">
                                    <div class="question-number badge bg-primary mb-2">
                                        Question ${loop.index+1}
                                    </div>
                                    <div class="question-text-container bg-light p-3 rounded">
                                        <pre class="question-text mb-0"><c:out value='${q.questionText}'/></pre>
                                    </div>
                                </div>
                                <div class="card-body pt-0">
                                    <div class="options-container">
                                        <div class="form-check option-item mb-3">
                                            <input class="form-check-input" type="radio" name="${q.questionId}" id="q${q.questionId}A" value="A">
                                            <label class="form-check-label" for="q${q.questionId}A">
                                                <span class="option-letter bg-primary text-white rounded-circle me-2">A</span>
                                                <span class="option-text"><c:out value='${q.optionA}'/></span>
                                            </label>
                                        </div>
                                        <div class="form-check option-item mb-3">
                                            <input class="form-check-input" type="radio" name="${q.questionId}" id="q${q.questionId}B" value="B">
                                            <label class="form-check-label" for="q${q.questionId}B">
                                                <span class="option-letter bg-primary text-white rounded-circle me-2">B</span>
                                                <span class="option-text"><c:out value='${q.optionB}'/></span>
                                            </label>
                                        </div>
                                        <div class="form-check option-item mb-3">
                                            <input class="form-check-input" type="radio" name="${q.questionId}" id="q${q.questionId}C" value="C">
                                            <label class="form-check-label" for="q${q.questionId}C">
                                                <span class="option-letter bg-primary text-white rounded-circle me-2">C</span>
                                                <span class="option-text"><c:out value='${q.optionC}'/></span>
                                            </label>
                                        </div>
                                        <div class="form-check option-item mb-3">
                                            <input class="form-check-input" type="radio" name="${q.questionId}" id="q${q.questionId}D" value="D">
                                            <label class="form-check-label" for="q${q.questionId}D">
                                                <span class="option-letter bg-primary text-white rounded-circle me-2">D</span>
                                                <span class="option-text"><c:out value='${q.optionD}'/></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </form>
                </div>
                
                <div class="quiz-footer sticky-bottom bg-white shadow-lg p-3 mt-4">
                    <input type="hidden" value="${user.userId}" id="userId">
                    <input type="hidden" value="${quiz.quizId}" id="quizId">
                    <input type="hidden" value="${quiz.timeLimit}" id="timeLimit">
                    
                    <div class="d-grid gap-2">
                        <button class="btn btn-lg btn-danger py-3" onclick="submitQuiz()">
                            <i class="bi bi-send-fill me-2"></i>Submit Quiz
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript with enhanced timer visualization -->
    <script>
        let totalTime, timeTakenSeconds = 0;
        let timerInterval;
        let initialTime;

        function startQuiz(quizTimeLimit) {
            totalTime = quizTimeLimit * 60; // Convert minutes to seconds
            initialTime = totalTime;

            function updateTimer() {
                let minutes = Math.floor(totalTime / 60);
                let seconds = totalTime % 60;

                // Update timer display
                document.getElementById('timer').innerText = 
                    (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

                // Update progress bar
                let progressPercent = (totalTime / initialTime) * 100;
                document.getElementById('timeProgress').style.width = progressPercent + '%';

                // Change color when time is running low
                if (progressPercent < 20) {
                    document.getElementById('timeProgress').classList.add('bg-danger');
                    document.getElementById('timeProgress').classList.remove('bg-warning');
                } else if (progressPercent < 50) {
                    document.getElementById('timeProgress').classList.add('bg-warning');
                    document.getElementById('timeProgress').classList.remove('bg-danger');
                }

                if (totalTime <= 0) {
                    clearInterval(timerInterval);            
                    submitQuiz(); // Auto-submit on timeout
                } else {
                    totalTime--;
                    timeTakenSeconds++; // Increment time taken in seconds
                }
            }

            timerInterval = setInterval(updateTimer, 1000);
            updateTimer(); // Initial call
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
                    // Use Bootstrap modal for success message instead of alert
                    const successModal = new bootstrap.Modal(document.getElementById('submitSuccessModal'));
                    successModal.show();
                    
                    // Redirect after modal is closed
                    document.getElementById('successModalClose').addEventListener('click', function() {
                        window.location.href = "UserDashboard";
                    });
                } else {
                    // Use Bootstrap toast for error message
                    const errorToast = new bootstrap.Toast(document.getElementById('submitErrorToast'));
                    errorToast.show();
                }
            })
            .catch(error => {
                console.error("Error submitting quiz:", error);
                const errorToast = new bootstrap.Toast(document.getElementById('submitErrorToast'));
                errorToast.show();
            });
        }
        
        // Initialize timer
        window.addEventListener('DOMContentLoaded', function() {
            startQuiz(document.getElementById("timeLimit").value);
        });
    </script>

    <!-- Success Modal -->
    <div class="modal fade" id="submitSuccessModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="bi bi-check-circle-fill me-2"></i>Quiz Submitted</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Your quiz has been submitted successfully!</p>
                    <p>You will be redirected to your dashboard shortly.</p>
                </div>
                <div class="modal-footer">
                    <button id="successModalClose" type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Error Toast -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
        <div id="submitErrorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    Failed to submit quiz. Please try again.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>