function validateCredentials(userId) {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    if (!username || !password) {
        document.getElementById("errorMessage").innerHTML = '<p class="alert alert-danger">Please enter your username and password.</p>';
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
            initializeEmailVerification();
        } else {            
            document.getElementById("errorMessage").innerHTML = '<p class="alert alert-danger">Invalid credentials</p>';
        }
    })
    .catch(error => {
        console.error("Error verifying credentials:", error);
        document.getElementById("errorMessage").innerHTML = '<p class="alert alert-danger">Something went wrong. Please try again!</p>';
    });
}

// Initialize email verification components
function initializeEmailVerification() {
    // Form elements
    const newEmailInput = document.getElementById("newEmail");
    const sendOtpBtn = document.createElement('button');
    sendOtpBtn.className = 'btn btn-custom mt-2';
    sendOtpBtn.type = 'button';
    sendOtpBtn.id = 'sendOtpBtn';
    sendOtpBtn.textContent = 'Send OTP';
    newEmailInput.insertAdjacentElement('afterend', sendOtpBtn);

    const otpSection = document.getElementById("otpSection");
    const emailDisplay = document.getElementById("emailDisplay");
    const otpInput = document.getElementById("otpInput");
    const verifyOtpBtn = document.getElementById("verifyOtpBtn");
    const otpStatus = document.getElementById("otpStatus");
    const otpAttempts = document.getElementById("otpAttempts");
    const emailVerifiedInput = document.getElementById("emailVerified");

    // OTP settings
    const MAX_RESEND_ATTEMPTS = 3;
    const RESEND_COOLDOWN = 30; // 30 seconds
    let resendAttempts = 1;
    let resendTimerInterval = null;
    let canSendOtp = true;

    // Track original email
    const originalEmail = newEmailInput.value;

    // Hide OTP button if email hasn't changed
    if (newEmailInput.value === originalEmail) {
        sendOtpBtn.style.display = 'none';
        emailVerifiedInput.value = 'true';
    } else {
        sendOtpBtn.style.display = 'block';
    }

    // Email change handler
    newEmailInput.addEventListener('input', function() {
        if (this.value !== originalEmail) {
            sendOtpBtn.style.display = 'block';
            emailVerifiedInput.value = 'false';
            otpSection.style.display = 'none';
            resetOtpState();
        } else {
            sendOtpBtn.style.display = 'none';
            otpSection.style.display = 'none';
            emailVerifiedInput.value = 'true';
        }
    });

    // Send OTP button click handler
    sendOtpBtn.addEventListener('click', function() {
        const email = newEmailInput.value.trim();
        
        if (!email || !isValidEmail(email)) {
            showAlert('Please enter a valid email address.', 'error');
            return;
        }
        
        if (!canSendOtp) {
            showAlert('Please wait for the cooldown period to end before requesting another OTP.', 'error');
            return;
        }
        
        if (otpSection.style.display === 'block') {
            resendAttempts++;
            updateAttemptsCounter();
        }
        
        sendOtp(email);
    });

    // Verify OTP button click handler
    verifyOtpBtn.addEventListener('click', function() {
        const email = newEmailInput.value.trim();
        const otp = otpInput.value.trim();
        
        if (!otp || otp.length !== 6 || !/^\d+$/.test(otp)) {
            otpStatus.textContent = 'Please enter a valid 6-digit code.';
            otpStatus.className = 'text-error';
            return;
        }
        
        verifyOtp(email, otp);
    });

    // OTP input validation
    otpInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // Function to send OTP
    function sendOtp(email) {
        sendOtpBtn.disabled = true;
        sendOtpBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Sending...';
        canSendOtp = false;
        
        let params = new URLSearchParams({
            action: 'sendOTP',
            email: email
        });
        
        fetch("EmailServiceServlet", {
            method: "POST",
            body: params
        })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === "success") {
                otpSection.style.display = 'block';
                emailDisplay.textContent = maskEmail(email);
                otpStatus.textContent = 'Verification code sent successfully.';
                otpStatus.className = 'text-success';
                otpInput.value = '';
                otpInput.focus();
                
                if (resendAttempts < MAX_RESEND_ATTEMPTS) {
                    startRegularCooldown();
                }
                
                updateAttemptsCounter();
            } else {
                sendOtpBtn.disabled = false;
                sendOtpBtn.textContent = otpSection.style.display === 'block' ? 'Resend OTP' : 'Send OTP';
                showAlert('Failed to send verification code. Please try again.', 'error');
                canSendOtp = true;
            }
        })
        .catch(error => {
            sendOtpBtn.disabled = false;
            sendOtpBtn.textContent = otpSection.style.display === 'block' ? 'Resend OTP' : 'Send OTP';
            canSendOtp = true;
            showAlert('Error sending verification code: ' + error.message, 'error');
            console.error("Error sending OTP:", error);
        });
    }
    
    // Function to verify OTP
    function verifyOtp(email, inputOTP) {
        verifyOtpBtn.disabled = true;
        verifyOtpBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Verifying...';
        
        let params = new URLSearchParams({
            action: 'validateOTP',
            email: email,
            inputOTP: inputOTP
        });
        
        fetch("EmailServiceServlet", {
            method: "POST",
            body: params
        })
        .then(response => response.text())
        .then(data => {
            verifyOtpBtn.disabled = false;
            verifyOtpBtn.textContent = 'Verify';
            
            if (data.trim() === "success") {
                otpSection.querySelector('.verification-badge').classList.add('verified');
                otpSection.querySelector('.badge-text').textContent = 'Verified';
                otpStatus.textContent = 'Email verified successfully!';
                otpStatus.className = 'text-success';
                verifyOtpBtn.textContent = 'Verified';
                sendOtpBtn.innerHTML = 'Verified';
                otpAttempts.textContent = '';
                
                clearInterval(resendTimerInterval);
                canSendOtp = true;
                
                emailVerifiedInput.value = 'true';
                newEmailInput.classList.add('is-valid');
                newEmailInput.readOnly = true;
                sendOtpBtn.disabled = true;
                otpInput.readOnly = true;
                otpInput.classList.add('is-valid');
                verifyOtpBtn.disabled = true;
                
                showAlert('Email verification successful! You can now save your changes.', 'success');
            } else {
                otpStatus.textContent = 'Invalid verification code. Please try again.';
                otpStatus.className = 'text-error';
            }
        })
        .catch(error => {
            verifyOtpBtn.disabled = false;
            verifyOtpBtn.textContent = 'Verify';
            otpStatus.textContent = 'Error verifying code. Please try again.';
            otpStatus.className = 'text-error';
            console.error("Error verifying OTP:", error);
        });
    }
    
    // Function to start regular cooldown
    function startRegularCooldown() {
        let counter = RESEND_COOLDOWN;
        
        sendOtpBtn.disabled = true;
        sendOtpBtn.innerHTML = `<span class="timer-text">Resend OTP (${counter}s)</span>`;
        sendOtpBtn.classList.add('btn-cooldown');
        
        clearInterval(resendTimerInterval);
        resendTimerInterval = setInterval(() => {
            counter--;
            if (counter <= 0) {
                clearInterval(resendTimerInterval);
                sendOtpBtn.innerHTML = 'Resend OTP';
                sendOtpBtn.disabled = false;
                sendOtpBtn.classList.remove('btn-cooldown');
                canSendOtp = true;
                return;
            }
            sendOtpBtn.innerHTML = `<span class="timer-text">Resend OTP (${counter}s)</span>`;
        }, 1000);
    }
    
    // Function to update attempts counter
    function updateAttemptsCounter() {
        otpAttempts.textContent = `Attempts: ${resendAttempts}/${MAX_RESEND_ATTEMPTS}`;
        otpAttempts.className = 'text-muted';
    }
    
    // Function to reset OTP state
    function resetOtpState() {
        clearInterval(resendTimerInterval);
        resendAttempts = 1;
        canSendOtp = true;
        
        sendOtpBtn.disabled = false;
        sendOtpBtn.classList.remove('btn-cooldown');
        sendOtpBtn.textContent = 'Send OTP';
        
        updateAttemptsCounter();
    }
}

