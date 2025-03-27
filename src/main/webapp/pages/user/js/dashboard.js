function updateStudyPlanStatus(planId, button, userId) {
    let updatedStatus = button.value; // Get value from clicked button
    
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
        if (data.trim() === "success") {
            //alert("Status Updated Successfully!");
            location.reload(); // Refresh the page to reflect changes
        } else if(data.trim() === "failed"){
            alert("Failed to update status. Please try again.");
        }else {
        	alert("Problem in javascript. Please try again.");
        }
    })
    .catch(error => console.error("Error updating status:", error));
}