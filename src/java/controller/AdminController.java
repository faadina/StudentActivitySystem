package controller;

import dao.EventDAO;
import dao.UserDAO;
import dao.VenueBookingDAO;
import dao.ResourceBookingDAO;
import model.Event;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.Map;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.stream.Collectors;


@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private UserDAO userDAO;
    private EventDAO eventDAO;
    private VenueBookingDAO venueBookingDAO;
    private ResourceBookingDAO resourceBookingDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        eventDAO = new EventDAO();
        venueBookingDAO = new VenueBookingDAO();
        resourceBookingDAO = new ResourceBookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        try {
            switch (action) {
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "users":
                    showUserManagement(request, response);
                    break;
                case "addUser": 
                    showAddUserForm(request, response);
                    break;
                case "viewEvent": 
                    showEventDetails(request, response);
                    break;
                case "events":
                    showEventManagement(request, response);
                    break;
                case "profile":
                    showProfile(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
                case "systemReports":
                    showSystemReports(request, response);
                    break;
                case "downloadReport":
                    downloadReport(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String action = request.getParameter("action");

    try {
        switch (action) {
            case "createUser":
                createUser(request, response);
                break;

            case "updateProfile":
                updateProfile(request, response);
                break;

            case "approveEvent": { // Guna blok {} untuk skop pembolehubah yang jelas
                String eventId = request.getParameter("eventId");
                String adminId = (String) session.getAttribute("userID");
                eventDAO.updateEventStatus(eventId, "approved", adminId, null);
                session.setAttribute("success", "Event has been successfully approved.");
                // Redirect khusus untuk kes ini
                response.sendRedirect(request.getContextPath() + "/admin?action=events");
                break;
            }

            case "rejectEvent": { // Guna blok {} untuk skop pembolehubah yang jelas
                String eventId = request.getParameter("eventId");
                String adminId = (String) session.getAttribute("userID");
                String rejectionReason = "Rejected by administrator.";
                eventDAO.updateEventStatus(eventId, "rejected", adminId, rejectionReason);
                session.setAttribute("success", "Event has been rejected.");
                // Redirect khusus untuk kes ini
                response.sendRedirect(request.getContextPath() + "/admin?action=events");
                break;
            }

            case "updateUserStatus": {
                           String userIdToUpdate = request.getParameter("userIdToUpdate");
                           String newStatus = request.getParameter("newStatus");

                           // Panggil kaedah DAO untuk kemas kini status
                           boolean statusUpdated = userDAO.updateUserStatus(userIdToUpdate, newStatus);

                           if (statusUpdated) {
                               session.setAttribute("success", "User status for " + userIdToUpdate + " has been updated to '" + newStatus + "'.");
                           } else {
                               session.setAttribute("error", "Failed to update user status for " + userIdToUpdate + ".");
                           }

                           // Redirect kembali ke halaman senarai pengguna
                           response.sendRedirect(request.getContextPath() + "/admin?action=users");
                           break;
                       }

                       default:
                           showDashboard(request, response);
                           break;
                   }
               } catch (Exception e) {
                   e.printStackTrace();
                   request.getSession().setAttribute("error", "An unexpected error occurred: " + e.getMessage());
                   response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
               }
           }


private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String userID = (String) session.getAttribute("userID");
    User user = userDAO.getUserById(userID);
    if (user == null) {
        session.setAttribute("error", "User not found.");
        response.sendRedirect(request.getContextPath() + "/admin?action=profile");
        return;
    }

    // --- Update basic info ---
    String userName  = request.getParameter("userName");
    String userPhone = request.getParameter("userPhoneNo");
    user.setUserName(userName);
    user.setUserPhoneNo(userPhone);
    boolean infoOk = userDAO.updateUser(user);
    if (infoOk) {
        session.setAttribute("userName", userName);  // keep session in sync
        session.setAttribute("success", "Profile information updated.");
    } else {
        session.setAttribute("error", "Failed to update profile information.");
    }

    // --- Update password if provided ---
    String currentPwd = request.getParameter("currentPassword");
    String newPwd     = request.getParameter("newPassword");
    if (currentPwd != null && !currentPwd.isEmpty()
     && newPwd     != null && !newPwd.isEmpty()) {

        // Verify current password
        User authUser = userDAO.authenticateUser(user.getUserEmail(), currentPwd);
        if (authUser != null) {
            boolean pwdOk = userDAO.updatePassword(userID, newPwd);
            if (pwdOk) {
                session.setAttribute("success", "Password updated successfully.");
            } else {
                session.setAttribute("error", "Failed to update password.");
            }
        } else {
            session.setAttribute("error", "Current password is incorrect.");
        }
    }

    // Redirect back so doGet will load /admin?action=profile and show alerts
    response.sendRedirect(request.getContextPath() + "/admin?action=profile");
}

    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");

        // Fetch current admin's user object for the header
        User currentUser = userDAO.getUserById(userID);
        request.setAttribute("user", currentUser);

        // Fetch all users and calculate role-based statistics
        List<User> allUsers = userDAO.getAllUsers();
        long studentCount = allUsers.stream().filter(u -> "student".equalsIgnoreCase(u.getUserRole())).count();
        long staffCount = allUsers.stream().filter(u -> "staff".equalsIgnoreCase(u.getUserRole())).count();
        long orgCount = allUsers.stream().filter(u -> "organization".equalsIgnoreCase(u.getUserRole())).count();

        // Fetch all approved events for the main event list and count
        List<Event> allApprovedEvents = eventDAO.getAllApprovedEvents();
        
        // To get the count of pending approvals, we must check all organizations.
        // Note: A more efficient approach would be a dedicated DAO method like getEventCountByStatus("pending").
        int pendingApprovalsCount = 0;
        List<User> organizations = userDAO.getUsersByRole("organization");
        for (User org : organizations) {
            pendingApprovalsCount += eventDAO.getEventCountByOrganizationAndStatus(org.getUserID(), "pending");
        }

        // Set attributes for the JSP view
        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("totalStudents", studentCount);
        request.setAttribute("totalStaff", staffCount);
        request.setAttribute("totalOrganizations", orgCount);
        request.setAttribute("totalEvents", allApprovedEvents.size());
        request.setAttribute("pendingApprovals", pendingApprovalsCount);

        // Set a placeholder for total registrations as the DAO is not available
        request.setAttribute("totalRegistrations", 0);

        // Provide a sublist of recent events and users for the dashboard widgets
        List<Event> recentEvents = allApprovedEvents.stream().limit(5).collect(Collectors.toList());
        request.setAttribute("recentEvents", recentEvents);

        List<User> recentUsers = allUsers.stream().limit(8).collect(Collectors.toList());
        request.setAttribute("recentUsers", recentUsers);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
private void showSystemReports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Statistik Pengguna
        List<User> allUsers = userDAO.getAllUsers();
        Map<String, Long> userRoleDistribution = allUsers.stream()
                .collect(Collectors.groupingBy(User::getUserRole, Collectors.counting()));
        
        request.setAttribute("userRoleDistribution", userRoleDistribution);
        request.setAttribute("totalUsers", allUsers.size());

        // 2. Statistik Acara
        List<Event> allEvents = new ArrayList<>();
        List<User> organizations = userDAO.getUsersByRole("organization");
        for (User org : organizations) {
            allEvents.addAll(eventDAO.getEventsByOrganization(org.getUserID()));
        }
        
        Map<String, Long> eventCategoryDistribution = allEvents.stream()
                .filter(e -> e.getEventCategory() != null && !e.getEventCategory().isEmpty())
                .collect(Collectors.groupingBy(Event::getEventCategory, Collectors.counting()));

        request.setAttribute("eventCategoryDistribution", eventCategoryDistribution);
        request.setAttribute("totalEvents", allEvents.size());
        
        // 3. Data contoh untuk Statistik Tempahan
        request.setAttribute("totalVenueBookings", 58);
        request.setAttribute("totalResourceBookings", 112);

        request.getRequestDispatcher("/admin/systemReports.jsp").forward(request, response);
    }

    private void downloadReport(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment;filename=system_report.txt");
        
        PrintWriter out = response.getWriter();

        // Data Laporan
        List<User> allUsers = userDAO.getAllUsers();
        Map<String, Long> userRoleDistribution = allUsers.stream()
                .collect(Collectors.groupingBy(User::getUserRole, Collectors.counting()));
        
        // Header Laporan
        out.println("========================================");
        out.println(" LAPORAN SISTEM PENGURUSAN AKTIVITI");
        out.println("========================================");
        out.println("Laporan Dijana Pada: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")));
        out.println();
        
        // Ringkasan
        out.println("--- RINGKASAN ---");
        out.println("Jumlah Pengguna: " + allUsers.size());
        // Tambah ringkasan lain jika perlu
        
        out.println();

        // Laporan Taburan Pengguna
        out.println("--- TABURAN PENGGUNA MENGIKUT PERANAN ---");
        userRoleDistribution.forEach((role, count) -> {
            out.println(String.format("%-20s: %d", role, count));
        });

        // Anda boleh tambah data laporan lain di sini
        // seperti taburan acara, tempahan, dsb.

        out.println();
        out.println("--- TAMAT LAPORAN ---");
        
        out.flush();
        out.close();
    }
    
    private void showUserManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> staffList = userDAO.getUsersByRole("staff"); //
        List<User> orgList = userDAO.getUsersByRole("organization"); //

        List<User> userList = new ArrayList<>();
        userList.addAll(staffList);
        userList.addAll(orgList);

        request.setAttribute("users", userList);
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }


    /**
     * Fetches events for the event management page, with optional status filtering.
     */
    private void showEventManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "pending"; // Default to show pending events
        }

        List<Event> eventList = new ArrayList<>();
        List<User> organizations = userDAO.getUsersByRole("organization");
        for (User org : organizations) {
            if ("all".equalsIgnoreCase(filter)) {
                 eventList.addAll(eventDAO.getEventsByOrganization(org.getUserID()));
            } else {
                 eventList.addAll(eventDAO.getEventsByOrganizationAndStatus(org.getUserID(), filter));
            }
        }

        request.setAttribute("events", eventList);
        request.getRequestDispatcher("/admin/events.jsp").forward(request, response);
    }
    

    /**
     * Fetches the admin's own profile for the profile settings page.
     */
    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = (String) request.getSession().getAttribute("userID");
        User adminUser = userDAO.getUserById(userID);
        request.setAttribute("user", adminUser);
        request.getRequestDispatcher("/admin/profile.jsp").forward(request, response);
    }
    
    private void showAddUserForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/addUser.jsp").forward(request, response);
    }


        // Gantikan kaedah createUser sedia ada dengan yang ini
    private void createUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Dapatkan parameter dari borang (userID tidak lagi diambil)
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userPhoneNo = request.getParameter("userPhoneNo");
        String password = request.getParameter("password");
        String userRole = request.getParameter("userRole");
        String userStatus = request.getParameter("userStatus");

        // Pengesahan ringkas
        if (userName == null || userEmail == null || password == null || userRole == null ||
            userName.trim().isEmpty() || userEmail.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields.");
            showAddUserForm(request, response);
            return;
        }

        // Semak jika emel sudah wujud
        if (userDAO.emailExists(userEmail)) { //
            request.setAttribute("error", "Email '" + userEmail + "' is already registered.");
            showAddUserForm(request, response);
            return;
        }

        // **PERUBAHAN UTAMA: JANA USER ID SECARA AUTOMATIK**
        String newUserID = userDAO.generateNextUserID(userRole);
        if (newUserID == null) {
            request.setAttribute("error", "Failed to generate a new User ID for the selected role.");
            showAddUserForm(request, response);
            return;
        }

        // Cipta objek User baharu dengan ID yang dijana
        User newUser = new User(newUserID, userName, userEmail, userPhoneNo, password, userRole);
        newUser.setUserStatus(userStatus);

        // Simpan pengguna baharu ke pangkalan data
        boolean isCreated = userDAO.createUser(newUser); //

        if (isCreated) {
            request.getSession().setAttribute("success", "User '" + userName + "' (ID: " + newUserID + ") has been successfully created.");
            response.sendRedirect(request.getContextPath() + "/admin?action=users");
        } else {
            request.setAttribute("error", "Failed to create user. Please try again.");
            showAddUserForm(request, response);
        }
    }

    private void showEventDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        Event event = eventDAO.getEventById(eventId);

        if (event != null) {
            // Ambil nama organisasi untuk paparan yang lebih baik
            User organization = userDAO.getUserById(event.getOrganizationID()); 
            request.setAttribute("event", event);
            request.setAttribute("organization", organization);
            request.getRequestDispatcher("/admin/eventDetails.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "Event not found.");
            response.sendRedirect(request.getContextPath() + "/admin?action=events");
        }
    }

}
