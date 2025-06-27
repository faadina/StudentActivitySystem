package controller;

import dao.*;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/staff")
public class StaffController extends HttpServlet {

    private VenueDAO venueDAO;
    private ResourceDAO resourceDAO;
    private VenueBookingDAO venueBookingDAO;
    private ResourceBookingDAO resourceBookingDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        venueDAO = new VenueDAO();
        resourceDAO = new ResourceDAO();
        venueBookingDAO = new VenueBookingDAO();
        resourceBookingDAO = new ResourceBookingDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"staff".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try {
            switch (action) {
                case "dashboard": 
                    showDashboard(request, response); 
                    break;
                case "venueBookings": 
                    showVenueBookings(request, response); 
                    break;
                case "resourceBookings": 
                    showResourceBookings(request, response); 
                    break;
                case "venueManagement": 
                    showVenueManagement(request, response); 
                    break;
                case "resourceManagement": 
                    showResourceManagement(request, response); 
                    break;
                case "showAddVenueForm": 
                    request.getRequestDispatcher("/staff/addVenue.jsp").forward(request, response); 
                    break;
                case "showEditVenueForm": 
                    showEditVenueForm(request, response); 
                    break;
                case "showAddResourceForm": 
                    request.getRequestDispatcher("/staff/addResource.jsp").forward(request, response); break;
                case "showEditResourceForm": 
                    showEditResourceForm(request, response); 
                    break;
                case "profile": 
                    showProfile(request, response); 
                    break;
                default: 
                    showDashboard(request, response); 
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String staffId = (String) session.getAttribute("userID");
        String redirectPage = "staff?action=dashboard";

        try {
            switch (action) {
                case "createVenue": 
                    createVenue(request); 
                    redirectPage = "staff?action=venueManagement"; 
                break;
                case "updateVenue": updateVenue(request); 
                    redirectPage = "staff?action=venueManagement"; 
                break;
                case "deleteVenue": deleteVenue(request); 
                    redirectPage = "staff?action=venueManagement"; 
                break;
                case "createResource": createResource(request); 
                     redirectPage = "staff?action=resourceManagement"; 
                break;
                case "updateResource": updateResource(request); 
                    redirectPage = "staff?action=resourceManagement"; 
                break;
                case "deleteResource": deleteResource(request); 
                    redirectPage = "staff?action=resourceManagement"; 
                break;
                case "approveVenueBooking": updateVenueBookingStatus(request, staffId, true); 
                    redirectPage = "staff?action=venueBookings&filter=pending"; 
                break;
                case "rejectVenueBooking": updateVenueBookingStatus(request, staffId, false); 
                    redirectPage = "staff?action=venueBookings&filter=pending";
                break;
                case "approveResourceBooking": updateResourceBookingStatus(request, staffId, true); 
                    redirectPage = "staff?action=resourceBookings&filter=pending";
                break;
                case "rejectResourceBooking": updateResourceBookingStatus(request, staffId, false); 
                    redirectPage = "staff?action=resourceBookings&filter=pending"; 
                break;
                case "updateProfile": updateProfile(request, staffId); 
                    redirectPage = "staff?action=profile";
                break;
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
        }
        response.sendRedirect(redirectPage);
    }

    // --- Paparan Halaman (GET Methods) ---
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pendingApprovals", venueBookingDAO.getBookingsByStatus("pending").size() + resourceBookingDAO.getBookingsByStatus("pending").size());
        request.setAttribute("totalVenues", venueDAO.getAllVenues().size());
        request.setAttribute("totalResources", resourceDAO.getAllResources().size());
        request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
    }
    private void showVenueBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filter = request.getParameter("filter") == null ? "pending" : request.getParameter("filter");
        List<VenueBooking> bookings = "all".equalsIgnoreCase(filter) ? venueBookingDAO.getAllBookings() : venueBookingDAO.getBookingsByStatus(filter);
        request.setAttribute("bookings", bookings);
        request.setAttribute("currentFilter", filter);
        request.getRequestDispatcher("/staff/venueBookings.jsp").forward(request, response);
    }
    private void showResourceBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filter = request.getParameter("filter") == null ? "pending" : request.getParameter("filter");
        List<ResourceBooking> bookings = "all".equalsIgnoreCase(filter) ? resourceBookingDAO.getAllBookings() : resourceBookingDAO.getBookingsByStatus(filter);
        request.setAttribute("bookings", bookings);
        request.setAttribute("currentFilter", filter);
        request.getRequestDispatcher("/staff/resourceBookings.jsp").forward(request, response);
    }
    private void showVenueManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("venues", venueDAO.getAllVenues());
        request.getRequestDispatcher("/staff/venueManagement.jsp").forward(request, response);
    }
    private void showResourceManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("resources", resourceDAO.getAllResources());
        request.getRequestDispatcher("/staff/resourceManagement.jsp").forward(request, response);
    }
    private void showEditVenueForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int venueId = Integer.parseInt(request.getParameter("venueId"));
        request.setAttribute("venue", venueDAO.getVenueById(venueId));
        request.getRequestDispatcher("/staff/editVenue.jsp").forward(request, response);
    }
    private void showEditResourceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int resourceId = Integer.parseInt(request.getParameter("resourceId"));
        request.setAttribute("resource", resourceDAO.getResourceById(resourceId));
        request.getRequestDispatcher("/staff/editResource.jsp").forward(request, response);
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    String staffId = (String) request.getSession().getAttribute("userID");
    User staffUser = userDAO.getUserById(staffId);
    request.setAttribute("user", staffUser);
    request.getRequestDispatcher("/staff/profile.jsp").forward(request, response);
}

    // --- Logik Tindakan (POST Methods) ---
