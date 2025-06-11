package com.activity.filter;

import com.activity.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*") // Semua permintaan akan melalui filter ini
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        // Halaman yang tak perlu login
        if (uri.contains("signin.jsp") || uri.contains("signup.jsp") || uri.contains("LoginController") || uri.contains("css") || uri.contains("images")) {
            chain.doFilter(req, res);
            return;
        }

        // Semak jika pengguna login
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("signin.jsp?error=unauthorized");
            return;
        }

        // Ambil maklumat pengguna
        User user = (User) session.getAttribute("currentUser");
        String role = user.getRole();

        // Kawal akses ikut role
        if (uri.contains("studentDashboard") && !"student".equals(role)) {
            response.sendRedirect("signin.jsp?error=forbidden");
        } else if (uri.contains("staffDashboard") && !"staff".equals(role)) {
            response.sendRedirect("signin.jsp?error=forbidden");
        } else if (uri.contains("adminDashboard") && !"admin".equals(role)) {
            response.sendRedirect("signin.jsp?error=forbidden");
        } else if (uri.contains("orgDashboard") && !"organization".equals(role)) {
            response.sendRedirect("signin.jsp?error=forbidden");
        } else {
            // Lulus dan teruskan permintaan
            chain.doFilter(req, res);
        }
    }
}
