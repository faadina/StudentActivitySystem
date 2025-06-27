package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/organization/*", "/student/*", "/admin/*", "/staff/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Get session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("userID") != null);
        
        if (!isLoggedIn) {
            // Redirect to login page
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=Please login to access this page.");
            return;
        }
        
        // Check role-based access
        String userRole = (String) session.getAttribute("userRole");
        if (userRole != null) {
            boolean hasAccess = checkRoleAccess(requestURI, contextPath, userRole);
            
            if (!hasAccess) {
                // Redirect to appropriate dashboard or show access denied
                switch (userRole.toLowerCase()) {
                    case "organization":
                        httpResponse.sendRedirect(contextPath + "/organization?action=dashboard&error=Access denied.");
                        break;
                    case "student":
                        httpResponse.sendRedirect(contextPath + "/student?action=dashboard&error=Access denied.");
                        break;
                    case "staff":
                        httpResponse.sendRedirect(contextPath + "/staff?action=dashboard&error=Access denied.");
                        break;
                    case "admin":
                        httpResponse.sendRedirect(contextPath + "/admin?action=dashboard&error=Access denied.");
                        break;
                    default:
                        httpResponse.sendRedirect(contextPath + "/login.jsp?error=Invalid user role.");
                        break;
                }
                return;
            }
        }
        
        // User is authenticated and authorized, continue with the request
        chain.doFilter(request, response);
    }
    
    private boolean checkRoleAccess(String requestURI, String contextPath, String userRole) {
        String path = requestURI.substring(contextPath.length());
        
        switch (userRole.toLowerCase()) {
            case "organization":
                return path.startsWith("/organization") || path.startsWith("/org");
            case "student":
                return path.startsWith("/student");
            case "staff":
                return path.startsWith("/staff");
            case "admin":
                return path.startsWith("/admin");
            default:
                return false;
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}