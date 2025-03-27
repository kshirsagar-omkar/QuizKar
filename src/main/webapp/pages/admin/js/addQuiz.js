let questionCount = 1; // Track the number of questions
        
// ✅ Add a new question dynamically
function addQuestion() {
    questionCount++;
    const container = document.getElementById("questions");
    const newQuestion = document.createElement("div");
    newQuestion.classList.add("question-block");
    newQuestion.innerHTML = `
        <h3>Question ${questionCount}</h3>
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
        <button type="button" onclick="removeQuestion(this)">Remove</button>
        <hr>
    `;
    container.appendChild(newQuestion);
}

// ✅ Remove a question
function removeQuestion(button) {
    button.parentElement.remove();
    questionCount--;
}

// ✅ Collect all questions and send them to the servlet via AJAX
function submitQuiz(event) {
    event.preventDefault(); // Prevent default form submission

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
                correctAnswer: correctAnswer
            });
        }
    });

    // Validate before sending request
    if (!title || !timeLimit || questions.length === 0) {
        alert("Please fill in all fields and add at least one question.");
        return;
    }

    let requestData = {
        title: title,
        timeLimit: timeLimit,
        createdById: adminId, // Pass Admin ID
        questions: questions,
        action: 'add'
    };

    fetch('AdminAddQuizServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(requestData) // ✅ Send as JSON
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            alert("Quiz created successfully!");
            window.location.href = "AdminAddQuizServlet";
        } else {
            alert("Error creating quiz.");
        }
    })
    .catch(error => console.error("Error submitting quiz:", error));
}