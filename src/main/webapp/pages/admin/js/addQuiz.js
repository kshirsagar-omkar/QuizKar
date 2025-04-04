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
        
        // Scroll to the new question
        newQuestion.scrollIntoView({ behavior: 'smooth' });
    }

    function removeQuestion(button) {
        const questionBlocks = document.querySelectorAll('.question-block');
        if (questionBlocks.length > 1) {
            button.closest('.question-block').remove();
        }
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
        const submitBtn = document.querySelector('#quizForm button[type="submit"]');
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
            submitBtn.disabled = false;
        });
    }