private void createVenue(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        // 1. Dapatkan semua parameter dari borang
        String venueName = request.getParameter("venueName");
        String building = request.getParameter("building");
        String floor = request.getParameter("floor");
        String venueType = request.getParameter("venueType");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String description = request.getParameter("description");
        String facilitiesStr = request.getParameter("facilities");
        String imageUrl = request.getParameter("imageUrl");

        // 2. Proses 'facilities' dari String kepada List
        List<String> facilities = new ArrayList<>();
        if (facilitiesStr != null && !facilitiesStr.trim().isEmpty()) {
            // Pisahkan string menggunakan koma sebagai pembatas
            facilities.addAll(Arrays.asList(facilitiesStr.split(",")));
        }

        // 3. Cipta objek Venue baharu menggunakan data dari borang
        Venue newVenue = new Venue(venueName, building, floor, venueType, capacity, description, facilities, price, imageUrl);

        // 4. Panggil DAO untuk menyimpan ke pangkalan data
        if (venueDAO.createVenue(newVenue)) {
            session.setAttribute("success", "Venue '" + venueName + "' has been successfully added.");
        } else {
            session.setAttribute("error", "Failed to add the new venue. Please check the logs.");
        }
    } catch (NumberFormatException e) {
        session.setAttribute("error", "Invalid number format for capacity or price.");
        e.printStackTrace();
    } catch (Exception e) {
        session.setAttribute("error", "An error occurred while adding the venue: " + e.getMessage());
        e.printStackTrace();
    }
}

    private void updateVenue(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            // 1. Ambil semua data dari borang, termasuk ID
            int venueId = Integer.parseInt(request.getParameter("venueID"));
            String venueName = request.getParameter("venueName");
            String building = request.getParameter("building");
            String floor = request.getParameter("floor");
            String venueType = request.getParameter("venueType");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String description = request.getParameter("description");
            String facilitiesStr = request.getParameter("facilities");
            String imageUrl = request.getParameter("imageUrl");
            String availability = request.getParameter("availability");

            // 2. Proses 'facilities' dari String kepada List
            List<String> facilities = new ArrayList<>();
            if (facilitiesStr != null && !facilitiesStr.trim().isEmpty()) {
                facilities = new ArrayList<>(Arrays.asList(facilitiesStr.split(",")));
            }

            // 3. Cipta objek Venue dengan maklumat baharu
            Venue venueToUpdate = new Venue();
            venueToUpdate.setVenueID(venueId);
            venueToUpdate.setVenueName(venueName);
            venueToUpdate.setBuilding(building);
            venueToUpdate.setFloor(floor);
            venueToUpdate.setVenueType(venueType);
            venueToUpdate.setCapacity(capacity);
            venueToUpdate.setDescription(description);
            venueToUpdate.setFacilities(facilities);
            venueToUpdate.setPrice(price);
            venueToUpdate.setImageUrl(imageUrl);
            venueToUpdate.setAvailability(availability);

            // 4. Panggil DAO untuk kemas kini pangkalan data
            if (venueDAO.updateVenue(venueToUpdate)) {
                session.setAttribute("success", "Venue #" + venueId + " has been updated successfully.");
            } else {
                session.setAttribute("error", "Failed to update venue #" + venueId + ".");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error updating venue: " + e.getMessage());
            e.printStackTrace();
        }
    }

