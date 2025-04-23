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
    
    /**
     * When the user updates his details, then also update the session info
     * @param request The HTTP request
     * @param user The user to update session info
     */
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
     * set verified email in session, use at the time of registration and forgot password 
     * 
     * @param request The HTTP request
     * @param email The email id to set
     */
    public static void setVerifiedEmail(HttpServletRequest request, String email) {
    	HttpSession session = request.getSession(false);
    	if(session != null) {
    		session.setAttribute("verifiedEmail", email);
    	}else {
    		session = request.getSession();
    		session.setAttribute("verifiedEmail", email);
    	}
    }
    
    /**
     * get the verified email 
     * @param request
     * @return
     */
    public static String getVerifiedEmail(HttpServletRequest request) {
    	 HttpSession session = request.getSession(false);
         if (session != null) {
             return (String) session.getAttribute("verifiedEmail");
         }
         return null;
    }

    /**
     * remove verified email from session. 
     * when registration is complete or password is changed from forgot password page, then remove the email from session 
     * @param request The HTTP request
     */
    public static void removeVerifiedEmail(HttpServletRequest request) {
    	HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
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
//        response.sendRedirect(request.getContextPath());
        response.sendRedirect(".");
    }
}
