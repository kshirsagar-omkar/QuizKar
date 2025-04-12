package com.quizkar.util;

import java.io.IOException;

import com.quizkar.constants.Role;
import com.quizkar.entities.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for session management
 */
public class SessionUtil {
	
    /**
     * Sets a user in the session after successful login
     * @param request The HTTP request
     * @param user The user to store in session
     */
    public static void setUser(HttpServletRequest request, Users user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("username", user.getUserName());
        session.setAttribute("role", user.getRole());
        session.setAttribute("email", user.getEmail());
        
    }
    
    public static void updateUser(HttpServletRequest request, Users user) {
        HttpSession session = request.getSession(false); // Retrieve existing session if it exists
        if (session != null) {
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUserName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("email", user.getEmail());
        }
        else {
        	setUser(request, user);
        }
    }


    /**
     * Gets the currently logged in user from session
     * @param request The HTTP request
     * @return The User object or null if not logged in
     */
    public static Users getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Users) session.getAttribute("user");
        }
        return null;
    }

    /**
     * Checks if a user is logged in
     * @param request The HTTP request
     * @return true if logged in, false otherwise
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getUser(request) != null;
    }

    /**
     * Checks if the current user has a specific role
     * @param request The HTTP request
     * @param role The role to check for
     * @return true if user has the role, false otherwise
     */
    public static boolean hasRole(HttpServletRequest request, String role) {
        Users user = getUser(request);
        if (user != null) {
        	user.getRole().equalsIgnoreCase(role);
        }
        return false;
    }

    /**
     * Checks if the current user has any of the specified roles
     * @param request The HTTP request
     * @param roles Array of roles to check
     * @return true if user has any of the roles, false otherwise
     */
    public static boolean hasAnyRole(HttpServletRequest request, String[] roles) {
        Users user = getUser(request);
        if (user != null) {
            for (String role : roles) {
                if (user.getRole().equalsIgnoreCase(role)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Redirects to the appropriate dashboard based on user role
     * @param request The HTTP request
     * @param response The HTTP response
     * @throws IOException If an input or output exception occurs
     */
    public static void redirectToDashboard(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Users user = getUser(request);
        
        if (user != null) {
            switch (user.getRole()) {
                case Role.ADMIN:
                    response.sendRedirect(request.getContextPath() + "/admindashboard");
                    break;
                case Role.USER:
                    response.sendRedirect(request.getContextPath() + "/UserDashboard");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
        
    }

    /**
     * Invalidates the current session and redirects to login page
     * and delete the saved cookies
     * @param request The HTTP request
     * @param response The HTTP response
     * @throws IOException If an input or output exception occurs
     */
    public static void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            
            /*
            try {
            	Cookie[] cookies = request.getCookies();
            	if (cookies != null) {
                	for (Cookie cookie : cookies) {
                    	if ("rememberEmail".equals(cookie.getName()) || "rememberPassword".equals(cookie.getName())) {
                        	cookie.setMaxAge(0);
                        	cookie.setPath("/"); // Very important
                        	response.addCookie(cookie);
                    	}
                	}
            	}
            }catch(Exception e) {
            	
            }
             */
        }
        response.sendRedirect(request.getContextPath());
    }
}