private void deleteVenue(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        // 1. Dapatkan 'venueId' dari borang
        int venueId = Integer.parseInt(request.getParameter("venueId"));

        // 2. Panggil DAO untuk memadam
        if (venueDAO.deleteVenue(venueId)) {
            // 3. Jika berjaya, tetapkan mesej kejayaan
            session.setAttribute("success", "Venue #" + venueId + " has been successfully deleted.");
        } else {
            // 4. Jika gagal, tetapkan mesej ralat (kemungkinan ada tempahan aktif)
            session.setAttribute("error", "Failed to delete venue #" + venueId + ". It might be linked to existing bookings.");
        }
    } catch (Exception e) {
        session.setAttribute("error", "Error deleting venue: " + e.getMessage());
        e.printStackTrace();
    }
}

private void createResource(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        // 1. Dapatkan semua data dari borang 'addResource.jsp'
        String resourceName = request.getParameter("resourceName");
        String category = request.getParameter("category");
        String location = request.getParameter("location");
        int totalQuantity = Integer.parseInt(request.getParameter("totalQuantity"));
        String condition = request.getParameter("condition");
        BigDecimal depositRequired = new BigDecimal(request.getParameter("depositRequired"));
        String description = request.getParameter("description");
        String usageInstructions = request.getParameter("usageInstructions");
        String imageUrl = request.getParameter("imageUrl");

        // 2. Cipta objek Resource baharu.
        // Spesifikasi (Map) dibiarkan null buat masa ini kerana borang ringkas.
        Resource newResource = new Resource(resourceName, category, description, location, 
                                            totalQuantity, condition, depositRequired, 
                                            imageUrl, null, usageInstructions);

        // 3. Panggil DAO untuk menyimpan
        if (resourceDAO.createResource(newResource)) {
            session.setAttribute("success", "Resource '" + resourceName + "' has been successfully added.");
        } else {
            session.setAttribute("error", "Failed to add the new resource.");
        }
    } catch (NumberFormatException e) {
        session.setAttribute("error", "Invalid number format for quantity or deposit.");
        e.printStackTrace();
    } catch (Exception e) {
        session.setAttribute("error", "An error occurred while adding the resource: " + e.getMessage());
        e.printStackTrace();
    }
}
    
    private void updateResource(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        // 1. Ambil ID dan semua data lain dari borang
        int resourceId = Integer.parseInt(request.getParameter("resourceID"));
        String resourceName = request.getParameter("resourceName");
        String category = request.getParameter("category");
        String location = request.getParameter("location");
        int totalQuantity = Integer.parseInt(request.getParameter("totalQuantity"));
        String condition = request.getParameter("condition");
        BigDecimal depositRequired = new BigDecimal(request.getParameter("depositRequired"));
        String description = request.getParameter("description");
        String usageInstructions = request.getParameter("usageInstructions");
        String imageUrl = request.getParameter("imageUrl");

        // 2. Dapatkan objek Resource sedia ada untuk dikemas kini
        Resource resourceToUpdate = resourceDAO.getResourceById(resourceId);
        
        if (resourceToUpdate != null) {
            // 3. Kemas kini setiap medan objek dengan data baharu
            resourceToUpdate.setResourceName(resourceName);
            resourceToUpdate.setCategory(category);
            resourceToUpdate.setLocation(location);
            resourceToUpdate.setTotalQuantity(totalQuantity);
            // Nota: Logik untuk 'availableQuantity' mungkin perlu dikemas kini secara berasingan
            resourceToUpdate.setCondition(condition);
            resourceToUpdate.setDepositRequired(depositRequired);
            resourceToUpdate.setDescription(description);
            resourceToUpdate.setUsageInstructions(usageInstructions);
            resourceToUpdate.setImageUrl(imageUrl);
            
            // 4. Panggil DAO untuk menyimpan perubahan
            //    (Ini menganggap kaedah updateResource(resource) wujud dalam ResourceDAO)
            if (resourceDAO.updateResource(resourceToUpdate)) {
                session.setAttribute("success", "Resource #" + resourceId + " has been updated.");
            } else {
                session.setAttribute("error", "Failed to update resource.");
            }
        } else {
            session.setAttribute("error", "Resource not found for update.");
        }
    } catch (Exception e) {
        session.setAttribute("error", "Error updating resource: " + e.getMessage());
        e.printStackTrace();
    }
}


