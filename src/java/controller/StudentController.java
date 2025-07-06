package controller;

import dao.EventDAO;
import dao.EventRegistrationDAO;
import dao.UserDAO;
import model.Event;
import model.EventRegistration;
import model.User;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentController extends HttpServlet {

    private EventDAO eventDAO;
    private UserDAO userDAO;
    private EventRegistrationDAO eventRegistrationDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        userDAO = new UserDAO();
        eventRegistrationDAO = new EventRegistrationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
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
                    listEvents(request, response);
                    break;
                case "viewEvent":
                    viewEvent(request, response);
                    break;
                case "myEvents":
                    showMyEvents(request, response);
                    break;
                case "profile":
                    showProfile(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "registerEvent":
                    registerEvent(request, response);
                    break;
                case "cancelRegistration":
                    cancelRegistration(request, response);
                    break;
                case "updateProfile":
                    updateProfile(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/student?action=dashboard");
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = (String) request.getSession().getAttribute("userID");
        
        List<Event> upcomingEvents = eventDAO.getAllApprovedEvents(); // Ambil 5 acara terdekat
        if (upcomingEvents.size() > 5) {
            upcomingEvents = upcomingEvents.subList(0, 5);
        }
        
        int registeredEventsCount = eventRegistrationDAO.getRegistrationCountByUser(userID);
        int completedEventsCount = eventRegistrationDAO.getCompletedEventsCount(userID);
        
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("registeredEventsCount", registeredEventsCount);
        request.setAttribute("completedEventsCount", completedEventsCount);
        request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
    }

private void listEvents(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String userID = (String) request.getSession().getAttribute("userID");

    // 1. Fetch all approved events
    List<Event> all = eventDAO.getAllApprovedEvents();

    // 2. Filter to only those whose date is today or in the future
    List<Event> upcoming = new ArrayList<>();
    Date today = new Date();
    for (Event e : all) {
        if (e.getEventDate().compareTo(today) >= 0) {
            upcoming.add(e);
        }
    }

    // 3. (Optional) sort by date ascending
    upcoming.sort(Comparator.comparing(Event::getEventDate));

    // 4. Expose to JSP under the name your JSP expects
    request.setAttribute("upcomingEvents", upcoming);

    // 5. Forward to the student/events.jsp you just replaced
    request.getRequestDispatcher("/student/events.jsp").forward(request, response);
}

    
 private void viewEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        String userID = (String) request.getSession().getAttribute("userID");

        Event event = eventDAO.getEventById(eventId);
        boolean isRegistered = eventRegistrationDAO.isUserRegistered(eventId, userID);
        
        // ▼▼▼ TAMBAH KOD INI ▼▼▼
        boolean isFull = event != null && event.getParticipantLimit() > 0 && event.getRegisteredCount() >= event.getParticipantLimit();
        // ▲▲▲ TAMBAH KOD INI ▲▲▲

        if (event != null) {
            User organization = userDAO.getUserById(event.getOrganizationID());
            request.setAttribute("event", event);
            request.setAttribute("organization", organization);
            request.setAttribute("isRegistered", isRegistered);
            // ▼▼▼ TAMBAH KOD INI ▼▼▼
            request.setAttribute("isFull", isFull);
            // ▲▲▲ TAMBAH KOD INI ▲▲▲
            request.getRequestDispatcher("/student/eventDetails.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "Event not found.");
            response.sendRedirect(request.getContextPath() + "/student?action=events");
        }
    }
    
    private void registerEvent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String eventId = request.getParameter("eventId");
        String userID = (String) request.getSession().getAttribute("userID");
        
        Event event = eventDAO.getEventById(eventId);
        
        if(event.getRegisteredCount() >= event.getParticipantLimit() && event.getParticipantLimit() > 0) {
            request.getSession().setAttribute("error", "Event is full.");
            response.sendRedirect(request.getContextPath() + "/student?action=viewEvent&eventId=" + eventId);
            return;
        }

        if (eventRegistrationDAO.isUserRegistered(eventId, userID)) {
            request.getSession().setAttribute("error", "You are already registered for this event.");
        } else {
            EventRegistration registration = new EventRegistration(eventId, userID, "registered", "pending", event.getRegistrationFee());
            if (eventRegistrationDAO.createRegistration(registration)) {
                request.getSession().setAttribute("success", "Successfully registered for the event: " + event.getEventTitle());
            } else {
                request.getSession().setAttribute("error", "Failed to register for the event.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/student?action=myEvents");
    }
    
    private void showMyEvents(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String userID = (String) request.getSession().getAttribute("userID");
        List<EventRegistration> myRegistrations = eventRegistrationDAO.getRegistrationsByUser(userID);
        
        request.setAttribute("myRegistrations", myRegistrations);
        request.getRequestDispatcher("/student/myEvents.jsp").forward(request, response);
    }

    private void cancelRegistration(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        String eventId = request.getParameter("eventId");
        String userID = (String) request.getSession().getAttribute("userID");

        if (eventRegistrationDAO.cancelRegistrationByUserAndEvent(eventId, userID)) {
            request.getSession().setAttribute("success", "Your registration has been cancelled.");
        } else {
            request.getSession().setAttribute("error", "Failed to cancel registration.");
        }
        response.sendRedirect(request.getContextPath() + "/student?action=myEvents");
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = (String) request.getSession().getAttribute("userID");
        User user = userDAO.getUserById(userID);
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");
        User user = userDAO.getUserById(userID);

        if (user != null) {
            String userName = request.getParameter("userName");
            String userPhoneNo = request.getParameter("userPhoneNo");

            user.setUserName(userName);
            user.setUserPhoneNo(userPhoneNo);
            
            boolean profileUpdated = userDAO.updateUser(user);
            if(profileUpdated) {
                session.setAttribute("userName", userName);
                session.setAttribute("success", "Profile successfully updated.");
            }

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");

            if (currentPassword != null && !currentPassword.isEmpty() && newPassword != null && !newPassword.isEmpty()) {
                User authUser = userDAO.authenticateUser(user.getUserEmail(), currentPassword);
                if (authUser != null) {
                    boolean passwordUpdated = userDAO.updatePassword(userID, newPassword);
                    if (passwordUpdated) {
                        session.setAttribute("success", "Profile and password updated successfully.");
                    } else {
                        session.setAttribute("error", "Failed to update password.");
                    }
                } else {
                    session.setAttribute("error", "Incorrect current password.");
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/student?action=profile");
    }
}