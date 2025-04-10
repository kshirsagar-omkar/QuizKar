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
    <meta charset="UTF-8">    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <title>Create New Quiz - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Admin Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Quiz Form CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-quiz-form.css?v2">
    <style>
        #submitBtnContainer {
            display: block; /* Visible by default since we start with one question */
        }
    </style>
</head>
<body class="admin-quiz-page">

    <%
        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-lg">
                    <div class="card-header bg-admin-primary text-white">
                        <h2 class="h4 mb-0"><i class="bi bi-plus-circle-dotted me-2"></i>Create New Quiz</h2>
                    </div>
                    <div class="card-body">
                        <form id="quizForm" onsubmit="submitQuiz(event)">
                            <div class="mb-4">
                                <div class="row">
                                    <div class="col-md-8 mb-3">
                                        <label for="quizTitle" class="form-label">Quiz Title</label>
                                        <input type="text" class="form-control form-control-lg" id="quizTitle" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="timeLimit" class="form-label">Time Limit (minutes)</label>
                                        <input type="number" class="form-control" id="timeLimit" min="1" required>
                                    </div>
                                </div>
                            </div>
                            
                            <input type="hidden" value="<%=user.getUserId()%>" id="adminId">

                            <div id="questions">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h3 class="h5 mb-0"><i class="bi bi-question-circle me-2"></i>Questions</h3>
                                </div>
                                
                                <!-- Initial Question -->
                                <div class="question-block card mb-4">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h4 class="h6 mb-0">Question</h4>
                                        <button type="button" class="btn btn-sm btn-danger" onclick="removeQuestion(this)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="form-label">Question Text</label>
                                            <textarea class="form-control questionText" rows="3" required></textarea>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Option A</label>
                                                <input type="text" class="form-control optionA" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Option B</label>
                                                <input type="text" class="form-control optionB" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Option C</label>
                                                <input type="text" class="form-control optionC" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Option D</label>
                                                <input type="text" class="form-control optionD" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Correct Answer</label>
                                                <select class="form-select correctAnswer" required>
                                                    <option value="A">Option A</option>
                                                    <option value="B">Option B</option>
                                                    <option value="C">Option C</option>
                                                    <option value="D">Option D</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <button type="button" class="btn btn-sm btn-success" onclick="addQuestion()">
                                    <i class="bi bi-plus-circle me-2"></i>Add Question
                                </button>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4" id="submitBtnContainer">
                                <button type="submit" class="btn btn-admin-primary btn-lg" id="submitBtn">
                                    <i class="bi bi-save me-2"></i>Create Quiz
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    // Function to check if at least one question exists
    function checkQuestionCount() {
        const questionCount = document.querySelectorAll('.question-block').length;
        const submitBtnContainer = document.getElementById('submitBtnContainer');
        
        if (questionCount > 0) {
            submitBtnContainer.style.display = 'flex'; // Show the button container
        } else {
            submitBtnContainer.style.display = 'none'; // Hide the button container
        }
    }
    
    // Function to validate all questions
    function validateQuestions() {
        const questions = document.querySelectorAll('.question-block');
        if (questions.length === 0) {
            return false;
        }
        
        for (const question of questions) {
            const textarea = question.querySelector('.questionText');
            const optionA = question.querySelector('.optionA');
            const optionB = question.querySelector('.optionB');
            const optionC = question.querySelector('.optionC');
            const optionD = question.querySelector('.optionD');
            
            if (!textarea.value.trim() || !optionA.value.trim() || !optionB.value.trim() || 
                !optionC.value.trim() || !optionD.value.trim()) {
                return false;
            }
        }
        
        return true;
    }
    
    // Function to validate the entire form
    function validateForm() {
        const title = document.getElementById('quizTitle').value.trim();
        const timeLimit = document.getElementById('timeLimit').value.trim();
        
        const hasValidQuestions = validateQuestions();
        const hasQuestions = document.querySelectorAll('.question-block').length > 0;
        
        // Enable/disable submit button based on validation
        document.getElementById('submitBtn').disabled = !(title && timeLimit && hasValidQuestions && hasQuestions);
    }
    
    // Add event listeners to all inputs
    function addValidationListeners() {
        document.getElementById('quizTitle').addEventListener('input', validateForm);
        document.getElementById('timeLimit').addEventListener('input', validateForm);
        
        document.querySelectorAll('.questionText, .optionA, .optionB, .optionC, .optionD').forEach(input => {
            input.addEventListener('input', validateForm);
        });
    }
    
    function addQuestion() {
        const container = document.getElementById("questions");
        const newQuestion = document.createElement("div");
        newQuestion.classList.add("question-block", "card", "mb-4");
        
        newQuestion.innerHTML = `
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
                <h4 class="h6 mb-0">Question</h4>
                <button type="button" class="btn btn-sm btn-danger" onclick="removeQuestion(this)">
                    <i class="bi bi-trash"></i>
                </button>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label">Question Text</label>
                    <textarea class="form-control questionText" rows="3" required></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option A</label>
                        <input type="text" class="form-control optionA" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option B</label>
                        <input type="text" class="form-control optionB" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option C</label>
                        <input type="text" class="form-control optionC" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option D</label>
                        <input type="text" class="form-control optionD" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Correct Answer</label>
                        <select class="form-select correctAnswer" required>
                            <option value="A">Option A</option>
                            <option value="B">Option B</option>
                            <option value="C">Option C</option>
                            <option value="D">Option D</option>
                        </select>
                    </div>
                </div>
            </div>
        `;
        container.appendChild(newQuestion);
        
        // Add validation listeners to new inputs
        newQuestion.querySelector('.questionText').addEventListener('input', validateForm);
        newQuestion.querySelectorAll('.optionA, .optionB, .optionC, .optionD').forEach(input => {
            input.addEventListener('input', validateForm);
        });
        
        // Update question count and validate form
        checkQuestionCount();
        validateForm();
        
        // Scroll to the new question
        newQuestion.scrollIntoView({ behavior: 'smooth' });
    }

    function removeQuestion(button) {
        button.closest('.question-block').remove();
        checkQuestionCount();
        validateForm();
    }
    
    function submitQuiz(event) {
        event.preventDefault();

        let title = document.getElementById("quizTitle").value.trim();
        let timeLimit = document.getElementById("timeLimit").value.trim();
        let adminId = document.getElementById("adminId").value.trim();
        
        let questions = [];

        document.querySelectorAll(".question-block").forEach((block, index) => {
            let questionText = block.querySelector(".questionText").value.trim();
            let optionA = block.querySelector(".optionA").value.trim();
            let optionB = block.querySelector(".optionB").value.trim();
            let optionC = block.querySelector(".optionC").value.trim();
            let optionD = block.querySelector(".optionD").value.trim();
            let correctAnswer = block.querySelector(".correctAnswer").value.trim();

            if (questionText && optionA && optionB && optionC && optionD && correctAnswer) {
                questions.push({
                    questionText: questionText,
                    optionA: optionA,
                    optionB: optionB,
                    optionC: optionC,
                    optionD: optionD,
                    correctAnswer: correctAnswer,
                    questionNumber: index + 1
                });
            }
        });

        if (!title || !timeLimit || questions.length === 0) {
            alert("Please fill in all fields and add at least one question.");
            return;
        }

        let requestData = {
            title: title,
            timeLimit: timeLimit,
            createdById: adminId,
            questions: questions,
            action: 'add'
        };

        // Show loading state
        const submitBtn = document.getElementById('submitBtn');
        const originalBtnContent = submitBtn.innerHTML;
        submitBtn.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Creating Quiz...`;
        submitBtn.disabled = true;

        fetch('AdminAddQuizServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(requestData)
        })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === "success") {
                alert("Quiz created successfully!");
                window.location.href = "AdminAddQuizServlet";
            } else {
                alert("Error creating quiz. Please try again.");
            }
        })
        .catch(error => {
            console.error("Error submitting quiz:", error);
            alert("An error occurred. Please try again.");
        })
        .finally(() => {
            submitBtn.innerHTML = originalBtnContent;
            validateForm(); // Re-enable button if needed
        });
    }
    
    // Initialize validation listeners and check question count
    document.addEventListener('DOMContentLoaded', function() {
        addValidationListeners();
        checkQuestionCount();
        validateForm();
    });
    </script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>