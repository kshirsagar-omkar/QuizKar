<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizkar.entities.Users" %>

<%
    // Prevent unauthorized access
    Users user = (Users) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login");
    }
%>

<html>
<head>
    <title>Account Settings - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Settings-specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/settings.css?v1">
    
    <script>
        // Function to check if entered username matches
        function checkUsername() {
            var enteredUsername = document.getElementById('enteredUsername').value;
            var storedUsername = document.getElementById('storedUsername').value;
            var deleteButton = document.getElementById('deleteButton');
            var matchIndicator = document.getElementById('usernameMatchIndicator');

            if (enteredUsername === storedUsername) {
                deleteButton.disabled = false;
                matchIndicator.innerHTML = '<span class="text-success"><i class="bi bi-check-circle-fill"></i> Username matches</span>';
            } else {
                deleteButton.disabled = true;
                if(enteredUsername.length > 0) {
                    matchIndicator.innerHTML = '<span class="text-danger"><i class="bi bi-x-circle-fill"></i> Username does not match</span>';
                } else {
                    matchIndicator.innerHTML = '';
                }
            }
        }

        // Function to confirm deletion
        function confirmDeletion() {
            var enteredUsername = document.getElementById('enteredUsername').value;
            var storedUsername = document.getElementById('storedUsername').value;

            if (enteredUsername === storedUsername) {
                // Bootstrap modal confirmation
                var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                deleteModal.show();
            } else {
                var toast = new bootstrap.Toast(document.getElementById('errorToast'));
                toast.show();
            }
        }
    </script>
</head>
<body class="bg-light">
    <%
    // Prevent Browsing from caching the page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
    
    <jsp:include page="../../components/navbar.jsp"/>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-danger text-white">
                        <h2 class="h4 mb-0"><i class="bi bi-exclamation-triangle-fill me-2"></i>Danger Zone</h2>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <h4 class="alert-heading"><i class="bi bi-exclamation-octagon-fill me-2"></i>Warning</h4>
                            <p>Deleting your account is permanent and cannot be undone. All your data, including quiz results and study progress, will be permanently removed.</p>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Your Username:</label>
                            <div class="p-3 bg-light rounded">
                                <code id="userReference">${user.userName}</code>
                            </div>
                        </div>
                        
                        <input type="hidden" id="storedUsername" value="${user.userName}">
                        
                        <form id="deleteForm" action="DeleteAccountServlet" method="post">
                            <input type="hidden" name="userId" value="${user.userId}">
                            
                            <div class="mb-3">
                                <label for="enteredUsername" class="form-label">Enter your username to confirm:</label>
                                <input type="text" class="form-control" id="enteredUsername" 
                                       onkeyup="checkUsername()" placeholder="Type your username exactly as shown above">
                                <div id="usernameMatchIndicator" class="form-text"></div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="button" id="deleteButton" onclick="confirmDeletion()" 
                                        class="btn btn-danger" disabled>
                                    <i class="bi bi-trash-fill me-2"></i>Delete My Account
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger mt-3">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Confirm Account Deletion</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you absolutely sure you want to delete your account?</p>
                    <p class="fw-bold">This action cannot be undone!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="document.getElementById('deleteForm').submit()">
                        Yes, Delete My Account
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Error Toast Notification -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    The username does not match. Please enter the correct username.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>