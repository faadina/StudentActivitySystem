package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/controller")
public class MainController extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            logout(request, response);
        } else {
            // Default redirect to login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            login(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        try {
            User user = userDAO.authenticateUser(email.trim(), password);
            
            if (user != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("userID", user.getUserID());
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userEmail", user.getUserEmail());
                session.setAttribute("userRole", user.getUserRole());
                
                // Redirect based on role
                switch (user.getUserRole().toLowerCase()) {
                    case "organization":
                        response.sendRedirect(request.getContextPath() + "/organization?action=dashboard");
                        break;
                    case "student":
                        response.sendRedirect(request.getContextPath() + "/student?action=dashboard");
                        break;
                    case "staff":
                        response.sendRedirect(request.getContextPath() + "/staff?action=dashboard");
                        break;
                    case "admin":
                        response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
                        break;
                    default:
                        request.setAttribute("error", "Invalid user role.");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                        break;
                }
            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/login.jsp?message=You have been logged out successfully.");
    }
}