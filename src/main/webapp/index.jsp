<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quizkar.entities.Users" %>

<% Users user = (Users) session.getAttribute("user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizKar - Interactive Learning Platform</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <!-- Homepage CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body class="home-page">

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    %>

    <!-- Navbar -->
    <jsp:include page="./components/navbar.jsp"/>
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 hero-content animate__animated animate__fadeInLeft">
                    <h1 class="hero-title">Master Your Subjects with <span>QuizKar</span></h1>
                    <p class="hero-subtitle">Interactive quizzes and study plans to boost your learning experience</p>
                    <div class="hero-buttons">
                        <% if(user == null) { %>
                            <a href="login" class="btn btn-primary btn-lg me-3">
                                <i class="bi bi-box-arrow-in-right"></i> Login
                            </a>
                            <a href="register" class="btn btn-outline-light btn-lg">
                                <i class="bi bi-person-plus"></i> Register
                            </a>
                        <% } else { %>
                            <a href="<%= "admin".equals(user.getRole()) ? "admindashboard" : "UserDashboard" %>" 
                               class="btn btn-primary btn-lg">
                                <i class="bi bi-speedometer2"></i> Go to Dashboard
                            </a>
                        <% } %>
                    </div>
                </div>
                <div class="col-lg-6 hero-image animate__animated animate__fadeInRight">
                    <img src="${pageContext.request.contextPath}/images/hero-illustration.png" alt="Learning Illustration" class="img-fluid">
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title text-center">Why Choose QuizKar?</h2>
            <div class="row">
                <div class="col-md-4 feature-card animate__animated animate__fadeInUp">
                    <div class="feature-icon bg-primary">
                        <i class="bi bi-lightning-charge"></i>
                    </div>
                    <h3>Interactive Quizzes</h3>
                    <p>Test your knowledge with our engaging quiz system that provides instant feedback.</p>
                </div>
                <div class="col-md-4 feature-card animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                    <div class="feature-icon bg-success">
                        <i class="bi bi-journal-bookmark"></i>
                    </div>
                    <h3>Study Plans</h3>
                    <p>Structured learning paths to help you master subjects systematically.</p>
                </div>
                <div class="col-md-4 feature-card animate__animated animate__fadeInUp" style="animation-delay: 0.4s">
                    <div class="feature-icon bg-info">
                        <i class="bi bi-graph-up"></i>
                    </div>
                    <h3>Progress Tracking</h3>
                    <p>Monitor your improvement with detailed analytics and performance reports.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section">
        <div class="container">
            <h2 class="section-title text-center">What Our Users Say</h2>
            <div class="row">
                <div class="col-md-4 testimonial-card animate__animated animate__fadeIn">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="bi bi-quote"></i>
                        </div>
                        <p>As a software developer, it's great to see a website like this—it will be very helpful for students in their studies. One of the best things is that all the materials are available in one place.
</p>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/images/user1.jpeg" alt="User" class="user-avatar">
                            <div>
                                <h5>Abhishek Jadhav</h5>
                                <p class="text-muted">Product Engineer, Seclore Technology.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 testimonial-card animate__animated animate__fadeIn" style="animation-delay: 0.2s">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="bi bi-quote"></i>
                        </div>
                        <p>I’m extremely proud of one of my student Omkar, who has successfully built a Quiz Application using a well-rounded tech stack including Java (Servlets), JSP, HTML, CSS, Bootstrap, and thoughtfully integrated modern AI tools like ChatGPT and DeepSeek to enhance development through smart prompting.

This project is a reflection of his strong grasp of backend and frontend technologies, clean UI design, and an innovative approach to problem-solving. What impressed me the most was his curiosity to explore, willingness to learn, and consistency in execution.

His ability to combine traditional development with cutting-edge AI tools shows not just technical skills, but also a forward-thinking mindset—which is exactly what the tech world needs today.

Your dedication, hard work, and passion for technology truly stand out. Keep pushing boundaries, experimenting, and evolving, this is just the beginning of a bright journey ahead.

Many congratulations once again and super proud of you ❣️🙌🏻</p>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/images/user2.jpeg" alt="User" class="user-avatar">
                            <div>
                                <h5>Sachin Sir</h5>
                                <p class="text-muted">Founder & CEO @Techno Comp Academy</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="col-md-4 testimonial-card animate__animated animate__fadeIn" style="animation-delay: 0.4s">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="bi bi-quote"></i>
                        </div>
                        <p>I recently visited QuizKar, a quiz-based website developed by Omkar, and I must say I'm genuinely impressed by the overall design and functionality. The UI is clean, modern, and user-friendly, making the whole experience smooth and enjoyable. The color scheme and layout are well-thought-out, which helps maintain focus while navigating through different sections of the site.

One thing that stood out to me was the excellent UI/UX experience – everything feels intuitive, and the design flows naturally from one section to another. The redirection between pages is seamless, with quick load times and no unnecessary lag.</p>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/images/user4.jpeg" alt="User" class="user-avatar">
                            <div>
                                <h5>Aniket Belgaonkar</h5>
                                <p class="text-muted">M.Sc Computer Application.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="col-md-4 testimonial-card animate__animated animate__fadeIn" style="animation-delay: 0.4s">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="bi bi-quote"></i>
                        </div>
                        <p>it’s nicely developed, very intuitive, and everything is working smoothly.</p>
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/images/user3.enc" alt="User" class="user-avatar">
                            <div>
                                <h5>Bhagyesh </h5>
                                <p class="text-muted">FY MCA, Sri Balaji University, Pune</p>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container text-center animate__animated animate__fadeIn">
            <h2>Ready to Transform Your Learning Experience?</h2>
            <% if(user == null) { %>
                <a href="register" class="btn btn-light btn-lg mt-3">
                    <i class="bi bi-rocket"></i> Get Started Now
                </a>
            <% } else { %>
                <a href="<%= "admin".equals(user.getRole()) ? "admindashboard" : "UserDashboard" %>" 
                   class="btn btn-light btn-lg mt-3">
                    <i class="bi bi-speedometer2"></i> Continue Learning
                </a>
            <% } %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>QuizKar</h5>
                    <p>An interactive learning platform designed to make studying engaging and effective.</p>
                </div>
                <div class="col-md-2">
                    <h5>Links</h5>
                    <ul>
                        <li><a href=".">Home</a></li>
                        <li><a href="#">Features</a></li>
                        <li><a href="AboutUs">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Contact</h5>
                    <p><i class="bi bi-envelope"></i> info@quizkar.com</p>
                    <p><i class="bi bi-telephone"></i> +91 9309272458</p>
                </div>
                <div class="col-md-3">
                    <h5>Follow Us</h5>
                    <div class="social-links">
                        <a href="https://github.com/kshirsagar-omkar" target="_blank"><i class="bi bi-github"></i></a>
                        <a href="#"><i class="bi bi-twitter"></i></a>
                        <a href="https://www.instagram.com/ok.0005" target="_blank"><i class="bi bi-instagram"></i></a>
                        <a href="https://www.linkedin.com/in/omkar-kshirsagar-64737a28a" target="_blank"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p>&copy; 2025 QuizKar. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/js/home.js"></script>
    <jsp:include page="components/chatbot.jsp"/>
</body>
</html>