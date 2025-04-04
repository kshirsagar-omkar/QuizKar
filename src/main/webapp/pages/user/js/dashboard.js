function updateStudyPlanStatus(planId, button, userId) {
    // Disable the button and show loading state
    button.disabled = true;
    const originalContent = button.innerHTML;
    button.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...`;
    
    let updatedStatus = button.value;
    
    let params = new URLSearchParams({
        planId: planId,
        userId: userId, 
        updatedStatus: updatedStatus,
        action: 'updateStudyPlanStatus'
    });

    fetch("UserStudyPlanServlet", {
        method: "POST",
        body: params
    })
    .then(response => response.text())
    .then(data => {
        const toast = new bootstrap.Toast(document.getElementById('statusToast'));
        const toastMessage = document.getElementById('toastMessage');
        
        if (data.trim() === "success") {
            toastMessage.textContent = updatedStatus === "complete" 
                ? "Study plan marked as complete! 🎉" 
                : "Study plan reopened for review.";
            document.getElementById('statusToast').classList.add('bg-success');
            
            // Add animation before reload
            const card = button.closest('.study-plan-item');
            if (card) {
                card.style.transition = 'all 0.5s ease';
                card.style.opacity = '0';
                card.style.transform = 'translateX(20px)';
            }
            
            setTimeout(() => location.reload(), 800);
        } else if(data.trim() === "failed") {
            toastMessage.textContent = "Failed to update status. Please try again.";
            document.getElementById('statusToast').classList.add('bg-danger');
        } else {
            toastMessage.textContent = "An unexpected error occurred. Please try again.";
            document.getElementById('statusToast').classList.add('bg-danger');
        }
        
        toast.show();
        
        // Auto-hide after 4 seconds
        setTimeout(() => {
            toast.hide();
            document.getElementById('statusToast').classList.remove('bg-success', 'bg-danger');
        }, 4000);
    })
    .catch(error => {
        console.error("Error updating status:", error);
        const toast = new bootstrap.Toast(document.getElementById('statusToast'));
        document.getElementById('toastMessage').textContent = "Network error. Please check your connection.";
        document.getElementById('statusToast').classList.add('bg-danger');
        toast.show();
        
        setTimeout(() => {
            toast.hide();
            document.getElementById('statusToast').classList.remove('bg-danger');
        }, 4000);
    })
    .finally(() => {
        // Only revert button if not reloading
        if (!button.closest('.study-plan-item').style.opacity) {
            button.disabled = false;
            button.innerHTML = originalContent;
        }
    });
}

// Add animation on scroll
document.addEventListener('DOMContentLoaded', function() {
    const animateElements = document.querySelectorAll('.animate__animated');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
            }
        });
    }, { threshold: 0.1 });
    
    animateElements.forEach(element => {
        element.style.opacity = 0;
        observer.observe(element);
    });
});