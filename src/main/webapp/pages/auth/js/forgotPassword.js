document.addEventListener('DOMContentLoaded', function() {
    // Form elements
    const emailInput = document.getElementById('email');
    const sendOtpBtn = document.getElementById('sendOtpBtn');
    const otpSection = document.getElementById('otpSection');
    const emailDisplay = document.getElementById('emailDisplay');
    const otpInput = document.getElementById('otpInput');
    const verifyOtpBtn = document.getElementById('verifyOtpBtn');
    const otpStatus = document.getElementById('otpStatus');
    const otpAttempts = document.getElementById('otpAttempts');
    const newPasswordSection = document.getElementById('newPasswordSection');
    const resetPasswordBtn = document.getElementById('resetPasswordBtn');
    const emailVerifiedInput = document.getElementById('emailVerified');
    const alertContainer = document.getElementById('alertContainer');
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    
    // OTP settings (same as register.js)
    const MAX_RESEND_ATTEMPTS = 3;
    const RESEND_COOLDOWN = 30;
    const MAX_ATTEMPTS_COOLDOWN = 5 * 60;
    let resendAttempts = 1;
    let resendTimerInterval = null;
    let maxAttemptsTimerInterval = null;
    let canSendOtp = true;
    let maxAttemptsReached = false;
    
    // Password visibility toggle
    togglePassword.addEventListener('click', function() {
        const icon = this.querySelector('i');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.replace('bi-eye', 'bi-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.replace('bi-eye-slash', 'bi-eye');
        }
    });
    
    // Form submission
    document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        if (emailVerifiedInput.value !== 'true') {
            showAlert('Please verify your email before resetting password.', 'error');
            return;
        }
        
        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();
        
        if (!password) {
            showAlert('Please enter a new password.', 'error');
            return;
        }
        
        resetPasswordBtn.disabled = true;
        resetPasswordBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Resetting...';
        
        let params = new URLSearchParams({
            action: 'updatePassword',
            email: email,
            password: password
        });
        
        fetch("UserEditProfile", {
            method: "POST",
            body: params
        })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === "success") {
                showAlert('Password reset successfully! You can now login with your new password.', 'success');
                setTimeout(() => {
                    window.location.href = 'login';
                }, 3000);
            } else {
                resetPasswordBtn.disabled = false;
                resetPasswordBtn.textContent = 'Reset Password';
                showAlert('Failed to reset password. Please try again.', 'error');
            }
        })
        .catch(error => {
            resetPasswordBtn.disabled = false;
            resetPasswordBtn.textContent = 'Reset Password';
            showAlert('Error resetting password: ' + error.message, 'error');
            console.error("Error resetting password:", error);
        });
    });
    
    // The rest of the OTP functions are identical to register.js
    // (sendOtp, verifyOtp, isValidEmail, maskEmail, showAlert, etc.)
    // Include all the functions from register.js here
    
    // Send OTP button click handler
    sendOtpBtn.addEventListener('click', function() {
        const email = emailInput.value.trim();
        
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
            
            if (resendAttempts >= MAX_RESEND_ATTEMPTS) {
                startMaxAttemptsTimer();
            }
        }
        
        sendOtp(email);
    });
    
    // Verify OTP button click handler
    verifyOtpBtn.addEventListener('click', function() {
        const email = emailInput.value.trim();
        const otp = otpInput.value.trim();
        
        if (!otp || otp.length !== 6 || !/^\d+$/.test(otp)) {
            otpStatus.textContent = 'Please enter a valid 6-digit code.';
            otpStatus.className = 'text-error';
            return;
        }
        
        verifyOtp(email, otp);
    });
    
    // Email input change handler
    emailInput.addEventListener('input', function() {
        emailVerifiedInput.value = 'false';
        resetPasswordBtn.disabled = true;
        otpSection.style.display = 'none';
        newPasswordSection.style.display = 'none';
        resetOtpState();
    });
    
    // OTP input validation
    otpInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
    
    // Function to send OTP (same as register.js)
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
                
                if (!maxAttemptsReached) {
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
    
    // Function to verify OTP (modified for forgot password)
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
                
                clearAllTimers();
                
                emailVerifiedInput.value = 'true';
                emailInput.classList.add('is-valid');
                emailInput.readOnly = true;
                sendOtpBtn.disabled = true;
                otpInput.readOnly = true;
                otpInput.classList.add('is-valid');
                verifyOtpBtn.disabled = true;
                
                // Show password section
                newPasswordSection.style.display = 'block';
                resetPasswordBtn.disabled = false;
                
                showAlert('Email verification successful! You can now reset your password.', 'success');
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
    
    // Include all other helper functions from register.js (isValidEmail, maskEmail, etc.)
    // ...

	// Function to validate email format
	function isValidEmail(email) {
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    return emailRegex.test(email);
	}

	// Function to mask email for display
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

	// Function to show alerts
	function showAlert(message, type) {
	    // Remove any existing alerts
	    const existingAlerts = alertContainer.querySelectorAll('.alert');
	    existingAlerts.forEach(alert => alert.remove());
	    
	    const alertDiv = document.createElement('div');
	    alertDiv.className = `alert alert-${type === 'error' ? 'custom' : 'success'} alert-dismissible fade show`;
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

	// Function to handle regular cooldown (30 seconds)
	function startRegularCooldown() {
	    let counter = RESEND_COOLDOWN;
	    
	    // Update button state
	    sendOtpBtn.disabled = true;
	    sendOtpBtn.innerHTML = `<span class="timer-text">Resend OTP (${counter}s)</span>`;
	    sendOtpBtn.classList.add('btn-cooldown');
	    
	    clearInterval(resendTimerInterval);
	    resendTimerInterval = setInterval(() => {
	        counter--;
	        if (counter <= 0) {
	            clearRegularCooldown();
	            return;
	        }
	        sendOtpBtn.innerHTML = `<span class="timer-text">Resend OTP (${counter}s)</span>`;
	    }, 1000);
	}

	// Function to clear regular cooldown timer
	function clearRegularCooldown() {
	    clearInterval(resendTimerInterval);
	    sendOtpBtn.innerHTML = 'Resend OTP';
	    sendOtpBtn.disabled = false;
	    sendOtpBtn.classList.remove('btn-cooldown');
	    canSendOtp = true;
	}

	// Function to start 5-minute timer after max attempts
	function startMaxAttemptsTimer() {
	    let counter = MAX_ATTEMPTS_COOLDOWN;
	    maxAttemptsReached = true;
	    canSendOtp = false;
	    
	    // Update attempts message to simple text without timer
	    otpAttempts.textContent = "Max attempts reached.";
	    otpAttempts.className = "text-error fw-bold mt-2";
	    
	    // Disable OTP input and verify button
	    //otpInput.disabled = true;
	    //verifyOtpBtn.disabled = true;
		
	    
	    // Update button to show the 5-minute cooldown
	    sendOtpBtn.disabled = true;
	    sendOtpBtn.classList.add('btn-cooldown', 'btn-max-attempts');
	    
	    // Format initial time display
	    const minutes = Math.floor(counter / 60);
	    const seconds = counter % 60;
	    const timeDisplay = `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
	    
	    sendOtpBtn.innerHTML = `
	        <span class="timer-icon"><i class="bi bi-hourglass-split"></i></span>
	        <span class="timer-text">Try again in ${timeDisplay}</span>
	    `;
	    
	    // Clear any existing intervals
	    clearInterval(maxAttemptsTimerInterval);
	    clearInterval(resendTimerInterval);
	    
	    // Start the countdown
	    maxAttemptsTimerInterval = setInterval(() => {
	        counter--;
	        const minutes = Math.floor(counter / 60);
	        const seconds = counter % 60;
	        
	        const timeDisplay = `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
	        sendOtpBtn.innerHTML = `
	            <span class="timer-icon"><i class="bi bi-hourglass-split"></i></span>
	            <span class="timer-text">Try again in ${timeDisplay}</span>
	        `;
	        
	        if (counter <= 0) {
	            clearMaxAttemptsTimer();
	        }
	    }, 1000);
	}

	// Function to clear max attempts timer
	function clearMaxAttemptsTimer() {
	    clearInterval(maxAttemptsTimerInterval);
	    resendAttempts = 1;
	    maxAttemptsReached = false;
	    canSendOtp = true;
	    
	    // Re-enable OTP input and verify button
	    otpInput.disabled = false;
	    verifyOtpBtn.disabled = false;
	    
	    // Reset the send button
	    sendOtpBtn.disabled = false;
	    sendOtpBtn.classList.remove('btn-cooldown', 'btn-max-attempts');
	    sendOtpBtn.innerHTML = 'Resend OTP';
	    
	    // Reset attempts counter
	    updateAttemptsCounter();
	}

	// Function to update attempts counter
	function updateAttemptsCounter() {
	    if (maxAttemptsReached) {
	        // Keep the "Max attempts reached" message
	        return;
	    }
	    
	    if (resendAttempts === 0) {
	        otpAttempts.textContent = '';
	        otpAttempts.className = 'text-muted';
	    } else {
	        otpAttempts.textContent = `Attempts: ${resendAttempts}/${MAX_RESEND_ATTEMPTS}`;
	        otpAttempts.className = 'text-muted';
	    }
	}

	// Function to clear all timers
	function clearAllTimers() {
	    clearInterval(resendTimerInterval);
	    clearInterval(maxAttemptsTimerInterval);
	    canSendOtp = true;
	    maxAttemptsReached = false;
	}

	// Function to reset OTP state
	function resetOtpState() {
	    clearAllTimers();
	    resendAttempts = 1;
	    
	    // Reset button states
	    sendOtpBtn.disabled = false;
	    sendOtpBtn.classList.remove('btn-cooldown', 'btn-max-attempts');
	    sendOtpBtn.textContent = 'Send OTP';
	    
	    // Reset attempts counter
	    updateAttemptsCounter();
	}
});