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
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

@WebServlet("/organization")
public class OrganizationController extends HttpServlet {
    
    private UserDAO userDAO;
    private EventDAO eventDAO;
    private VenueDAO venueDAO;
    private ResourceDAO resourceDAO;
    private VenueBookingDAO venueBookingDAO;
    private ResourceBookingDAO resourceBookingDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        eventDAO = new EventDAO();
        venueDAO = new VenueDAO();
        resourceDAO = new ResourceDAO();
        venueBookingDAO = new VenueBookingDAO();
        resourceBookingDAO = new ResourceBookingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an organization
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null || 
            !"organization".equals(session.getAttribute("userRole"))) {
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
                case "events":
                    showEvents(request, response);
                    break;
                case "createEvent":
                    showCreateEvent(request, response);
                    break;
                case "editEvent":
                    showEditEvent(request, response);
                    break;
                case "viewEvent":
                    showEventDetails(request, response);
                    break;
                case "exportEvent":
                    exportEventDetails(request, response);
                    break;
                case "venues":
                    showVenues(request, response);
                    break;
                case "resources":
                    showResources(request, response);
                    break;
                case "reports":
                    showReports(request, response);
                    break;
                case "profile":
                    showProfile(request, response);
                    break;
                case "getVenueDetails":
                    getVenueDetails(request, response);
                    break;
                case "venueSchedule":
                    showVenueSchedule(request, response);
                    break;
                case "viewBooking":
                    showVenueBookingDetails(request, response);
                    break;
                case "getResourceDetails":
                    getResourceDetails(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/org/dashboard.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an organization
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null || 
            !"organization".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "createEvent":
                    createEvent(request, response);
                    break;
                case "updateEvent":
                    updateEvent(request, response);
                    break;
                case "bookVenue":
                    bookVenue(request, response);
                    break;
                case "bookResource":
                    bookResource(request, response);
                    break;
                case "updateProfile":
                    updateProfile(request, response);
                    break;
                case "cancelBooking":
                    cancelBooking(request, response);
                    break;
                case "markResourceReturned":
                    markResourceReturned(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            showDashboard(request, response);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        // Get dashboard statistics
        int totalEvents = eventDAO.getEventCountByOrganization(userID);
        int activeEvents = eventDAO.getEventCountByOrganizationAndStatus(userID, "approved");
        int pendingEvents = eventDAO.getEventCountByOrganizationAndStatus(userID, "pending");
        int totalParticipants = eventDAO.getTotalParticipantsByOrganization(userID);
        
        // Get recent events
        List<Event> myEvents = eventDAO.getEventsByOrganization(userID);
        if (myEvents.size() > 5) {
            myEvents = myEvents.subList(0, 5);
        }
        
        // Sample notifications
        List<String> notifications = new ArrayList<>();
        notifications.add("Your event 'Tech Workshop' has been approved.");
        notifications.add("New venue booking request received.");
        notifications.add("Resource booking deadline approaching.");
        
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("activeEvents", activeEvents);
        request.setAttribute("pendingEvents", pendingEvents);
        request.setAttribute("totalParticipants", totalParticipants);
        request.setAttribute("myEvents", myEvents);
        request.setAttribute("notifications", notifications);
        
        request.getRequestDispatcher("/org/dashboard.jsp").forward(request, response);
    }
    
    private void showEvents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
            String userID = (String) request.getSession().getAttribute("userID");
            String filter = request.getParameter("filter");

            List<Event> events;
            if (filter != null && !filter.isEmpty() && !filter.equals("all")) {
                switch (filter) {
                    case "approved":
                        events = eventDAO.getEventsByOrganizationAndStatus(userID, "approved");
                        break;
                    case "pending":
                        events = eventDAO.getEventsByOrganizationAndStatus(userID, "pending");
                        break;
                    case "upcoming":
                        events = eventDAO.getUpcomingEventsByOrganization(userID);
                        break;
                    case "past":
                        events = eventDAO.getPastEventsByOrganization(userID);
                        break;
                    default:
                        events = eventDAO.getEventsByOrganization(userID);
                        break;
                }
            } else {
                events = eventDAO.getEventsByOrganization(userID);
            }

            // Get statistics
            int totalEvents = eventDAO.getEventCountByOrganization(userID);
            int approvedEvents = eventDAO.getEventCountByOrganizationAndStatus(userID, "approved");
            int pendingEvents = eventDAO.getEventCountByOrganizationAndStatus(userID, "pending");
            int upcomingEvents = eventDAO.getUpcomingEventsByOrganization(userID).size();

            request.setAttribute("events", events);
            request.setAttribute("totalEvents", totalEvents);
            request.setAttribute("approvedEvents", approvedEvents);
            request.setAttribute("pendingEvents", pendingEvents);
            request.setAttribute("upcomingEvents", upcomingEvents);
            request.setAttribute("currentPage", "events");

            request.getRequestDispatcher("/org/events.jsp").forward(request, response);
        }

        private void showCreateEvent(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException {
            request.getRequestDispatcher("/org/createEvent.jsp").forward(request, response);
        }

        private void showVenueBookingDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("bookingId");

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            VenueBooking booking = venueBookingDAO.getVenueBookingById(bookingId);

            // --- TAMBAH PEMERIKSAAN INI ---
            if (booking != null) {
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/org/venueBookingDetails.jsp").forward(request, response);
            } else {
                // Jika tempahan tidak dijumpai, hantar mesej ralat
                request.setAttribute("error", "Booking with ID " + bookingId + " not found.");
                showVenues(request, response); // Kembali ke laman senarai dewan
            }
            // -----------------------------

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Booking ID format.");
            showVenues(request, response);
        }
    }
    
    private void createEvent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        try {
            // Parse form data
            String eventTitle = request.getParameter("eventTitle");
            String eventDescription = request.getParameter("eventDescription");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");
            String eventLocation = request.getParameter("eventLocation");
            String eventCategory = request.getParameter("eventCategory");
            String participantLimitStr = request.getParameter("participantLimit");
            String registrationDeadlineStr = request.getParameter("registrationDeadline");
            String registrationFeeStr = request.getParameter("registrationFee");
            String requirements = request.getParameter("requirements");
            String specialInstructions = request.getParameter("specialInstructions");
            String contactPerson = request.getParameter("contactPerson");
            String contactEmail = request.getParameter("contactEmail");
            String contactPhone = request.getParameter("contactPhone");
            
            // Validate required fields
            if (eventTitle == null || eventTitle.trim().isEmpty() ||
                eventDateStr == null || eventTimeStr == null ||
                eventLocation == null || eventLocation.trim().isEmpty() ||
                eventCategory == null || eventCategory.trim().isEmpty()) {
                
                request.setAttribute("error", "Please fill in all required fields.");
                request.getRequestDispatcher("/org/createEvent.jsp").forward(request, response);
                return;
            }
            
            // Parse dates and times
            Date eventDate = Date.valueOf(eventDateStr);
            Time eventTime = Time.valueOf(eventTimeStr + ":00");
            Date registrationDeadline = registrationDeadlineStr != null && !registrationDeadlineStr.isEmpty() 
                                      ? Date.valueOf(registrationDeadlineStr) : null;
            
            // Parse numbers
            int participantLimit = participantLimitStr != null && !participantLimitStr.isEmpty() 
                                 ? Integer.parseInt(participantLimitStr) : 0;
            BigDecimal registrationFee = registrationFeeStr != null && !registrationFeeStr.isEmpty() 
                                       ? new BigDecimal(registrationFeeStr) : BigDecimal.ZERO;
            
            // Generate event ID
            String eventID = eventDAO.generateNextEventID();
            
            // Create event object
            Event event = new Event(eventID, userID, eventTitle, eventDescription, eventDate, eventTime,
                                  eventLocation, eventCategory, participantLimit, registrationDeadline,
                                  registrationFee, requirements, specialInstructions, contactPerson,
                                  contactEmail, contactPhone);
            
            // Save event
            if (eventDAO.createEvent(event)) {
                request.setAttribute("success", "Event created successfully and submitted for approval.");
                response.sendRedirect(request.getContextPath() + "/organization?action=events");
                return;
            } else {
                request.setAttribute("error", "Failed to create event. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating the event: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/org/createEvent.jsp").forward(request, response);
    }
    
    private void exportEventDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String eventId = request.getParameter("id");
        String userID = (String) request.getSession().getAttribute("userID");

        Event event = eventDAO.getEventById(eventId);

        // Semak keselamatan: pastikan acara wujud dan dimiliki oleh pengguna
        if (event != null && event.getOrganizationID().equals(userID)) {

            // Tetapkan jenis kandungan sebagai teks biasa
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            // Tetapkan header untuk memuat turun fail dengan nama tertentu
            response.setHeader("Content-Disposition", "attachment; filename=\"event_details_" + event.getEventID() + ".txt\"");

            try (java.io.PrintWriter writer = response.getWriter()) {
                writer.println("=======================================");
                writer.println("         EVENT DETAILS");
                writer.println("=======================================");
                writer.println("Event ID: " + event.getEventID());
                writer.println("Event Title: " + event.getEventTitle());
                writer.println("Organization ID: " + event.getOrganizationID());
                writer.println("---------------------------------------");
                writer.println("Date: " + event.getEventDate());
                writer.println("Time: " + event.getEventTime());
                writer.println("Location: " + event.getEventLocation());
                writer.println("Category: " + event.getEventCategory());
                writer.println("---------------------------------------");
                writer.println("Description: " + event.getEventDescription());
                writer.println("---------------------------------------");
                writer.println("Participant Limit: " + event.getParticipantLimit());
                writer.println("Registered Count: " + event.getRegisteredCount());
                writer.println("Registration Fee: RM " + event.getRegistrationFee());
                writer.println("Registration Deadline: " + event.getRegistrationDeadline());
                writer.println("---------------------------------------");
                writer.println("Contact Person: " + event.getContactPerson());
                writer.println("Contact Email: " + event.getContactEmail());
                writer.println("Contact Phone: " + event.getContactPhone());
                writer.println("=======================================");
            }

        } else {
            // Jika acara tidak dijumpai atau akses ditolak
            response.sendRedirect(request.getContextPath() + "/organization?action=events&error=ExportFailed");
        }
    }
    
    private void showVenues(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        // Get filter parameters
        String date = request.getParameter("date");
        String capacityStr = request.getParameter("capacity");
        String building = request.getParameter("building");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        
        Integer minCapacity = null;
        if (capacityStr != null && !capacityStr.isEmpty()) {
            minCapacity = Integer.parseInt(capacityStr);
        }
        
        // Get venues with filters
        List<Venue> venues = venueDAO.getVenuesWithFilters(minCapacity, building, type, status);
        
        // Get statistics
        int totalVenues = venueDAO.getTotalVenues();
        int availableVenues = venueDAO.getAvailableVenuesCount();
        int myBookings = venueBookingDAO.getBookingCountByUser(userID);
        int upcomingBookings = venueBookingDAO.getUpcomingBookingCountByUser(userID);
        
        // Get filter options
        List<String> buildings = venueDAO.getAllBuildings();
        List<Venue> availableVenuesList = venueDAO.getAvailableVenues();
        List<VenueBooking> bookingHistory = venueBookingDAO.getBookingsByUser(userID);
        
        request.setAttribute("venues", venues);
        request.setAttribute("totalVenues", totalVenues);
        request.setAttribute("availableVenues", availableVenues);
        request.setAttribute("myBookings", myBookings);
        request.setAttribute("upcomingBookings", upcomingBookings);
        request.setAttribute("buildings", buildings);
        request.setAttribute("availableVenuesList", availableVenuesList);
        request.setAttribute("bookingHistory", bookingHistory);
        request.setAttribute("currentDate", new Date(System.currentTimeMillis()));
        
        request.getRequestDispatcher("/org/venues.jsp").forward(request, response);
    }
    
    private void showVenueSchedule(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            int venueId = Integer.parseInt(request.getParameter("venueId"));
            Venue venue = venueDAO.getVenueById(venueId);
            List<VenueBooking> bookings = venueBookingDAO.getBookingsByVenue(venueId);

            request.setAttribute("venue", venue);
            request.setAttribute("bookings", bookings);

            request.getRequestDispatcher("/org/venueSchedule.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not retrieve schedule for the venue.");
            showVenues(request, response);
        }
    }
    
    private void showResources(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        // Get filter parameters
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        String availability = request.getParameter("availability");
        String location = request.getParameter("location");
        String sort = request.getParameter("sort");
        
        // Get resources
        List<Resource> resources;
        if (search != null && !search.trim().isEmpty()) {
            resources = resourceDAO.searchResources(search.trim());
        } else {
            resources = resourceDAO.getResourcesWithFilters(category, availability, location, sort);
        }
        
        // Get statistics
        int totalResources = resourceDAO.getTotalResources();
        int availableResources = resourceDAO.getAvailableResourcesCount();
        int myBookings = resourceBookingDAO.getBookingCountByUser(userID);
        int overdueItems = resourceBookingDAO.getOverdueBookingCount();
        
        // Get category counts
        int audioVisualCount = resourceDAO.getResourceCountByCategory("audio-visual");
        int furnitureCount = resourceDAO.getResourceCountByCategory("furniture");
        int sportsCount = resourceDAO.getResourceCountByCategory("sports");
        int technologyCount = resourceDAO.getResourceCountByCategory("technology");
        int decorationsCount = resourceDAO.getResourceCountByCategory("decorations");
        
        // Get filter options
        List<String> locations = resourceDAO.getAllLocations();
        List<Resource> availableResourcesList = resourceDAO.getAvailableResources();
        List<ResourceBooking> resourceBookings = resourceBookingDAO.getBookingsByUser(userID);
        
        request.setAttribute("resources", resources);
        request.setAttribute("totalResources", totalResources);
        request.setAttribute("availableResources", availableResources);
        request.setAttribute("myBookings", myBookings);
        request.setAttribute("overdueItems", overdueItems);
        request.setAttribute("audioVisualCount", audioVisualCount);
        request.setAttribute("furnitureCount", furnitureCount);
        request.setAttribute("sportsCount", sportsCount);
        request.setAttribute("technologyCount", technologyCount);
        request.setAttribute("decorationsCount", decorationsCount);
        request.setAttribute("locations", locations);
        request.setAttribute("availableResourcesList", availableResourcesList);
        request.setAttribute("resourceBookings", resourceBookings);
        request.setAttribute("currentDate", new Date(System.currentTimeMillis()));
        
        request.getRequestDispatcher("/org/resources.jsp").forward(request, response);
    }
    
