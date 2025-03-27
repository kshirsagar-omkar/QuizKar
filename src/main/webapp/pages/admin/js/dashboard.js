// DELETE STUDY PLAN
function deleteStudyPlan(studyPlanId) {
    if (!confirm("Are you sure you want to delete this Study Plan?")) return;
    fetch('AdminStudyPlanServlet', {
        method: 'POST',
        body: new URLSearchParams({ 'action':'delete', 'planId': studyPlanId })
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            document.getElementById("studyPlanRow_" + studyPlanId).remove();
        } else if ((data.trim() === "failed")){
            alert("Failed to delete study plan.");
        }
		else {
			alert("Server Side Problem!!");
		}
    })
    .catch(error => console.error("Error deleting study plan:", error));
}
// Stores original values before editing
let originalData = {};

// ✅ ENABLE EDIT MODE FOR STUDY PLAN (Name & Link)
function editStudyPlan(planId) {
    let row = document.getElementById("studyPlanRow_" + planId);
    let tds = row.getElementsByTagName("td");
    let nameTd = tds[0];  // Name column
    let linkTd = tds[1];  // Link column
    
    // Prevent multiple edits
    if (originalData[planId]) return;

    let linkElement = linkTd.querySelector("a");
    
    // Store original values
    originalData[planId] = {
        name: nameTd.textContent.trim(),
        linkHref: linkElement ? linkElement.getAttribute("href") : linkTd.textContent.trim(),
        linkText: linkElement ? linkElement.textContent.trim() : linkTd.textContent.trim()
    };

    // Replace name & link with input fields
    nameTd.innerHTML = `<input type="text" id="nameInput_${planId}" value="${originalData[planId].name}">`;
    linkTd.innerHTML = `<input type="text" id="linkInput_${planId}" value="${originalData[planId].linkHref}">`;

    // Toggle buttons
    document.getElementById("editSPButton_" + planId).style.display = "none";
    document.getElementById("saveSPButton_" + planId).style.display = "inline";
    document.getElementById("cancelSPButton_" + planId).style.display = "inline";
}

// ✅ CANCEL EDITING & RESTORE ORIGINAL VALUES
function cancelStudyPlanEdit(planId) {
    let row = document.getElementById("studyPlanRow_" + planId);
    let tds = row.getElementsByTagName("td");
    let nameTd = tds[0];
    let linkTd = tds[1];

    if (!originalData[planId]) return;

    // Restore name and link
    nameTd.textContent = originalData[planId].name;
    linkTd.innerHTML = `<a href="${originalData[planId].linkHref}" target="_blank">${originalData[planId].linkText}</a>`;

    // Clear stored original data
    delete originalData[planId];

    // Toggle buttons
    document.getElementById("editSPButton_" + planId).style.display = "inline";
    document.getElementById("saveSPButton_" + planId).style.display = "none";
    document.getElementById("cancelSPButton_" + planId).style.display = "none";
}

// ✅ SAVE STUDY PLAN (AJAX)
function saveStudyPlan(planId) {
    let row = document.getElementById("studyPlanRow_" + planId);
    let tds = row.getElementsByTagName("td");
    let nameTd = tds[0];
    let linkTd = tds[1];

    let newName = document.getElementById(`nameInput_${planId}`).value.trim();
    let newLink = document.getElementById(`linkInput_${planId}`).value.trim();

    // Prevent unnecessary updates
    if (newName === originalData[planId].name && newLink === originalData[planId].linkHref) {
        cancelStudyPlanEdit(planId);
        return;
    }

    let params = new URLSearchParams({
        planId: planId,
        newName: newName,
        newLink: newLink,
        action: 'edit'
    });

    fetch('AdminStudyPlanServlet', {
        method: 'POST',
        body: params
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            // Update UI
            nameTd.textContent = newName;
            linkTd.innerHTML = `<a href="${newLink}" target="_blank">${originalData[planId].linkText}</a>`;

            // Clear stored original data
            delete originalData[planId];

            // Toggle buttons
            document.getElementById("editSPButton_" + planId).style.display = "inline";
            document.getElementById("saveSPButton_" + planId).style.display = "none";
            document.getElementById("cancelSPButton_" + planId).style.display = "none";
        } else {
            alert("Failed to update study plan.");
            cancelStudyPlanEdit(planId);
        }
    })
    .catch(error => {
        console.error("Error updating study plan:", error);
        alert("Error occurred, changes not saved.");
        cancelStudyPlanEdit(planId);
    });
}






//================================================================================================================================================================
//================================================================================================================================================================
//================================================================================================================================================================
//================================================================================================================================================================
	

	
	
	
	
	

