function validateCredentials(userId) {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    if (!username || !password) {
        alert("Please enter your username and password.");
        return;
    }

    let params = new URLSearchParams({
        action: "verify",
        userId: userId,
        username: username,
        password: password
    });

    fetch("UserEditProfile", {
        method: "POST",
        body: params
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            document.getElementById("editSection").style.display = "block";
            document.getElementById("verifySection").style.display = "none";
            document.getElementById("newPassword").value = password;
        } else {
            document.getElementById("errorMessage").innerText = "Invalid credentials!";
        }
    })
    .catch(error => {
        console.error("Error verifying credentials:", error);
        document.getElementById("errorMessage").innerText = "Something went wrong. Please try again!";
    });
}

function updateProfile(userId) {
    const newUsername = document.getElementById("newUsername").value;
    const newEmail = document.getElementById("newEmail").value;
    const newPassword = document.getElementById("newPassword").value;

    let params = new URLSearchParams({
        action: "edit",
        userId: userId,
        username: newUsername,
        email: newEmail,
        password: newPassword
    });

    fetch("UserEditProfile", {
        method: "POST",
        body: params
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "success") {
            alert("Profile updated successfully!");
            //location.reload();
            window.location.replace("UserProfile");
        } else if(data.trim() === "alreadyTaken"){
        	alert("Failed to update profile. Username or Email Already Taken.");
        } else {
            alert("Failed to update profile. Please try again.");
        }
    })
    .catch(error => console.error("Error updating profile:", error));
}

function togglePassword() {
    let passwordField = document.getElementById("newPassword");
    passwordField.type = passwordField.type === "password" ? "text" : "password";
}

