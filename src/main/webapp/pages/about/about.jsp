<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About QuizKar - Interactive Learning Platform</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body class="about-page">
    <jsp:include page="../../components/navbar.jsp"/>
    
    <!-- Hero Section -->
    <section class="about-hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4 animate__animated animate__fadeInDown">About QuizKar</h1>
                    <p class="lead animate__animated animate__fadeInUp">An interactive learning platform created by Omkar Kshirsagar</p>
                </div>
                <div class="col-lg-6 animate__animated animate__fadeIn">
                    <img src="${pageContext.request.contextPath}/images/about-hero.png" alt="Learning illustration" class="img-fluid">
                </div>
            </div>
        </div>
    </section>

    <!-- Developer Section -->
    <section class="developer-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center mb-5">
                    <h2 class="section-title animate__animated animate__fadeIn">Meet the Developer</h2>
                    <div class="divider mx-auto"></div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="developer-card animate__animated animate__fadeInUp">
                        <div class="developer-img">
                            <img src="${pageContext.request.contextPath}/images/developer.jpg" alt="Omkar Kshirsagar" class="img-fluid rounded-circle">
                        </div>
                        <div class="developer-info">
                            <h3>Omkar Kshirsagar</h3>
                            <p class="text-muted">Engineering Student & Softwere Developer</p>
                            <p class="developer-bio">
                               I created <strong>QuizKar</strong> to showcase my technical skills and passion for education technology. It uses a <strong>Java backend</strong> with <strong>JDBC, Servlets, JSP</strong>, and <strong>PostgreSQL</strong> for data handling. The frontend is built using <strong>HTML, CSS, JS</strong>, and dynamic <strong>JSP pages</strong>. This project reflects my full-stack development skills and understanding of modern web application design.

                            </p>
                            <div class="social-links">
                                <a href="https://github.com/kshirsagar-omkar" target="_blank" class="btn btn-outline-dark">
                                    <i class="bi bi-github"></i> GitHub
                                </a>
                                <a href="https://www.linkedin.com/in/omkar-kshirsagar-64737a28a" target="_blank" class="btn btn-outline-primary">
                                    <i class="bi bi-linkedin"></i> LinkedIn
                                </a>
                                <a href="https://www.instagram.com/ok.0005" target="_blank" class="btn btn-outline-danger">
                                    <i class="bi bi-instagram"></i> Instagram
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Project Details Section -->
    <section class="project-section py-5 bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center mb-5">
                    <h2 class="section-title animate__animated animate__fadeIn">Project Highlights</h2>
                    <div class="divider mx-auto"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp">
                    <div class="feature-card">
                        <div class="feature-icon bg-primary">
                            <i class="bi bi-diagram-3"></i>
                        </div>
                        <h3>MVC Architecture</h3>
                        <p>Implemented clean Model-View-Controller separation for maintainable and scalable code</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.1s">
                    <div class="feature-card">
                        <div class="feature-icon bg-success">
                            <i class="bi bi-database"></i>
                        </div>
                        <h3>PostgreSQL</h3>
                        <p>Robust relational database design for efficient data management</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                    <div class="feature-card">
                        <div class="feature-icon bg-info">
                            <i class="bi bi-robot"></i>
                        </div>
                        <h3>AI Chatbot</h3>
                        <p>Integrated intelligent chatbot for enhanced user experience</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.3s">
                    <div class="feature-card">
                        <div class="feature-icon bg-warning">
                            <i class="bi bi-person-badge"></i>
                        </div>
                        <h3>Role Management</h3>
                        <p>Comprehensive user and admin functionalities with proper access control</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.4s">
                    <div class="feature-card">
                        <div class="feature-icon bg-danger">
                            <i class="bi bi-lightning-charge"></i>
                        </div>
                        <h3>JSP & Servlets</h3>
                        <p>Dynamic content rendering with JavaServer Pages and Java Servlets</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.5s">
                    <div class="feature-card">
                        <div class="feature-icon bg-secondary">
                            <i class="bi bi-phone"></i>
                        </div>
                        <h3>Responsive Design</h3>
                        <p>Fully responsive interface that works on all devices</p>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-5 animate__animated animate__fadeIn">
                <a href="https://github.com/kshirsagar-omkar/QuizKar" target="_blank" class="btn btn-primary btn-lg">
                    <i class="bi bi-code-slash"></i> View Project on GitHub
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
   

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>