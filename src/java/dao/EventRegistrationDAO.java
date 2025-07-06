package dao;

import model.EventRegistration;
import model.Event;
import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class EventRegistrationDAO {
    
    public boolean createRegistration(EventRegistration registration) {
        String sql = "INSERT INTO event_registration (eventID, userID, registrationDate, status, " +
                    "paymentStatus, paymentAmount) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, registration.getEventID());
            stmt.setString(2, registration.getUserID());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setString(4, registration.getStatus());
            stmt.setString(5, registration.getPaymentStatus());
            stmt.setBigDecimal(6, registration.getPaymentAmount());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Get generated registration ID
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    registration.setRegistrationID(rs.getInt(1));
                }
                
                // Update event registered count
                updateEventRegisteredCount(registration.getEventID());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating registration: " + e.getMessage());
        }
        return false;
    }
    
    public EventRegistration getRegistrationById(int registrationID) {
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventTime, e.eventLocation, " +
                    "e.eventCategory, e.registrationFee, e.organizationID, u.userName " +
                    "FROM event_registration er " +
                    "JOIN event e ON er.eventID = e.eventID " +
                    "JOIN user u ON er.userID = u.userID " +
                    "WHERE er.registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, registrationID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractRegistrationFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting registration by ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<EventRegistration> getRegistrationsByUser(String userID) {
        List<EventRegistration> registrations = new ArrayList<>();
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventTime, e.eventLocation, " +
                    "e.eventCategory, e.registrationFee, e.organizationID, u.userName " +
                    "FROM event_registration er " +
                    "JOIN event e ON er.eventID = e.eventID " +
                    "JOIN user u ON er.userID = u.userID " +
                    "WHERE er.userID = ? ORDER BY er.registrationDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                registrations.add(extractRegistrationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting registrations by user: " + e.getMessage());
        }
        return registrations;
    }
    
    public List<EventRegistration> getUpcomingRegistrationsByUser(String userID) {
        List<EventRegistration> registrations = new ArrayList<>();
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventTime, e.eventLocation, " +
                    "e.eventCategory, e.registrationFee, e.organizationID, u.userName " +
                    "FROM event_registration er " +
                    "JOIN event e ON er.eventID = e.eventID " +
                    "JOIN user u ON er.userID = u.userID " +
                    "WHERE er.userID = ? AND e.eventDate >= CURDATE() " +
                    "AND er.status IN ('registered', 'confirmed') " +
                    "ORDER BY e.eventDate ASC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                registrations.add(extractRegistrationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming registrations: " + e.getMessage());
        }
        return registrations;
    }
    
    public List<EventRegistration> getRegistrationsByEvent(String eventID) {
        List<EventRegistration> registrations = new ArrayList<>();
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventTime, e.eventLocation, " +
                    "e.eventCategory, e.registrationFee, e.organizationID, u.userName " +
                    "FROM event_registration er " +
                    "JOIN event e ON er.eventID = e.eventID " +
                    "JOIN user u ON er.userID = u.userID " +
                    "WHERE er.eventID = ? ORDER BY er.registrationDate ASC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                registrations.add(extractRegistrationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting registrations by event: " + e.getMessage());
        }
        return registrations;
    }
    
    public boolean isUserRegistered(String eventID, String userID) {
        String sql = "SELECT COUNT(*) FROM event_registration WHERE eventID = ? AND userID = ? " +
                    "AND status NOT IN ('cancelled')";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            stmt.setString(2, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking user registration: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updateRegistrationStatus(int registrationID, String status) {
        String sql = "UPDATE event_registration SET status = ? WHERE registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, registrationID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating registration status: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePaymentStatus(int registrationID, String paymentStatus, BigDecimal amount) {
        String sql = "UPDATE event_registration SET paymentStatus = ?, paymentAmount = ? " +
                    "WHERE registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, paymentStatus);
            stmt.setBigDecimal(2, amount);
            stmt.setInt(3, registrationID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating payment status: " + e.getMessage());
            return false;
        }
    }
    
    public boolean cancelRegistration(int registrationID) {
        String sql = "UPDATE event_registration SET status = 'cancelled' WHERE registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, registrationID);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Update event registered count
                EventRegistration registration = getRegistrationById(registrationID);
                if (registration != null) {
                    updateEventRegisteredCount(registration.getEventID());
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error cancelling registration: " + e.getMessage());
        }
        return false;
    }
    
    public boolean cancelRegistrationByUserAndEvent(String eventID, String userID) {
        String sql = "UPDATE event_registration SET status = 'cancelled' " +
                    "WHERE eventID = ? AND userID = ? AND status NOT IN ('cancelled')";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            stmt.setString(2, userID);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                updateEventRegisteredCount(eventID);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error cancelling registration: " + e.getMessage());
        }
        return false;
    }
    
    public EventRegistration getRegistrationByUserAndEvent(String eventID, String userID) {
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventTime, e.eventLocation, " +
                    "e.eventCategory, e.registrationFee, e.organizationID, u.userName " +
                    "FROM event_registration er " +
                    "JOIN event e ON er.eventID = e.eventID " +
                    "JOIN user u ON er.userID = u.userID " +
                    "WHERE er.eventID = ? AND er.userID = ? AND er.status NOT IN ('cancelled')";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            stmt.setString(2, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractRegistrationFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting registration by user and event: " + e.getMessage());
        }
        return null;
    }
    
    public boolean submitFeedback(int registrationID, String feedback, int rating) {
        String sql = "UPDATE event_registration SET feedback = ?, rating = ? WHERE registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, feedback);
            stmt.setInt(2, rating);
            stmt.setInt(3, registrationID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error submitting feedback: " + e.getMessage());
            return false;
        }
    }
    
    public boolean markCertificateIssued(int registrationID) {
        String sql = "UPDATE event_registration SET certificateIssued = TRUE WHERE registrationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, registrationID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error marking certificate as issued: " + e.getMessage());
            return false;
        }
    }
    
    public int getRegistrationCountByUser(String userID) {
        String sql = "SELECT COUNT(*) FROM event_registration WHERE userID = ? AND status NOT IN ('cancelled')";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting registration count: " + e.getMessage());
        }
        return 0;
    }
    
    public int getCompletedEventsCount(String userID) {
        String sql = "SELECT COUNT(*) FROM event_registration er JOIN event e ON er.eventID = e.eventID " +
                    "WHERE er.userID = ? AND er.status = 'attended' AND e.eventDate < CURDATE()";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting completed events count: " + e.getMessage());
        }
        return 0;
    }
    
    public int getUpcomingEventsCount(String userID) {
        String sql = "SELECT COUNT(*) FROM event_registration er JOIN event e ON er.eventID = e.eventID " +
                    "WHERE er.userID = ? AND er.status IN ('registered', 'confirmed') AND e.eventDate >= CURDATE()";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming events count: " + e.getMessage());
        }
        return 0;
    }
    
    private void updateEventRegisteredCount(String eventID) {
        String sql = "UPDATE event SET registeredCount = " +
                    "(SELECT COUNT(*) FROM event_registration WHERE eventID = ? AND status NOT IN ('cancelled')) " +
                    "WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            stmt.setString(2, eventID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating event registered count: " + e.getMessage());
        }
    }
    
    private EventRegistration extractRegistrationFromResultSet(ResultSet rs) throws SQLException {
        EventRegistration registration = new EventRegistration();
        registration.setRegistrationID(rs.getInt("registrationID"));
        registration.setEventID(rs.getString("eventID"));
        registration.setUserID(rs.getString("userID"));
        registration.setRegistrationDate(rs.getTimestamp("registrationDate"));
        registration.setStatus(rs.getString("status"));
        registration.setPaymentStatus(rs.getString("paymentStatus"));
        registration.setPaymentAmount(rs.getBigDecimal("paymentAmount"));
        registration.setFeedback(rs.getString("feedback"));
        registration.setRating(rs.getInt("rating"));
        registration.setCertificateIssued(rs.getBoolean("certificateIssued"));
        
        // Set joined fields
        registration.setEventTitle(rs.getString("eventTitle"));
        registration.setUserName(rs.getString("userName"));
        
        return registration;
    }
}