function updateProfile(userId) {
    const newUsername = document.getElementById("newUsername").value;
    const newEmail = document.getElementById("newEmail").value;
    const newPassword = document.getElementById("newPassword").value;
    const emailVerified = document.getElementById("emailVerified").value;
    const originalEmail = document.getElementById("newEmail").defaultValue;

    // Check if email changed and not verified
    if (newEmail !== originalEmail && emailVerified !== 'true') {
        showAlert('Please verify your new email address before saving changes.', 'error');
        return;
    }

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

// Helper function to validate email format
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Helper function to mask email for display
function maskEmail(email) {
    if (!email) return '';
    
    const parts = email.split('@');
    if (parts.length !== 2) return email;
    
    let name = parts[0];
    const domain = parts[1];
    
    if (name.length <= 2) {
        return name + '***@' + domain;
    }
    
    return name.substring(0, 2) + '***@' + domain;
}

// Helper function to show alerts
function showAlert(message, type) {
    const alertContainer = document.getElementById('errorMessage');
    
    // Remove any existing alerts
    const existingAlerts = alertContainer.querySelectorAll('.alert');
    existingAlerts.forEach(alert => alert.remove());
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type === 'error' ? 'danger' : 'success'} alert-dismissible fade show`;
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    alertContainer.appendChild(alertDiv);
    
    // Auto dismiss after 5 seconds
    setTimeout(() => {
        if (alertDiv.parentNode === alertContainer) {
            alertDiv.classList.remove('show');
            setTimeout(() => alertDiv.remove(), 150);
        }
    }, 5000);
}