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
    <title>Account Settings</title>
    <script >
        // Function to check if entered username matches
        function checkUsername() {
            var enteredUsername = document.getElementById('enteredUsername').value;
            var storedUsername = document.getElementById('storedUsername').value;
            var deleteButton = document.getElementById('deleteButton');

            if (enteredUsername === storedUsername) {
                deleteButton.disabled = false; // Enable delete button
            } else {
                deleteButton.disabled = true; // Disable delete button
            }
        }

        // Function to confirm deletion
        function confirmDeletion() {
            var enteredUsername = document.getElementById('enteredUsername').value;
            var storedUsername = document.getElementById('storedUsername').value;

            if (enteredUsername === storedUsername) {
                if (confirm("Are you sure you want to delete your account?")) {
                    // Proceed with form submission or Ajax request
                    document.getElementById('deleteForm').submit();
                }
            } else {
                alert("The username does not match. Please enter the correct username.");
            }
        }
    </script>
</head>
<body>
    <%
    // Prevent Browsing from caching the page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    %>
    
    <jsp:include page="../../components/navbar.jsp"/>
    
    <h1>Account Settings</h1>
    
    <!-- Display the username for reference -->
    <p><strong>Your Username: </strong><span id="userReference">${ user.userName }</span></p>
    
    <input type="hidden" id="storedUsername" value="${ user.userName }">
    
    <!-- Input field for username check -->
    <label for="enteredUsername">Enter your username to confirm deletion:</label>
    <input type="text" id="enteredUsername" onkeyup="checkUsername()">
    
    <!-- Form to submit deletion -->
    <form id="deleteForm" action="DeleteAccountServlet" method="post" style="display: none;">
        <input type="hidden" name="userId" value="${user.userId}">
    </form>

    <!-- Delete Account Button -->
    <button id="deleteButton" onclick="confirmDeletion()" disabled>Delete My Account</button>
    
    <% if(request.getAttribute("error") != null) { %>
        <div>
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
</body>
</html>