private void showReports(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String userID = (String) request.getSession().getAttribute("userID");

    // 1. Data untuk Kad Statistik
    request.setAttribute("totalEvents", eventDAO.getEventCountByOrganization(userID));
    request.setAttribute("totalParticipants", eventDAO.getTotalParticipantsByOrganization(userID));
    request.setAttribute("venueBookings", venueBookingDAO.getBookingCountByUser(userID));
    request.setAttribute("resourceBookings", resourceBookingDAO.getBookingCountByUser(userID));

    // 2. Data untuk Carta Garis (Acara Mengikut Bulan)
    Map<String, Integer> monthlyEventMap = eventDAO.getMonthlyEventCounts(userID);
    request.setAttribute("monthlyEventLabels", convertListToStringJson(new ArrayList<>(monthlyEventMap.keySet())));
    request.setAttribute("monthlyEventData", convertListToIntegerJson(new ArrayList<>(monthlyEventMap.values())));

    // 3. Data untuk Carta Pai (Acara Mengikut Kategori)
    Map<String, Integer> categoryDataMap = eventDAO.getEventCountByCategory(userID);
    request.setAttribute("categoryLabels", convertListToStringJson(new ArrayList<>(categoryDataMap.keySet())));
    request.setAttribute("categoryData", convertListToIntegerJson(new ArrayList<>(categoryDataMap.values())));

    // 4. Data untuk Carta Bar (Tempahan Dewan Popular)
    Map<String, Integer> venueBookingMap = venueBookingDAO.getVenueBookingCounts();
    request.setAttribute("topVenueLabels", convertListToStringJson(new ArrayList<>(venueBookingMap.keySet())));
    request.setAttribute("topVenueData", convertListToIntegerJson(new ArrayList<>(venueBookingMap.values())));

    request.getRequestDispatcher("/org/reports.jsp").forward(request, response);
}
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        User user = userDAO.getUserById(userID);
        
        if (user != null) {
            request.setAttribute("user", user);
            
            // Get some activity statistics
            int totalEvents = eventDAO.getEventCountByOrganization(userID);
            int certificatesEarned = 0; // Organizations don't earn certificates, but we'll keep for consistency
            
            request.setAttribute("totalEvents", totalEvents);
            request.setAttribute("certificatesEarned", certificatesEarned);
        }
        
        request.getRequestDispatcher("/org/profile.jsp").forward(request, response);
    }
