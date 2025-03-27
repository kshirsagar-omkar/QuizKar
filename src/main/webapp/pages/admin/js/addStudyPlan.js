function addStudyPlan(createdById){
    	
    	var studyPlanName = document.getElementById("studyPlanName").value;
    	var studyPlanLink = document.getElementById("studyPlanLink").value;
    	
    	console.log(studyPlanName);
    	console.log(studyPlanLink);
    	
    	let params = new URLSearchParams( {
    		createdById: createdById,
    		studyPlanName: studyPlanName,
    		studyPlanLink: studyPlanLink,
    		action: 'add'
    	} ); 
    	
    	fetch('AdminStudyPlanServlet',
    		{
    			method: 'POST',
    			body: params    		
    		}		
    	)
    	.then( response => response.text() )
    	.then( data => 
    	{
    		if( data.trim()=="success" ){
    			alert("Study Plan " + studyPlanName + " Added Successfully!");
    		}
    		else if( data.trim()=="failed" ){
    			alert("Study Plan " + studyPlanName + " Not Added!!!");
    		}
    		else{
    			alert("Server Problem Data Not Added");
    		}
    	})
    	.catch(error => {
    		console.error("Error While Adding StudyPlan " + error);
    	})
    }
    	
    	