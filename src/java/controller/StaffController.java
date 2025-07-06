package controller;

import static com.activity.util.DBConnection.getConnection;
import dao.*;
import java.io.File;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet("/staff")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1MB sebelum ditulis ke disk
    maxFileSize       = 5 * 1024 * 1024,    // max 5MB per fail
    maxRequestSize    = 6 * 1024 * 1024     // max 6MB keseluruhan
)

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
                    request.getRequestDispatcher("/staff/editVenue.jsp").forward(request, response); 
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
private void showDashboard(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Ambil senarai tempahan yang sedang menunggu dari DAO
    // Ini akan digunakan untuk paparan senarai dan juga untuk kiraan
    List<VenueBooking> pendingVenueBookings = venueBookingDAO.getBookingsByStatus("pending");
    List<ResourceBooking> pendingResourceBookings = resourceBookingDAO.getBookingsByStatus("pending");

    // 2. Kira jumlah statistik berdasarkan saiz senarai yang diambil
    int pendingApprovals = pendingVenueBookings.size() + pendingResourceBookings.size();
    int totalVenues = venueDAO.getTotalVenues();
    int totalResources = resourceDAO.getTotalResources();
    
    // 3. Hantar semua data yang diperlukan ke JSP
    //    a. Statistik untuk kad di bahagian atas
    request.setAttribute("pendingApprovals", pendingApprovals);
    request.setAttribute("totalVenues", totalVenues);
    request.setAttribute("totalResources", totalResources);
    
    //    b. Senarai penuh untuk dipaparkan dalam tab
    request.setAttribute("pendingVenueBookings", pendingVenueBookings);
    request.setAttribute("pendingResourceBookings", pendingResourceBookings);

    // 4. Hantar ke paparan dashboard
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

private void createVenue(HttpServletRequest request) throws ServletException, IOException {
    HttpSession session = request.getSession();
    try {
        // 1) read basic fields
        String name        = request.getParameter("venueName");
        String building    = request.getParameter("building");
        String floor       = request.getParameter("floor");
        String type        = request.getParameter("venueType");
        int    capacity    = Integer.parseInt(request.getParameter("capacity"));
        String description = request.getParameter("description");

        // 2) parse facilities list
        String facs = request.getParameter("facilities");
        List<String> facilities = new ArrayList<>();
        if (facs != null && !facs.trim().isEmpty()) {
            facilities = Arrays.asList(facs.trim().split("\\s*,\\s*"));
        }

        BigDecimal depositRequired = new BigDecimal(request.getParameter("price"));


        // 4) handle image upload…
        Part filePart = request.getPart("imageFile");
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName())
                                   .getFileName().toString().toLowerCase();
            if (!(fileName.endsWith(".png") ||
                  fileName.endsWith(".jpg") ||
                  fileName.endsWith(".jpeg"))) {
                session.setAttribute("error", "Only PNG/JPG images are allowed.");
                return;
            }
            String uploadsDir = getServletContext().getRealPath("")
                              + File.separator + "uploads"
                              + File.separator + "venues";
            File dir = new File(uploadsDir);
            if (!dir.exists()) dir.mkdirs();
            File dest = new File(dir, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            imageUrl = "uploads/venues/" + fileName;
        }

        // 5) build model — pass depositRequired into price slot
        Venue v = new Venue(
          name, building, floor, type,
          capacity, description, facilities,
          depositRequired,    // ← now this is your deposit
          imageUrl
        );

        // 6) persist
        if (venueDAO.createVenue(v)) {
            session.setAttribute("success", "Venue '" + name + "' added successfully.");
        } else {
            session.setAttribute("error", "Failed to add new venue.");
        }

    } catch (NumberFormatException ex) {
        session.setAttribute("error", "Invalid number format for capacity or deposit.");
        ex.printStackTrace();
    } catch (Exception ex) {
        session.setAttribute("error", "Error while adding venue: " + ex.getMessage());
        ex.printStackTrace();
    }
}




    private void updateVenue(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        int venueId = Integer.parseInt(request.getParameter("venueID"));
        String venueName = request.getParameter("venueName");
        String building = request.getParameter("building");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String facilitiesStr = request.getParameter("facilities");

        List<String> facilities = new ArrayList<>();
        if (facilitiesStr != null && !facilitiesStr.trim().isEmpty()) {
            facilities = new ArrayList<>(Arrays.asList(facilitiesStr.split(",")));
        }

        // 👇 File upload logic
        Part filePart = request.getPart("venueImage");
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadPath + File.separator + fileName);
            filePart.write(file.getAbsolutePath());

            imageUrl = "images/" + fileName;  // URL to use in <img src=...>
        } else {
            // If no new image is uploaded, keep the old one
            imageUrl = venueDAO.getVenueById(venueId).getImageUrl();
        }

        Venue venue = new Venue();
        venue.setVenueID(venueId);
        venue.setVenueName(venueName);
        venue.setBuilding(building);
        venue.setCapacity(capacity);
        venue.setFacilities(facilities);
        venue.setImageUrl(imageUrl);

        if (venueDAO.updateVenue(venue)) {
            session.setAttribute("success", "Venue #" + venueId + " updated successfully.");
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
        // 1) Ambil parameter lain
        String resourceName      = request.getParameter("resourceName");
        String category          = request.getParameter("category");
        String location          = request.getParameter("location");
        int    totalQuantity     = Integer.parseInt(request.getParameter("totalQuantity"));
        String condition         = request.getParameter("condition");
        String description       = request.getParameter("description");
        String usageInstructions = request.getParameter("usageInstructions");

        // 2) Tangani upload fail imej
        Part filePart = request.getPart("imageFile");
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName())
                                   .getFileName().toString().toLowerCase();
            if (!(fileName.endsWith(".png") || fileName.endsWith(".jpg") || fileName.endsWith(".jpeg"))) {
                session.setAttribute("error", "Hanya PNG/JPEG dibenarkan.");
                return;
            }
            String uploadsPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadsDir = new File(uploadsPath);
            if (!uploadsDir.exists()) uploadsDir.mkdirs();

            File file = new File(uploadsDir, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            imageUrl = "uploads/" + fileName;
        }

        // 3) Cipta model Resource
        // Kalau constructor memerlukan deposit, pass BigDecimal.ZERO
        Resource newResource = new Resource(
            resourceName,
            category,
            description,
            location,
            totalQuantity,
            condition,
            BigDecimal.ZERO,          // <— tiada deposit
            imageUrl,
            null,
            usageInstructions
        );

        // 4) Simpan via DAO
        if (resourceDAO.createResource(newResource)) {
            session.setAttribute("success", "Resource '" + resourceName + "' berjaya ditambah.");
        } else {
            session.setAttribute("error", "Gagal menambah resource baru.");
        }
    } catch (Exception e) {
        session.setAttribute("error", "Error adding resource: " + e.getMessage());
        e.printStackTrace();
    }
}