// DELETE QUIZ
function deleteQuiz(quizId) {
    if (!confirm("Are you sure you want to delete this Quiz?")) return;
    fetch('AdminQuizServlet', {
        method: 'POST',
        body: new URLSearchParams({ 'action': 'delete', 'quizId': quizId })
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            document.getElementById("quizRow_" + quizId).remove();
        } else {
            alert("Failed to delete quiz.");
        }
    })
    .catch(error => console.error("Error deleting quiz:", error));
}



// EDIT QUIZ: Replace title and time limit with input fields for editing
function editQuiz(quizId) {
    var row = document.getElementById("quizRow_" + quizId);
    var tds = row.getElementsByTagName("td");
    var titleTd = tds[0]; // Quiz title cell
    var timeTd = tds[1];  // Time limit cell

    // Store original HTML if not already stored
    if (!titleTd.getAttribute("data-original")) {
        titleTd.setAttribute("data-original", titleTd.innerHTML);
    }
    if (!timeTd.getAttribute("data-original")) {
        timeTd.setAttribute("data-original", timeTd.innerHTML);
    }
    
    // Create input for quiz title
    var titleInput = document.createElement("input");
    titleInput.type = "text";
    titleInput.value = titleTd.textContent;
    titleInput.id = "titleInput_" + quizId;
    
    // Create input for quiz time limit
    var timeInput = document.createElement("input");
    timeInput.type = "number";
    // Remove the " mins" suffix if present
    var timeText = timeTd.textContent;
    if (timeText.indexOf(" mins") !== -1) {
        timeText = timeText.replace(" mins", "");
    }
    timeInput.value = timeText.trim();
    timeInput.id = "timeInput_" + quizId;
    
    // Replace cell content with input fields
    titleTd.innerHTML = "";
    titleTd.appendChild(titleInput);
    
    timeTd.innerHTML = "";
    timeTd.appendChild(timeInput);
    
    // Toggle button visibility: hide edit, show save and cancel
    document.getElementById("editQButton_" + quizId).style.display = "none";
    document.getElementById("saveQButton_" + quizId).style.display = "inline";
    document.getElementById("cancelQButton_" + quizId).style.display = "inline";
}

// SAVE QUIZ: Send updated title and time limit to the server and update the DOM
function saveQuiz(quizId) {
    var row = document.getElementById("quizRow_" + quizId);
    var tds = row.getElementsByTagName("td");
    var titleTd = tds[0];
    var timeTd = tds[1];
    
    var titleInput = document.getElementById("titleInput_" + quizId);
    var timeInput = document.getElementById("timeInput_" + quizId);
    var newTitle = titleInput.value;
    var newTime = timeInput.value;
    
    // Prepare the POST data
    var params = new URLSearchParams({
        quizId: quizId,
        newTitle: newTitle,
        newTime: newTime,
		action: 'edit'
    });
    
    fetch('AdminQuizServlet', {
        method: 'POST',
        body: params
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            // Update cells with new values
            titleTd.innerHTML = "";
            titleTd.textContent = newTitle;
            
            timeTd.innerHTML = "";
            timeTd.textContent = newTime + " mins";
            
            // Remove stored original HTML attributes
            titleTd.removeAttribute("data-original");
            timeTd.removeAttribute("data-original");
            
            // Toggle button visibility back to 'Edit'
            document.getElementById("editQButton_" + quizId).style.display = "inline";
            document.getElementById("saveQButton_" + quizId).style.display = "none";
            document.getElementById("cancelQButton_" + quizId).style.display = "none";
        } else {
            alert("Update failed. Changes not saved.");
            cancelQuizEdit(quizId);
        }
    })
    .catch(error => {
        console.error("Error updating quiz:", error);
        alert("Error occurred. Changes not saved.");
        cancelQuizEdit(quizId);
    });
}

// CANCEL QUIZ EDIT: Revert changes to original data using stored HTML
function cancelQuizEdit(quizId) {
    var row = document.getElementById("quizRow_" + quizId);
    var tds = row.getElementsByTagName("td");
    var titleTd = tds[0];
    var timeTd = tds[1];
    
    var originalTitle = titleTd.getAttribute("data-original");
    var originalTime = timeTd.getAttribute("data-original");
    
    if (originalTitle) {
        titleTd.innerHTML = originalTitle;
        titleTd.removeAttribute("data-original");
    }
    if (originalTime) {
        timeTd.innerHTML = originalTime;
        timeTd.removeAttribute("data-original");
    }
    
    // Toggle button visibility back to 'Edit'
    document.getElementById("editQButton_" + quizId).style.display = "inline";
    document.getElementById("saveQButton_" + quizId).style.display = "none";
    document.getElementById("cancelQButton_" + quizId).style.display = "none";
}