private String escapeJson(String str) {
    if (str == null) return "";
    return str.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
}

private String convertListToStringJson(List<String> list) {
    if (list == null || list.isEmpty()) return "[]";
    StringBuilder json = new StringBuilder("[");
    for (int i = 0; i < list.size(); i++) {
        json.append("\"").append(escapeJson(list.get(i))).append("\"");
        if (i < list.size() - 1) json.append(",");
    }
    json.append("]");
    return json.toString();
}

private String convertListToIntegerJson(List<Integer> list) {
    if (list == null || list.isEmpty()) return "[]";
    StringBuilder json = new StringBuilder("[");
    for (int i = 0; i < list.size(); i++) {
        json.append(list.get(i));
        if (i < list.size() - 1) json.append(",");
    }
    json.append("]");
    return json.toString();
}
    private void getVenueDetails(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int venueId = Integer.parseInt(request.getParameter("venueId"));
            Venue venue = venueDAO.getVenueById(venueId);

            if (venue != null) {
                // Menggunakan pendekatan yang lebih selamat untuk membina JSON
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"venueID\":").append(venue.getVenueID()).append(",");
                json.append("\"venueName\":\"").append(escapeJson(venue.getVenueName())).append("\",");
                json.append("\"building\":\"").append(escapeJson(venue.getBuilding())).append("\",");
                json.append("\"floor\":\"").append(escapeJson(venue.getFloor())).append("\",");
                json.append("\"venueType\":\"").append(escapeJson(venue.getVenueType())).append("\",");
                json.append("\"capacity\":").append(venue.getCapacity()).append(",");
                json.append("\"price\":").append(venue.getPrice()).append(",");
                json.append("\"description\":\"").append(escapeJson(venue.getDescription())).append("\",");

                // Membina array JSON untuk facilities
                json.append("\"facilities\":[");
                if (venue.getFacilities() != null && !venue.getFacilities().isEmpty()) {
                    for (int i = 0; i < venue.getFacilities().size(); i++) {
                        json.append("\"").append(escapeJson(venue.getFacilities().get(i))).append("\"");
                        if (i < venue.getFacilities().size() - 1) {
                            json.append(",");
                        }
                    }
                }
                json.append("],");

                json.append("\"imageUrl\":\"").append(escapeJson(venue.getImageUrl())).append("\"");
                json.append("}");

                response.getWriter().write(json.toString());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Venue not found.");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving venue details.");
            e.printStackTrace();
        }
    }
    
    private void getResourceDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String resourceIdStr = request.getParameter("resourceId");
        if (resourceIdStr != null) {
            try {
                int resourceId = Integer.parseInt(resourceIdStr);
                Resource resource = resourceDAO.getResourceById(resourceId);
                
                if (resource != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    
                    // Create simple JSON response
                    StringBuilder json = new StringBuilder();
                    json.append("{")
                        .append("\"resourceId\":").append(resource.getResourceID()).append(",")
                        .append("\"resourceName\":\"").append(resource.getResourceName()).append("\",")
                        .append("\"category\":\"").append(resource.getCategory()).append("\",")
                        .append("\"description\":\"").append(resource.getDescription() != null ? resource.getDescription() : "").append("\",")
                        .append("\"location\":\"").append(resource.getLocation()).append("\",")
                        .append("\"totalQuantity\":").append(resource.getTotalQuantity()).append(",")
                        .append("\"availableQuantity\":").append(resource.getAvailableQuantity()).append(",")
                        .append("\"condition\":\"").append(resource.getCondition()).append("\",")
                        .append("\"depositRequired\":").append(resource.getDepositRequired()).append(",")
                        .append("\"imageUrl\":\"").append(resource.getImageUrl() != null ? resource.getImageUrl() : "").append("\",")
                        .append("\"usageInstructions\":\"").append(resource.getUsageInstructions() != null ? resource.getUsageInstructions() : "").append("\"")
                        .append("}");
                    
                    response.getWriter().write(json.toString());
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid resource ID
            }
        }
        
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
    
    private void bookVenue(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        try {
            String venueIdStr = request.getParameter("venueId");
            String eventType = request.getParameter("eventType");
            String bookingDateStr = request.getParameter("bookingDate");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            String purpose = request.getParameter("purpose");
            String expectedAttendeesStr = request.getParameter("expectedAttendees");
            String[] facilitiesRequired = request.getParameterValues("facilities");
            
            // Validate required fields
            if (venueIdStr == null || eventType == null || bookingDateStr == null || 
                startTimeStr == null || endTimeStr == null || purpose == null) {
                request.setAttribute("error", "Please fill in all required fields.");
                showVenues(request, response);
                return;
            }
            
            // Parse parameters
            int venueId = Integer.parseInt(venueIdStr);
            Date bookingDate = Date.valueOf(bookingDateStr);
            Time startTime = Time.valueOf(startTimeStr + ":00");
            Time endTime = Time.valueOf(endTimeStr + ":00");
            int expectedAttendees = expectedAttendeesStr != null && !expectedAttendeesStr.isEmpty() 
                                  ? Integer.parseInt(expectedAttendeesStr) : 0;
            
            // Create facilities list
            List<String> facilitiesList = new ArrayList<>();
            if (facilitiesRequired != null) {
                for (String facility : facilitiesRequired) {
                    facilitiesList.add(facility);
                }
            }
            
            // Check venue availability
            if (!venueDAO.isVenueAvailable(venueId, bookingDate, startTime, endTime)) {
                request.setAttribute("error", "Venue is not available for the selected date and time.");
                showVenues(request, response);
                return;
            }
            
            // Get venue details for pricing
            Venue venue = venueDAO.getVenueById(venueId);
            if (venue == null) {
                request.setAttribute("error", "Venue not found.");
                showVenues(request, response);
                return;
            }
            
            // Calculate total amount (price per hour * duration)
            long durationInHours = calculateDurationInHours(startTime, endTime);
            BigDecimal totalAmount = venue.getPrice().multiply(BigDecimal.valueOf(durationInHours));
            
            // Create booking
            VenueBooking booking = new VenueBooking(venueId, userID, eventType, bookingDate,
                                                   startTime, endTime, purpose, expectedAttendees,
                                                   facilitiesList, totalAmount);
            
            if (venueBookingDAO.createVenueBooking(booking)) {
                request.setAttribute("success", "Venue booking request submitted successfully.");
            } else {
                request.setAttribute("error", "Failed to create venue booking.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your booking: " + e.getMessage());
        }
        
        showVenues(request, response);
    }
    
    private void bookResource(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        
        try {
            String[] resourceIds = request.getParameterValues("resourceIds");
            String eventName = request.getParameter("eventName");
            String eventLocation = request.getParameter("eventLocation");
            String borrowDateStr = request.getParameter("borrowDate");
            String returnDateStr = request.getParameter("returnDate");
            String purpose = request.getParameter("purpose");
            String contactPerson = request.getParameter("contactPerson");
            String contactPhone = request.getParameter("contactPhone");
            
            // Validate required fields
            if (resourceIds == null || eventName == null || eventLocation == null || 
                borrowDateStr == null || returnDateStr == null || purpose == null) {
                request.setAttribute("error", "Please fill in all required fields and select at least one resource.");
                showResources(request, response);
                return;
            }
            
            // Parse dates
            Date borrowDate = Date.valueOf(borrowDateStr);
            Date returnDate = Date.valueOf(returnDateStr);
            
            // Validate dates
            if (!returnDate.after(borrowDate)) {
                request.setAttribute("error", "Return date must be after borrow date.");
                showResources(request, response);
                return;
            }
            
            boolean allBookingsSuccessful = true;
            BigDecimal totalDeposit = BigDecimal.ZERO;
            
            // Create booking for each selected resource
            for (String resourceIdStr : resourceIds) {
                try {
                    int resourceId = Integer.parseInt(resourceIdStr);
                    Resource resource = resourceDAO.getResourceById(resourceId);
                    
                    if (resource == null || !resource.isAvailable()) {
                        continue;
                    }
                    
                    // Check if resource has available quantity
                    if (!resourceDAO.hasAvailableQuantity(resourceId, 1)) {
                        request.setAttribute("error", "Resource " + resource.getResourceName() + " is not available.");
                        allBookingsSuccessful = false;
                        continue;
                    }
                    
                    // Calculate deposit
                    BigDecimal depositAmount = resource.getDepositRequired() != null 
                                             ? resource.getDepositRequired() : BigDecimal.ZERO;
                    totalDeposit = totalDeposit.add(depositAmount);
                    
                    // Create booking
                    ResourceBooking booking = new ResourceBooking(resourceId, userID, eventName, eventLocation,
                                                                borrowDate, returnDate, 1, purpose,
                                                                contactPerson, contactPhone, depositAmount);
                    
                    if (!resourceBookingDAO.createResourceBooking(booking)) {
                        allBookingsSuccessful = false;
                    }
                    
                } catch (NumberFormatException e) {
                    allBookingsSuccessful = false;
                }
            }
            
            if (allBookingsSuccessful) {
                request.setAttribute("success", "Resource booking requests submitted successfully. Total deposit required: RM " + totalDeposit);
            } else {
                request.setAttribute("error", "Some resource bookings failed. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your booking: " + e.getMessage());
        }
        
        showResources(request, response);
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookingIdStr = request.getParameter("bookingId");
        String bookingType = request.getParameter("type"); // "venue" or "resource"
        
        if (bookingIdStr != null && bookingType != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = false;
                
                if ("venue".equals(bookingType)) {
                    success = venueBookingDAO.cancelBooking(bookingId);
                } else if ("resource".equals(bookingType)) {
                    success = resourceBookingDAO.cancelBooking(bookingId);
                }
                
                if (success) {
                    response.getWriter().write("{\"success\": true, \"message\": \"Booking cancelled successfully.\"}");
                } else {
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to cancel booking.\"}");
                }
                
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid booking ID.\"}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Missing required parameters.\"}");
        }
        
        response.setContentType("application/json");
    }
    
    private void markResourceReturned(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookingIdStr = request.getParameter("bookingId");
        String condition = request.getParameter("condition");
        
        if (bookingIdStr != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                if (condition == null || condition.isEmpty()) {
                    condition = "good";
                }
                
                boolean success = resourceBookingDAO.markAsReturned(bookingId, condition);
                
                if (success) {
                    response.getWriter().write("{\"success\": true, \"message\": \"Resource marked as returned successfully.\"}");
                } else {
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to mark resource as returned.\"}");
                }
                
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid booking ID.\"}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Missing booking ID.\"}");
        }
        
        response.setContentType("application/json");
    }
    
    private void deleteEvent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String eventId = request.getParameter("id");
        String userID = (String) request.getSession().getAttribute("userID");
        
        if (eventId != null) {
            // Verify the event belongs to this organization
            Event event = eventDAO.getEventById(eventId);
            if (event != null && event.getOrganizationID().equals(userID)) {
                if (eventDAO.deleteEvent(eventId)) {
                    request.setAttribute("success", "Event deleted successfully.");
                } else {
                    request.setAttribute("error", "Failed to delete event.");
                }
            } else {
                request.setAttribute("error", "Event not found or access denied.");
            }
        }
        
        showEvents(request, response);
    }
    
    private void showEditEvent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String eventId = request.getParameter("id");
        String userID = (String) request.getSession().getAttribute("userID");
        
        if (eventId != null) {
            Event event = eventDAO.getEventById(eventId);
            if (event != null && event.getOrganizationID().equals(userID)) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("/org/editEvent.jsp").forward(request, response);
                return;
            }
        }
        
        request.setAttribute("error", "Event not found.");
        showEvents(request, response);
    }
    
    private void showEventDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String eventId = request.getParameter("id");
        String userID = (String) request.getSession().getAttribute("userID");
        
        if (eventId != null) {
            Event event = eventDAO.getEventById(eventId);
            if (event != null && event.getOrganizationID().equals(userID)) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("/org/eventDetails.jsp").forward(request, response);
                return;
            }
        }
        
        request.setAttribute("error", "Event not found.");
        showEvents(request, response);
    }
    
    private void updateEvent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        String eventId = request.getParameter("eventId");
        
        if (eventId == null) {
            request.setAttribute("error", "Event ID is required.");
            showEvents(request, response);
            return;
        }
        
        // Verify the event belongs to this organization
        Event existingEvent = eventDAO.getEventById(eventId);
        if (existingEvent == null || !existingEvent.getOrganizationID().equals(userID)) {
            request.setAttribute("error", "Event not found or access denied.");
            showEvents(request, response);
            return;
        }
        
        try {
            // Parse form data (similar to createEvent)
            String eventTitle = request.getParameter("eventTitle");
            String eventDescription = request.getParameter("eventDescription");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");
            String eventLocation = request.getParameter("eventLocation");
            String eventCategory = request.getParameter("eventCategory");
            String participantLimitStr = request.getParameter("participantLimit");
            String registrationDeadlineStr = request.getParameter("registrationDeadline");
            String registrationFeeStr = request.getParameter("registrationFee");
            String requirements = request.getParameter("requirements");
            String specialInstructions = request.getParameter("specialInstructions");
            String contactPerson = request.getParameter("contactPerson");
            String contactEmail = request.getParameter("contactEmail");
            String contactPhone = request.getParameter("contactPhone");
            
            // Update the existing event object
            existingEvent.setEventTitle(eventTitle);
            existingEvent.setEventDescription(eventDescription);
            existingEvent.setEventDate(Date.valueOf(eventDateStr));
            existingEvent.setEventTime(Time.valueOf(eventTimeStr + ":00"));
            existingEvent.setEventLocation(eventLocation);
            existingEvent.setEventCategory(eventCategory);
            existingEvent.setParticipantLimit(participantLimitStr != null && !participantLimitStr.isEmpty() 
                                           ? Integer.parseInt(participantLimitStr) : 0);
            existingEvent.setRegistrationDeadline(registrationDeadlineStr != null && !registrationDeadlineStr.isEmpty() 
                                                ? Date.valueOf(registrationDeadlineStr) : null);
            existingEvent.setRegistrationFee(registrationFeeStr != null && !registrationFeeStr.isEmpty() 
                                           ? new BigDecimal(registrationFeeStr) : BigDecimal.ZERO);
            existingEvent.setRequirements(requirements);
            existingEvent.setSpecialInstructions(specialInstructions);
            existingEvent.setContactPerson(contactPerson);
            existingEvent.setContactEmail(contactEmail);
            existingEvent.setContactPhone(contactPhone);
            
            if (eventDAO.updateEvent(existingEvent)) {
                request.setAttribute("success", "Event updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update event.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while updating the event: " + e.getMessage());
        }
        
        showEvents(request, response);
    }
    
    // Helper method to calculate duration in hours
    private long calculateDurationInHours(Time startTime, Time endTime) {
        long startMillis = startTime.getTime();
        long endMillis = endTime.getTime();
        
        // Handle case where end time is next day
        if (endMillis < startMillis) {
            endMillis += 24 * 60 * 60 * 1000; // Add 24 hours
        }
        
        return (endMillis - startMillis) / (60 * 60 * 1000);
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("userID");
        User user = userDAO.getUserById(userID);
        
        if (user != null) {
            String fullName = request.getParameter("fullName");
            String userPhoneNo = request.getParameter("userPhoneNo");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            // Update basic info
            if (fullName != null && userPhoneNo != null) {
                user.setUserName(fullName);
                user.setUserPhoneNo(userPhoneNo);
                
                if (userDAO.updateUser(user)) {
                    request.getSession().setAttribute("userName", fullName);
                    request.setAttribute("success", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile.");
                }
            }
            
            // Update password if provided
            if (currentPassword != null && newPassword != null && 
                !currentPassword.isEmpty() && !newPassword.isEmpty()) {
                
                // Verify current password
                User authUser = userDAO.authenticateUser(user.getUserEmail(), currentPassword);
                if (authUser != null) {
                    if (userDAO.updatePassword(userID, newPassword)) {
                        request.setAttribute("success", "Password updated successfully.");
                    } else {
                        request.setAttribute("error", "Failed to update password.");
                    }
                } else {
                    request.setAttribute("error", "Current password is incorrect.");
                }
            }
        }
        
        showProfile(request, response);
    }
    
    
}