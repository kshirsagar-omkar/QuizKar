function enrollInStudyPlan(planId, userId){

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
        if (data.trim() === "success") {
            alert("Enrolled Successfully!");
            location.reload(); // Refresh the page to reflect changes
        } else if( data.trim() === "alreadyEnrolled" ){
        	alert("Already Enrolled");
        }else {
            alert("Failed to enroll. Please try again.");
        }
    })
    .catch(error => console.error("Error enrolling in study plan:", error));
}