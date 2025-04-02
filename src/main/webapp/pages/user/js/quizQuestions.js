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
		
		
		
		
		
		
		
		
		
		