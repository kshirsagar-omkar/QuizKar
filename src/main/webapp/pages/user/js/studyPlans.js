function enrollInStudyPlan(planId, userId) {
    // Disable the button to prevent multiple clicks
    const buttons = document.querySelectorAll(`.enroll-btn`);
    buttons.forEach(btn => btn.disabled = true);
    
    let params = new URLSearchParams({
        planId: planId,
        userId: userId,
        action: "enroll"
    });

    fetch("UserStudyPlanServlet", {
        method: "POST",
        body: params
    })
    .then(response => response.text())
    .then(data => {
        const toast = new bootstrap.Toast(document.getElementById('enrollToast'));
        const toastMessage = document.getElementById('toastMessage');
        
        if (data.trim() === "success") {
            toastMessage.textContent = "Enrolled successfully!";
            document.getElementById('enrollToast').classList.add('bg-success');
        } else if (data.trim() === "alreadyEnrolled") {
            toastMessage.textContent = "You're already enrolled in this study plan";
            document.getElementById('enrollToast').classList.add('bg-warning');
        } else {
            toastMessage.textContent = "Failed to enroll. Please try again.";
            document.getElementById('enrollToast').classList.add('bg-danger');
        }
        
        toast.show();
        
        // Auto-hide after 3 seconds
        setTimeout(() => {
            toast.hide();
            // Remove color classes for next use
            document.getElementById('enrollToast').classList.remove('bg-success', 'bg-warning', 'bg-danger');
        }, 3000);
    })
    .catch(error => {
        console.error("Error enrolling in study plan:", error);
        const toast = new bootstrap.Toast(document.getElementById('enrollToast'));
        document.getElementById('toastMessage').textContent = "An error occurred. Please try again.";
        document.getElementById('enrollToast').classList.add('bg-danger');
        toast.show();
        
        setTimeout(() => {
            toast.hide();
            document.getElementById('enrollToast').classList.remove('bg-danger');
        }, 3000);
    })
    .finally(() => {
        // Re-enable buttons after operation completes
        buttons.forEach(btn => btn.disabled = false);
    });
}