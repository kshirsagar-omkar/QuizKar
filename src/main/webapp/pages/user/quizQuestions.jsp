<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.quizkar.entities.Users" %>
<%@page import="com.quizkar.constants.Role"%>
<%@page import="com.quizkar.util.SessionUtil"%>

<%
	//Prevent unauthorized access
	Users user = SessionUtil.getUser(request);
	if (user == null || ! user.getRole().equals(Role.USER)  ) {
		response.sendRedirect( request.getContextPath() + "/LogoutServlet");
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

    <!-- JavaScript with auto-submit and user-friendly alerts -->
    <script>
        let totalTime, timeTakenSeconds = 0;
        let timerInterval;
        let initialTime;
        let quizSubmitted = false;
        let isSubmitting = false;
        let hasAnsweredQuestions = false;

        // Function to check if any answers have been selected
        function checkAnsweredQuestions() {
            return document.querySelectorAll("input[type=radio]:checked").length > 0;
        }

        function startQuiz(quizTimeLimit) {
            totalTime = quizTimeLimit * 60;
            initialTime = totalTime;

            function updateTimer() {
                let minutes = Math.floor(totalTime / 60);
                let seconds = totalTime % 60;

                document.getElementById('timer').innerText = 
                    (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

                let progressPercent = (totalTime / initialTime) * 100;
                document.getElementById('timeProgress').style.width = progressPercent + '%';

                if (progressPercent < 20) {
                    document.getElementById('timeProgress').classList.add('bg-danger');
                    document.getElementById('timeProgress').classList.remove('bg-warning');
                } else if (progressPercent < 50) {
                    document.getElementById('timeProgress').classList.add('bg-warning');
                    document.getElementById('timeProgress').classList.remove('bg-danger');
                }

                if (totalTime <= 0) {
                    clearInterval(timerInterval);            
                    showExitConfirmation(true);
                } else {
                    totalTime--;
                    timeTakenSeconds++;
                }
            }

            timerInterval = setInterval(updateTimer, 1000);
            updateTimer();
        }

        function showExitConfirmation(isTimeout = false) {
            if (quizSubmitted || isSubmitting) return;
            
            // Check if any answers have been selected
            hasAnsweredQuestions = checkAnsweredQuestions();
            
            // Only show warning if answers have been selected or it's a timeout
            if (!hasAnsweredQuestions && !isTimeout) {
                return;
            }
            
            const exitModal = new bootstrap.Modal(document.getElementById('exitConfirmationModal'));
            exitModal.show();
            
            // Update modal content based on context
            const modalTitle = document.getElementById('exitModalTitle');
            const modalBody = document.getElementById('exitModalBody');
            
            if (isTimeout) {
                modalTitle.innerHTML = '<i class="bi bi-clock-fill me-2"></i>Time Expired';
                modalBody.innerHTML = 'Your time has expired. The quiz will be submitted with your current answers.';
            } else {
                modalTitle.innerHTML = '<i class="bi bi-exclamation-triangle-fill me-2"></i>Leave Quiz?';
                modalBody.innerHTML = 'Are you sure you want to leave? Your quiz will be submitted with your current answers.';
            }

            // Auto-submit after 8 seconds if user doesn't respond
            let countdown = 8;
            const countdownElement = document.getElementById('exitCountdown');
            countdownElement.textContent = countdown;
            
            const countdownInterval = setInterval(() => {
                countdown--;
                countdownElement.textContent = countdown;
                
                if (countdown <= 0) {
                    clearInterval(countdownInterval);
                    if (!quizSubmitted && !isSubmitting) {
                        exitModal.hide();
                        submitQuiz();
                    }
                }
            }, 1000);

            // Cleanup when modal is hidden
            exitModal._element.addEventListener('hidden.bs.modal', () => {
                clearInterval(countdownInterval);
            });
        }

        function submitQuiz() {
            if (quizSubmitted || isSubmitting) return;
            isSubmitting = true;
            
            clearInterval(timerInterval);

            let userId = document.getElementById("userId").value;    
            let quizId = document.getElementById("quizId").value;
            let timeTakenMinutes = Math.ceil(timeTakenSeconds / 60);

            let quizData = {
                userId: userId,
                quizId: quizId,
                timeTaken: timeTakenMinutes,
                answers: {}
            };

            // Collect answers (works even if none are selected)
            document.querySelectorAll("input[type=radio]:checked").forEach((radio) => {
                quizData.answers[radio.name] = radio.value;
            });

            // Block UI during submission
            document.body.style.pointerEvents = 'none';
            document.body.style.opacity = '0.7';
            
            fetch("UserSubmitQuiz", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(quizData)
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok");
                return response.text();
            })
            .then(data => {
                quizSubmitted = true;
                if (data.trim() === "success") {
                	
                	// Replace this line:
                	//bootstrap.Modal.getInstance(document.getElementById('exitConfirmationModal')).hide();

                	// With this safer version:
                	const exitModal = bootstrap.Modal.getInstance(document.getElementById('exitConfirmationModal'));
                	if (exitModal) {
                	    exitModal.hide();
                	}
                	
                    const successModal = new bootstrap.Modal(document.getElementById('submitSuccessModal'));
                    successModal.show();
                    
                    document.getElementById('successModalClose').addEventListener('click', function() {
                        window.location.href = "UserDashboard";
                    });
                } else {
                    throw new Error("Server returned non-success status");
                }
            })
            .catch(error => {
                console.error("Error submitting quiz:", error);
                isSubmitting = false;
                const errorToast = new bootstrap.Toast(document.getElementById('submitErrorToast'));
                errorToast.show();
            })
            .finally(() => {
                document.body.style.pointerEvents = 'auto';
                document.body.style.opacity = '1';
            });
        }
        
        // Initialize quiz
        window.addEventListener('DOMContentLoaded', function() {
            startQuiz(document.getElementById("timeLimit").value);
            
            // Track radio button changes to detect answered questions
            document.querySelectorAll('input[type=radio]').forEach(radio => {
                radio.addEventListener('change', function() {
                    hasAnsweredQuestions = checkAnsweredQuestions();
                });
            });
            
            // Enhanced beforeunload handler
            window.addEventListener('beforeunload', function(e) {
                if (!quizSubmitted && !isSubmitting && hasAnsweredQuestions) {
                    e.preventDefault();
                    showExitConfirmation();
                    return "Your quiz will be submitted if you leave this page.";
                }
            });
            
            // Enhanced back button handling
            history.pushState(null, null, location.href);
            window.onpopstate = function(e) {
                if (!quizSubmitted && !isSubmitting && hasAnsweredQuestions) {
                    e.preventDefault();
                    showExitConfirmation();
                    history.pushState(null, null, location.href);
                }
            };
        });
    </script>

    <!-- Exit Confirmation Modal -->
    <div class="modal fade" id="exitConfirmationModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning text-white">
                    <h5 class="modal-title" id="exitModalTitle">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>Leave Quiz?
                    </h5>
                </div>
                <div class="modal-body">
                    <p id="exitModalBody">Are you sure you want to leave? Your quiz will be submitted with your current answers.</p>
                    <p>Auto-submitting in <span id="exitCountdown" class="fw-bold">8</span> seconds...</p>
                    <div class="progress mt-3">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-warning" 
                             role="progressbar" style="width: 100%"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-arrow-left-circle-fill me-2"></i>Resume Quiz
                    </button>
                    <button type="button" class="btn btn-warning text-white" onclick="submitQuiz()">
                        <i class="bi bi-send-fill me-2"></i>Submit Now
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="submitSuccessModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="bi bi-check-circle-fill me-2"></i>Quiz Submitted</h5>
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