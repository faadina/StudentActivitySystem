package dao;

import model.VenueBooking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class VenueBookingDAO {
    
    public boolean createVenueBooking(VenueBooking booking) {
        String sql = "INSERT INTO venue_booking (venueID, userID, eventType, bookingDate, startTime, endTime, " +
                    "purpose, expectedAttendees, facilitiesRequired, totalAmount, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, booking.getVenueID());
            stmt.setString(2, booking.getUserID());
            stmt.setString(3, booking.getEventType());
            stmt.setDate(4, booking.getBookingDate());
            stmt.setTime(5, booking.getStartTime());
            stmt.setTime(6, booking.getEndTime());
            stmt.setString(7, booking.getPurpose());
            stmt.setInt(8, booking.getExpectedAttendees());
            
            // Convert facilities list to JSON string (simple approach)
            String facilitiesJson = listToJsonString(booking.getFacilitiesRequired());
            stmt.setString(9, facilitiesJson);
            
            stmt.setBigDecimal(10, booking.getTotalAmount());
            stmt.setString(11, booking.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating venue booking: " + e.getMessage());
            return false;
        }
    }
    
    public VenueBooking getVenueBookingById(int bookingID) {
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "LEFT JOIN venue v ON vb.venueID = v.venueID " +
                    "LEFT JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractVenueBookingFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting venue booking by ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<VenueBooking> getBookingsByUser(String userID) {
        List<VenueBooking> bookings = new ArrayList<>();
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "JOIN venue v ON vb.venueID = v.venueID " +
                    "JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.userID = ? ORDER BY vb.bookingDate DESC, vb.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by user: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<VenueBooking> getBookingsByVenue(int venueID) {
        List<VenueBooking> bookings = new ArrayList<>();
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "JOIN venue v ON vb.venueID = v.venueID " +
                    "JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.venueID = ? ORDER BY vb.bookingDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, venueID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by venue: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<VenueBooking> getUpcomingBookingsByUser(String userID) {
        List<VenueBooking> bookings = new ArrayList<>();
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "JOIN venue v ON vb.venueID = v.venueID " +
                    "JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.userID = ? AND vb.bookingDate >= CURDATE() " +
                    "ORDER BY vb.bookingDate ASC, vb.startTime ASC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming bookings: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<VenueBooking> getBookingsByStatus(String status) {
        List<VenueBooking> bookings = new ArrayList<>();
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "JOIN venue v ON vb.venueID = v.venueID " +
                    "JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.status = ? ORDER BY vb.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by status: " + e.getMessage());
        }
        return bookings;
    }
    
    public boolean updateBookingStatus(int bookingID, String status, String approvedBy, String rejectionReason) {
        String sql = "UPDATE venue_booking SET status = ?, approvedBy = ?, approvedAt = ?, " +
                    "rejectionReason = ?, updatedAt = CURRENT_TIMESTAMP WHERE bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, approvedBy);
            if ("confirmed".equals(status)) {
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            } else {
                stmt.setTimestamp(3, null);
            }
            stmt.setString(4, rejectionReason);
            stmt.setInt(5, bookingID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating booking status: " + e.getMessage());
            return false;
        }
    }
    
    public boolean cancelBooking(int bookingID) {
        String sql = "UPDATE venue_booking SET status = 'cancelled', updatedAt = CURRENT_TIMESTAMP WHERE bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error cancelling booking: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBooking(int bookingID) {
        String sql = "DELETE FROM venue_booking WHERE bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting booking: " + e.getMessage());
            return false;
        }
    }
    
    public int getBookingCountByUser(String userID) {
        String sql = "SELECT COUNT(*) FROM venue_booking WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting booking count by user: " + e.getMessage());
        }
        return 0;
    }
    
    public int getUpcomingBookingCountByUser(String userID) {
        String sql = "SELECT COUNT(*) FROM venue_booking WHERE userID = ? AND bookingDate >= CURDATE()";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming booking count: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean hasConflictingBooking(int venueID, Date bookingDate, Time startTime, Time endTime, Integer excludeBookingID) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM venue_booking " +
            "WHERE venueID = ? AND bookingDate = ? AND status IN ('confirmed', 'pending') " +
            "AND ((startTime <= ? AND endTime > ?) OR (startTime < ? AND endTime >= ?))"
        );
        
        if (excludeBookingID != null) {
            sql.append(" AND bookingID != ?");
        }
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            stmt.setInt(1, venueID);
            stmt.setDate(2, bookingDate);
            stmt.setTime(3, startTime);
            stmt.setTime(4, startTime);
            stmt.setTime(5, endTime);
            stmt.setTime(6, endTime);
            
            if (excludeBookingID != null) {
                stmt.setInt(7, excludeBookingID);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking conflicting booking: " + e.getMessage());
        }
        return true; // Assume conflict if error occurs
    }
    
    public List<VenueBooking> getBookingsForDateRange(Date startDate, Date endDate) {
        List<VenueBooking> bookings = new ArrayList<>();
        String sql = "SELECT vb.*, v.venueName, v.building, u.userName " +
                    "FROM venue_booking vb " +
                    "JOIN venue v ON vb.venueID = v.venueID " +
                    "JOIN user u ON vb.userID = u.userID " +
                    "WHERE vb.bookingDate BETWEEN ? AND ? " +
                    "ORDER BY vb.bookingDate, vb.startTime";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings for date range: " + e.getMessage());
        }
        return bookings;
    }
    
    // Helper method to convert List<String> to JSON string
    private String listToJsonString(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                json.append(",");
            }
            json.append("\"").append(list.get(i)).append("\"");
        }
        json.append("]");
        return json.toString();
    }
    
    private VenueBooking extractVenueBookingFromResultSet(ResultSet rs) throws SQLException {
        VenueBooking booking = new VenueBooking();
        booking.setBookingID(rs.getInt("bookingID"));
        booking.setVenueID(rs.getInt("venueID"));
        booking.setUserID(rs.getString("userID"));
        booking.setEventType(rs.getString("eventType"));
        booking.setBookingDate(rs.getDate("bookingDate"));
        booking.setStartTime(rs.getTime("startTime"));
        booking.setEndTime(rs.getTime("endTime"));
        booking.setPurpose(rs.getString("purpose"));
        booking.setExpectedAttendees(rs.getInt("expectedAttendees"));
        
        // Parse facilities from JSON string (simple approach like VenueDAO)
        String facilitiesJson = rs.getString("facilitiesRequired");
        List<String> facilities = new ArrayList<>();
        if (facilitiesJson != null && !facilitiesJson.isEmpty()) {
            // Simple JSON parsing - remove brackets and quotes, split by comma
            facilitiesJson = facilitiesJson.replace("[", "").replace("]", "").replace("\"", "");
            if (!facilitiesJson.trim().isEmpty()) {
                String[] facilitiesArray = facilitiesJson.split(",");
                for (String facility : facilitiesArray) {
                    facilities.add(facility.trim());
                }
            }
        }
        booking.setFacilitiesRequired(facilities);
        
        booking.setStatus(rs.getString("status"));
        booking.setTotalAmount(rs.getBigDecimal("totalAmount"));
        booking.setApprovedBy(rs.getString("approvedBy"));
        booking.setApprovedAt(rs.getTimestamp("approvedAt"));
        booking.setRejectionReason(rs.getString("rejectionReason"));
        booking.setCreatedAt(rs.getTimestamp("createdAt"));
        booking.setUpdatedAt(rs.getTimestamp("updatedAt"));
        
        // Joined fields
        booking.setVenueName(rs.getString("venueName"));
        booking.setBuilding(rs.getString("building"));
        booking.setUserName(rs.getString("userName"));
        
        return booking;
    }
    
    public Map<String, Integer> getVenueBookingCounts() {
    Map<String, Integer> venueCounts = new HashMap<>();
    String sql = "SELECT v.venueName, COUNT(vb.bookingID) as booking_count " +
                 "FROM venue_booking vb JOIN venue v ON vb.venueID = v.venueID " +
                 "GROUP BY v.venueName ORDER BY booking_count DESC LIMIT 10";
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            venueCounts.put(rs.getString("venueName"), rs.getInt("booking_count"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return venueCounts;
}
    
    
    public List<VenueBooking> getAllBookings() {
        List<VenueBooking> bookings = new ArrayList<>();
        // SQL ini melakukan JOIN untuk mendapatkan nama venue dan nama pengguna
        String sql = "SELECT vb.*, v.venueName, u.userName " +
                     "FROM venue_booking vb " +
                     "JOIN venue v ON vb.venueID = v.venueID " +
                     "JOIN user u ON vb.userID = u.userID " +
                     "ORDER BY vb.createdAt DESC";

        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Gunakan kaedah helper sedia ada untuk memetakan data
                bookings.add(extractVenueBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all venue bookings: " + e.getMessage());
        }
        return bookings;
    }
}