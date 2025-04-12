<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - QuizKar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body class="bg-light">
    <jsp:include page="../../components/navbar.jsp"/>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card auth-card mt-5">
                    <div class="card-body p-5">
                        <h1 class="text-center mb-4">Login</h1>
                        
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-custom mb-4">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <form action="login" method="post">
                            <div class="mb-3">
                                <label for="identifier" class="form-label">Username or Email</label>
                                <input type="text" name="identifier" id="identifier" class="form-control" required>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" name="password" id="password" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-custom w-100 py-2">Login</button>
                            
                            <div class="text-center mt-3">
                                <p class="text-muted">New user? <a href="register" class="text-decoration-none">Register here</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../../components/chatbot.jsp"/>
</body>
</html>