private void deleteResource(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        // 1. Dapatkan 'resourceId' dari borang
        int resourceId = Integer.parseInt(request.getParameter("resourceId"));

        // 2. Panggil DAO untuk memadam
        //    (Ini menganggap kaedah deleteResource(id) wujud dalam ResourceDAO)
        if (resourceDAO.deleteResource(resourceId)) {
            session.setAttribute("success", "Resource #" + resourceId + " has been deleted.");
        } else {
            session.setAttribute("error", "Failed to delete resource. It might be linked to existing bookings.");
        }
    } catch (Exception e) {
        session.setAttribute("error", "Error deleting resource: " + e.getMessage());
        e.printStackTrace();
    }
}

    
    private void updateVenueBookingStatus(HttpServletRequest request, String staffId, boolean isApproved) {
        HttpSession session = request.getSession();
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String reason = isApproved ? "Approved" : request.getParameter("reason");
        String status = isApproved ? "confirmed" : "rejected";
        if (venueBookingDAO.updateBookingStatus(bookingId, status, staffId, reason)) {
            session.setAttribute("success", "Booking #" + bookingId + " has been " + status + ".");
        } else {
            session.setAttribute("error", "Failed to update booking status.");
        }
    }
    
    private void updateResourceBookingStatus(HttpServletRequest request, String staffId, boolean isApproved) {
        HttpSession session = request.getSession();
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String reason = isApproved ? "Approved" : request.getParameter("reason");
        String status = isApproved ? "confirmed" : "rejected";
        if (resourceBookingDAO.updateBookingStatus(bookingId, status, staffId, reason)) {
            session.setAttribute("success", "Booking #" + bookingId + " has been " + status + ".");
        } else {
            session.setAttribute("error", "Failed to update booking status.");
        }
    }
    
  private void updateProfile(HttpServletRequest request, String staffId) {
    HttpSession session = request.getSession();
    User user = userDAO.getUserById(staffId);

    if (user != null) {
        // Kemas kini maklumat asas
        user.setUserName(request.getParameter("userName"));
        user.setUserPhoneNo(request.getParameter("userPhoneNo"));
        if (userDAO.updateUser(user)) {
            session.setAttribute("userName", user.getUserName()); // Kemas kini nama dalam sesi
            session.setAttribute("success", "Profile updated successfully.");
        } else {
            session.setAttribute("error", "Failed to update profile details.");
        }

        // Semak jika ada permintaan untuk tukar kata laluan
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        if (currentPassword != null && !currentPassword.isEmpty() && newPassword != null && !newPassword.isEmpty()) {
            // Sahkan kata laluan semasa
            if (userDAO.authenticateUser(user.getUserEmail(), currentPassword) != null) {
                // Jika betul, kemas kini kepada kata laluan baharu
                if (userDAO.updatePassword(staffId, newPassword)) {
                    session.setAttribute("success", "Profile and password updated successfully.");
                } else {
                    session.setAttribute("error", "Failed to update password.");
                }
            } else {
                // Jika kata laluan semasa salah
                session.setAttribute("error", "Incorrect current password. Profile details were saved, but password was not changed.");
            }
        }
    } else {
        session.setAttribute("error", "Could not find user profile to update.");
    }
}
}