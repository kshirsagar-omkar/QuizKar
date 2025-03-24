<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("user") != null) {
        if("admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            response.sendRedirect("user/dashboard.jsp");
        }
    } else {
        response.sendRedirect("pages/auth/login.jsp");
    }
%>