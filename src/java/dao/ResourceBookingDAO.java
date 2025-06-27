package dao;

import model.ResourceBooking;
import model.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResourceBookingDAO {
    
    public boolean createResourceBooking(ResourceBooking booking) {
        String sql = "INSERT INTO resource_booking (resourceID, userID, eventName, eventLocation, " +
                    "borrowDate, returnDate, quantity, purpose, contactPerson, contactPhone, " +
                    "depositAmount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, booking.getResourceID());
            stmt.setString(2, booking.getUserID());
            stmt.setString(3, booking.getEventName());
            stmt.setString(4, booking.getEventLocation());
            stmt.setDate(5, booking.getBorrowDate());
            stmt.setDate(6, booking.getReturnDate());
            stmt.setInt(7, booking.getQuantity());
            stmt.setString(8, booking.getPurpose());
            stmt.setString(9, booking.getContactPerson());
            stmt.setString(10, booking.getContactPhone());
            stmt.setBigDecimal(11, booking.getDepositAmount());
            stmt.setString(12, booking.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating resource booking: " + e.getMessage());
            return false;
        }
    }
    
    public ResourceBooking getResourceBookingById(int bookingID) {
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractResourceBookingFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting resource booking by ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<ResourceBooking> getBookingsByUser(String userID) {
        List<ResourceBooking> bookings = new ArrayList<>();
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.userID = ? ORDER BY rb.borrowDate DESC, rb.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractResourceBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by user: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<ResourceBooking> getBookingsByResource(int resourceID) {
        List<ResourceBooking> bookings = new ArrayList<>();
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.resourceID = ? ORDER BY rb.borrowDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resourceID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractResourceBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by resource: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<ResourceBooking> getActiveBookingsByResource(int resourceID) {
        List<ResourceBooking> bookings = new ArrayList<>();
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.resourceID = ? AND rb.status IN ('confirmed', 'borrowed') " +
                    "AND rb.returnDate >= CURDATE() ORDER BY rb.borrowDate";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resourceID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractResourceBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting active bookings by resource: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<ResourceBooking> getBookingsByStatus(String status) {
        List<ResourceBooking> bookings = new ArrayList<>();
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.status = ? ORDER BY rb.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractResourceBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bookings by status: " + e.getMessage());
        }
        return bookings;
    }
    
    public List<ResourceBooking> getOverdueBookings() {
        List<ResourceBooking> bookings = new ArrayList<>();
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                    "FROM resource_booking rb " +
                    "JOIN resource r ON rb.resourceID = r.resourceID " +
                    "JOIN user u ON rb.userID = u.userID " +
                    "WHERE rb.status IN ('confirmed', 'borrowed') AND rb.returnDate < CURDATE() " +
                    "ORDER BY rb.returnDate";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ResourceBooking booking = extractResourceBookingFromResultSet(rs);
                booking.setStatus("overdue"); // Mark as overdue
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("Error getting overdue bookings: " + e.getMessage());
        }
        return bookings;
    }
    
    public boolean updateBookingStatus(int bookingID, String status, String approvedBy, String rejectionReason) {
        String sql = "UPDATE resource_booking SET status = ?, approvedBy = ?, approvedAt = ?, " +
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
    
    public boolean markAsReturned(int bookingID, String condition) {
        String sql = "UPDATE resource_booking SET status = 'returned', actualReturnDate = CURDATE(), " +
                    "condition = ?, updatedAt = CURRENT_TIMESTAMP WHERE bookingID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, condition);
            stmt.setInt(2, bookingID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error marking booking as returned: " + e.getMessage());
            return false;
        }
    }
    
    public boolean cancelBooking(int bookingID) {
        String sql = "UPDATE resource_booking SET status = 'cancelled', updatedAt = CURRENT_TIMESTAMP WHERE bookingID = ?";
        
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
        String sql = "DELETE FROM resource_booking WHERE bookingID = ?";
        
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
        String sql = "SELECT COUNT(*) FROM resource_booking WHERE userID = ?";
        
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
    
    public int getOverdueBookingCount() {
        String sql = "SELECT COUNT(*) FROM resource_booking WHERE status IN ('confirmed', 'borrowed') " +
                    "AND returnDate < CURDATE()";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting overdue booking count: " + e.getMessage());
        }
        return 0;
    }
    
    public int getTotalQuantityBooked(int resourceID, Date startDate, Date endDate) {
        String sql = "SELECT SUM(quantity) FROM resource_booking " +
                    "WHERE resourceID = ? AND status IN ('confirmed', 'borrowed') " +
                    "AND ((borrowDate <= ? AND returnDate >= ?) OR (borrowDate <= ? AND returnDate >= ?))";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resourceID);
            stmt.setDate(2, startDate);
            stmt.setDate(3, startDate);
            stmt.setDate(4, endDate);
            stmt.setDate(5, endDate);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total quantity booked: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean hasConflictingBooking(int resourceID, Date borrowDate, Date returnDate, 
                                       int requestedQuantity, Integer excludeBookingID) {
        StringBuilder sql = new StringBuilder(
            "SELECT SUM(quantity) FROM resource_booking " +
            "WHERE resourceID = ? AND status IN ('confirmed', 'borrowed', 'pending') " +
            "AND ((borrowDate <= ? AND returnDate >= ?) OR (borrowDate <= ? AND returnDate >= ?))"
        );
        
        if (excludeBookingID != null) {
            sql.append(" AND bookingID != ?");
        }
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            stmt.setInt(1, resourceID);
            stmt.setDate(2, borrowDate);
            stmt.setDate(3, borrowDate);
            stmt.setDate(4, returnDate);
            stmt.setDate(5, returnDate);
            
            if (excludeBookingID != null) {
                stmt.setInt(6, excludeBookingID);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int totalBooked = rs.getInt(1);
                
                // Check if adding the requested quantity would exceed available quantity
                ResourceDAO resourceDAO = new ResourceDAO();
                Resource resource = resourceDAO.getResourceById(resourceID);
                if (resource != null) {
                    return (totalBooked + requestedQuantity) > resource.getTotalQuantity();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking conflicting booking: " + e.getMessage());
        }
        return true; // Assume conflict if error occurs
    }
    
    private ResourceBooking extractResourceBookingFromResultSet(ResultSet rs) throws SQLException {
        ResourceBooking booking = new ResourceBooking();
        booking.setBookingID(rs.getInt("bookingID"));
        booking.setResourceID(rs.getInt("resourceID"));
        booking.setUserID(rs.getString("userID"));
        booking.setEventName(rs.getString("eventName"));
        booking.setEventLocation(rs.getString("eventLocation"));
        booking.setBorrowDate(rs.getDate("borrowDate"));
        booking.setReturnDate(rs.getDate("returnDate"));
        booking.setQuantity(rs.getInt("quantity"));
        booking.setPurpose(rs.getString("purpose"));
        booking.setContactPerson(rs.getString("contactPerson"));
        booking.setContactPhone(rs.getString("contactPhone"));
        booking.setStatus(rs.getString("status"));
        booking.setDepositAmount(rs.getBigDecimal("depositAmount"));
        booking.setActualReturnDate(rs.getDate("actualReturnDate"));
        booking.setCondition(rs.getString("condition"));
        booking.setApprovedBy(rs.getString("approvedBy"));
        booking.setApprovedAt(rs.getTimestamp("approvedAt"));
        booking.setRejectionReason(rs.getString("rejectionReason"));
        booking.setCreatedAt(rs.getTimestamp("createdAt"));
        booking.setUpdatedAt(rs.getTimestamp("updatedAt"));
        
        // Joined fields
        booking.setResourceName(rs.getString("resourceName"));
        booking.setCategory(rs.getString("category"));
        booking.setUserName(rs.getString("userName"));
        
        return booking;
    }


    public List<ResourceBooking> getAllBookings() {
        List<ResourceBooking> bookings = new ArrayList<>();
        // SQL ini melakukan JOIN untuk mendapatkan nama resource dan nama pengguna
        String sql = "SELECT rb.*, r.resourceName, r.category, u.userName " +
                     "FROM resource_booking rb " +
                     "JOIN resource r ON rb.resourceID = r.resourceID " +
                     "JOIN user u ON rb.userID = u.userID " +
                     "ORDER BY rb.createdAt DESC";

        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Gunakan kaedah helper sedia ada untuk memetakan data
                bookings.add(extractResourceBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all resource bookings: " + e.getMessage());
        }
        return bookings;
    }

}