function addStudyPlan(adminId) {
    const form = document.getElementById('studyPlanForm');
    const nameInput = document.getElementById('studyPlanName');
    const linkInput = document.getElementById('studyPlanLink');
    
    // Check validity
    if (!form.checkValidity()) {
        // Add Bootstrap's was-validated class to show validation messages
        form.classList.add('was-validated');
        return;
    }
    
    const studyPlanData = {
        name: nameInput.value.trim(),
        link: linkInput.value.trim(),
        adminId: adminId
    };
    
    // Show loading state
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalBtnContent = submitBtn.innerHTML;
    submitBtn.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...`;
    submitBtn.disabled = true;
    
    // Send data to server
    fetch('AddStudyPlanServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(studyPlanData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.trim()=="success") {
            alert('Study plan added successfully!');
            form.reset();
            form.classList.remove('was-validated');
        } else if(data.trim()=="failed") {
            alert('Error: ' + ('Failed to add study plan'));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while saving the study plan');
    })
    .finally(() => {
        submitBtn.innerHTML = originalBtnContent;
        submitBtn.disabled = false;
    });
}