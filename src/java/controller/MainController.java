package controller;

import dao.DatabaseConnection;
import dao.EventDAO;
import dao.EventRegistrationDAO;
import dao.UserDAO;
import dao.VenueDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Event;

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
        } else if ("home".equals(action) || action == null) {
            showHomePage(request, response);
        } else {
            // Default redirect to home
            showHomePage(request, response);
        }
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("login".equals(action)) {
        login(request, response);
    } else if ("signup".equals(action)) {
        signup(request, response);
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}

 private void signup(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String userName   = request.getParameter("userName");
    String userEmail  = request.getParameter("userEmail");
    String userPhone  = request.getParameter("userPhoneNo");
    String password   = request.getParameter("password");
    String role       = request.getParameter("userRole"); // "student"

    // Validasi ringkas
    if (userName==null||userEmail==null||password==null||
        userName.trim().isEmpty()||userEmail.trim().isEmpty()||password.trim().isEmpty()) {
        request.setAttribute("error","Please fill in all required fields.");
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
        return;
    }
    // Semak emel wujud
    if (userDAO.emailExists(userEmail)) {
        request.setAttribute("error","Email already registered.");
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
        return;
    }
    // Jana userID (prefix student perlu ditambah dalam DAO)
    String newID = userDAO.generateNextUserID(role);
    if (newID==null) {
        request.setAttribute("error","Unable to generate User ID.");
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
        return;
    }
    // Create User dan simpan
    User u = new User(newID, userName, userEmail, userPhone, password, role);
    u.setUserStatus("active");
    boolean ok = userDAO.createUser(u); // 
    if (ok) {
        // Kalau berjaya, redirect ke signup.jsp?success=true
        response.sendRedirect(request.getContextPath() + "/signup.jsp?success=true");
        return;   // pastikan return supaya tak berjalan kod di bawah
    } else {
        request.setAttribute("error","Sign up failed; try again.");
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
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
    

private void showHomePage(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Initialize DAOs
        EventDAO eventDAO = new EventDAO();
        VenueDAO venueDAO = new VenueDAO();
        UserDAO userDAO = new UserDAO();
        EventRegistrationDAO registrationDAO = new EventRegistrationDAO();
        
        // Get upcoming approved events (limit to 6 for display)
        List<Event> upcomingEvents = eventDAO.getAllApprovedEvents();
        
        // Get statistics for the stats section
        int totalActiveEvents = upcomingEvents.size();
        int totalParticipants = getTotalParticipants(eventDAO);
        int totalOrganizations = userDAO.getTotalOrganizations();
        int totalVenues = venueDAO.getTotalVenues();
        
        // Set attributes
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("totalActiveEvents", totalActiveEvents);
        request.setAttribute("totalParticipants", totalParticipants);
        request.setAttribute("totalOrganizations", totalOrganizations);
        request.setAttribute("totalVenues", totalVenues);
        
        // Forward to home page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        
    } catch (Exception e) {
        e.printStackTrace();
        // If error, still show home page but with empty data
        request.setAttribute("upcomingEvents", new ArrayList<>());
        request.setAttribute("totalActiveEvents", 0);
        request.setAttribute("totalParticipants", 0);
        request.setAttribute("totalOrganizations", 0);
        request.setAttribute("totalVenues", 0);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

// Helper method to calculate total participants across all events
private int getTotalParticipants(EventDAO eventDAO) {
    try {
        // You might need to add this method to EventDAO
        return eventDAO.getTotalParticipantsAllEvents();
    } catch (Exception e) {
        return 0; // Return 0 if error
    }
}

// Add these methods to your UserDAO.java
public int getTotalOrganizations() {
    String sql = "SELECT COUNT(*) FROM user WHERE userRole = 'organization' AND userStatus = 'active'";
    
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.err.println("Error getting total organizations: " + e.getMessage());
    }
    return 0;
}

// Add this method to your EventDAO.java
public int getTotalParticipantsAllEvents() {
    String sql = "SELECT SUM(registeredCount) FROM event WHERE eventStatus = 'approved'";
    
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.err.println("Error getting total participants: " + e.getMessage());
    }
    return 0;
}
}