private void updateResource(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        int resourceId = Integer.parseInt(request.getParameter("resourceID"));
        Resource resourceToUpdate = resourceDAO.getResourceById(resourceId);

        if (resourceToUpdate != null) {
            // 1) First handle any new image upload
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName())
                                       .getFileName().toString().toLowerCase();
                // validate extension if you like…
                String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads";
                File dir = new File(uploadsDir);
                if (!dir.exists()) dir.mkdirs();
                File dest = new File(dir, fileName);
                try (InputStream in = filePart.getInputStream()) {
                    Files.copy(in, dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                resourceToUpdate.setImageUrl("uploads/" + fileName);
            }
            // 2) Then update all the other fields
            resourceToUpdate.setResourceName(request.getParameter("resourceName"));
            resourceToUpdate.setCategory   (request.getParameter("category"));
            resourceToUpdate.setLocation   (request.getParameter("location"));
            resourceToUpdate.setTotalQuantity(Integer.parseInt(request.getParameter("totalQuantity")));
            resourceToUpdate.setCondition  (request.getParameter("condition"));
            resourceToUpdate.setDepositRequired(new BigDecimal(request.getParameter("depositRequired")));
            resourceToUpdate.setDescription(request.getParameter("description"));
            resourceToUpdate.setUsageInstructions(request.getParameter("usageInstructions"));

            // 3) Persist
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
    }
}


private void deleteResource(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        int resourceId = Integer.parseInt(request.getParameter("resourceId"));

        // Panggil DAO untuk memadam
        if (resourceDAO.deleteResource(resourceId)) {
            session.setAttribute("success", "Resource #" + resourceId + " has been deleted.");
        } else {
            session.setAttribute("error", "Failed to delete resource. It might be linked to existing bookings.");
        }
    } catch (Exception e) {
        session.setAttribute("error", "Error deleting resource: " + e.getMessage());
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