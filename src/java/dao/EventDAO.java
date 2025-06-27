package dao;

import model.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class EventDAO {
    
    public boolean createEvent(Event event) {
        String sql = "INSERT INTO event (eventID, organizationID, eventTitle, eventDescription, " +
                    "eventDate, eventTime, eventLocation, eventCategory, participantLimit, " +
                    "registrationDeadline, registrationFee, requirements, specialInstructions, " +
                    "contactPerson, contactEmail, contactPhone, eventStatus) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, event.getEventID());
            stmt.setString(2, event.getOrganizationID());
            stmt.setString(3, event.getEventTitle());
            stmt.setString(4, event.getEventDescription());
            stmt.setDate(5, event.getEventDate());
            stmt.setTime(6, event.getEventTime());
            stmt.setString(7, event.getEventLocation());
            stmt.setString(8, event.getEventCategory());
            stmt.setInt(9, event.getParticipantLimit());
            stmt.setDate(10, event.getRegistrationDeadline());
            stmt.setBigDecimal(11, event.getRegistrationFee());
            stmt.setString(12, event.getRequirements());
            stmt.setString(13, event.getSpecialInstructions());
            stmt.setString(14, event.getContactPerson());
            stmt.setString(15, event.getContactEmail());
            stmt.setString(16, event.getContactPhone());
            stmt.setString(17, event.getEventStatus());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating event: " + e.getMessage());
            return false;
        }
    }
    
    public Event getEventById(String eventID) {
        String sql = "SELECT * FROM event WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractEventFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event by ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<Event> getEventsByOrganization(String organizationID) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE organizationID = ? ORDER BY eventDate DESC, createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting events by organization: " + e.getMessage());
        }
        return events;
    }
    
    public List<Event> getEventsByOrganizationAndStatus(String organizationID, String status) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE organizationID = ? AND eventStatus = ? " +
                    "ORDER BY eventDate DESC, createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting events by organization and status: " + e.getMessage());
        }
        return events;
    }
    
    public List<Event> getUpcomingEventsByOrganization(String organizationID) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE organizationID = ? AND eventDate >= CURDATE() " +
                    "ORDER BY eventDate ASC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming events: " + e.getMessage());
        }
        return events;
    }
    
    public List<Event> getPastEventsByOrganization(String organizationID) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE organizationID = ? AND eventDate < CURDATE() " +
                    "ORDER BY eventDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting past events: " + e.getMessage());
        }
        return events;
    }
    
    public boolean updateEvent(Event event) {
        String sql = "UPDATE event SET eventTitle = ?, eventDescription = ?, eventDate = ?, " +
                    "eventTime = ?, eventLocation = ?, eventCategory = ?, participantLimit = ?, " +
                    "registrationDeadline = ?, registrationFee = ?, requirements = ?, " +
                    "specialInstructions = ?, contactPerson = ?, contactEmail = ?, contactPhone = ?, " +
                    "updatedAt = CURRENT_TIMESTAMP WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, event.getEventTitle());
            stmt.setString(2, event.getEventDescription());
            stmt.setDate(3, event.getEventDate());
            stmt.setTime(4, event.getEventTime());
            stmt.setString(5, event.getEventLocation());
            stmt.setString(6, event.getEventCategory());
            stmt.setInt(7, event.getParticipantLimit());
            stmt.setDate(8, event.getRegistrationDeadline());
            stmt.setBigDecimal(9, event.getRegistrationFee());
            stmt.setString(10, event.getRequirements());
            stmt.setString(11, event.getSpecialInstructions());
            stmt.setString(12, event.getContactPerson());
            stmt.setString(13, event.getContactEmail());
            stmt.setString(14, event.getContactPhone());
            stmt.setString(15, event.getEventID());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating event: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateEventStatus(String eventID, String status, String approvedBy, String rejectionReason) {
        String sql = "UPDATE event SET eventStatus = ?, approvedBy = ?, approvedAt = ?, " +
                    "rejectionReason = ?, updatedAt = CURRENT_TIMESTAMP WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, approvedBy);
            if ("approved".equals(status)) {
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            } else {
                stmt.setTimestamp(3, null);
            }
            stmt.setString(4, rejectionReason);
            stmt.setString(5, eventID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating event status: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteEvent(String eventID) {
        String sql = "DELETE FROM event WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting event: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateRegisteredCount(String eventID, int count) {
        String sql = "UPDATE event SET registeredCount = ?, updatedAt = CURRENT_TIMESTAMP WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, count);
            stmt.setString(2, eventID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating registered count: " + e.getMessage());
            return false;
        }
    }
    
    public int getEventCountByOrganization(String organizationID) {
        String sql = "SELECT COUNT(*) FROM event WHERE organizationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event count: " + e.getMessage());
        }
        return 0;
    }
    
    public int getEventCountByOrganizationAndStatus(String organizationID, String status) {
        String sql = "SELECT COUNT(*) FROM event WHERE organizationID = ? AND eventStatus = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event count by status: " + e.getMessage());
        }
        return 0;
    }
    
    public int getTotalParticipantsByOrganization(String organizationID) {
        String sql = "SELECT SUM(registeredCount) FROM event WHERE organizationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total participants: " + e.getMessage());
        }
        return 0;
    }
    
    public String generateNextEventID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(eventID, 4) AS UNSIGNED)) FROM event WHERE eventID LIKE 'EVT%'";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                int maxNumber = rs.getInt(1);
                return String.format("EVT%03d", maxNumber + 1);
            } else {
                return "EVT001";
            }
        } catch (SQLException e) {
            System.err.println("Error generating event ID: " + e.getMessage());
            return "EVT001";
        }
    }
    
    public List<Event> getAllApprovedEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE eventStatus = 'approved' AND eventDate >= CURDATE() ORDER BY eventDate ASC";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    private Event extractEventFromResultSet(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventID(rs.getString("eventID"));
        event.setOrganizationID(rs.getString("organizationID"));
        event.setEventTitle(rs.getString("eventTitle"));
        event.setEventDescription(rs.getString("eventDescription"));
        event.setEventDate(rs.getDate("eventDate"));
        event.setEventTime(rs.getTime("eventTime"));
        event.setEventLocation(rs.getString("eventLocation"));
        event.setEventCategory(rs.getString("eventCategory"));
        event.setParticipantLimit(rs.getInt("participantLimit"));
        event.setRegistrationDeadline(rs.getDate("registrationDeadline"));
        event.setRegistrationFee(rs.getBigDecimal("registrationFee"));
        event.setRequirements(rs.getString("requirements"));
        event.setSpecialInstructions(rs.getString("specialInstructions"));
        event.setContactPerson(rs.getString("contactPerson"));
        event.setContactEmail(rs.getString("contactEmail"));
        event.setContactPhone(rs.getString("contactPhone"));
        event.setEventStatus(rs.getString("eventStatus"));
        event.setApprovedBy(rs.getString("approvedBy"));
        event.setApprovedAt(rs.getTimestamp("approvedAt"));
        event.setRejectionReason(rs.getString("rejectionReason"));
        event.setRegisteredCount(rs.getInt("registeredCount"));
        event.setCreatedAt(rs.getTimestamp("createdAt"));
        event.setUpdatedAt(rs.getTimestamp("updatedAt"));
        return event;
    }
    

    public Map<String, Integer> getEventCountByCategory(String organizationID) {
        Map<String, Integer> categoryCount = new HashMap<>();
        String sql = "SELECT eventCategory, COUNT(*) as count FROM event WHERE organizationID = ? GROUP BY eventCategory";

        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                categoryCount.put(rs.getString("eventCategory"), rs.getInt("count"));
            }

        } catch (SQLException e) {
            System.err.println("Error getting event count by category: " + e.getMessage());
        }

        return categoryCount;
    }


    public int getEventCountByOrganization(String organizationID, Date fromDate, Date toDate) {
        String sql = "SELECT COUNT(*) FROM event WHERE organizationID = ? ";
        if (fromDate != null && toDate != null) {
            sql += "AND eventDate BETWEEN ? AND ? ";
        }

        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, organizationID);
             if (fromDate != null && toDate != null) {
                stmt.setDate(2, fromDate);
                stmt.setDate(3, toDate);
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event count: " + e.getMessage());
        }
        return 0;
    }
    
    public Map<String, Integer> getMonthlyEventCounts(String organizationID) {
    Map<String, Integer> monthlyData = new HashMap<>();
    String sql = "SELECT DATE_FORMAT(eventDate, '%Y-%m') as month, COUNT(eventID) as count " +
                 "FROM event WHERE organizationID = ? " +
                 "GROUP BY month ORDER BY month ASC";
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, organizationID);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            monthlyData.put(rs.getString("month"), rs.getInt("count"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return monthlyData;
}

}