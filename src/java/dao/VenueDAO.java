package dao;

import model.Venue;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import model.VenueBooking;

public class VenueDAO {
    

    public boolean createVenue(Venue venue) {
        String sql = "INSERT INTO venue (venueName, building, floor, venueType, capacity, description, facilities, price, imageUrl, availability, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, venue.getVenueName());
            stmt.setString(2, venue.getBuilding());
            stmt.setString(3, venue.getFloor());
            stmt.setString(4, venue.getVenueType());
            stmt.setInt(5, venue.getCapacity());
            stmt.setString(6, venue.getDescription());
            stmt.setString(7, String.join(",", venue.getFacilities())); // Tukar List ke String
            stmt.setBigDecimal(8, venue.getPrice());
            stmt.setString(9, venue.getImageUrl());
            stmt.setString(10, "available"); // Status lalai

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating venue: " + e.getMessage());
            return false;
        }
    }

    /**
     * Mengemas kini rekod venue sedia ada berdasarkan ID.
     * @param venue Objek Venue yang mengandungi maklumat baharu.
     * @return true jika berjaya, false jika gagal.
     */
    public boolean updateVenue(Venue venue) {
        String sql = "UPDATE venue SET venueName=?, building=?, floor=?, venueType=?, capacity=?, description=?, facilities=?, price=?, imageUrl=?, availability=?, updatedAt=NOW() WHERE venueID=?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, venue.getVenueName());
            stmt.setString(2, venue.getBuilding());
            stmt.setString(3, venue.getFloor());
            stmt.setString(4, venue.getVenueType());
            stmt.setInt(5, venue.getCapacity());
            stmt.setString(6, venue.getDescription());
            stmt.setString(7, String.join(",", venue.getFacilities()));
            stmt.setBigDecimal(8, venue.getPrice());
            stmt.setString(9, venue.getImageUrl());
            stmt.setString(10, venue.getAvailability());
            stmt.setInt(11, venue.getVenueID());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating venue: " + e.getMessage());
            return false;
        }
    }

    /**
     * Memadam satu rekod venue berdasarkan ID.
     * @param venueId ID untuk venue yang hendak dipadam.
     * @return true jika berjaya, false jika gagal.
     */
    public boolean deleteVenue(int venueId) {
        String sql = "DELETE FROM venue WHERE venueID = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, venueId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Ralat mungkin berlaku jika venue terikat pada tempahan sedia ada
            System.err.println("Error deleting venue: " + e.getMessage());
            return false;
        }
    }

    // --- Kaedah-kaedah Sedia Ada (Untuk Paparan) ---

    public Venue getVenueById(int venueID) {
        String sql = "SELECT * FROM venue WHERE venueID = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, venueID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractVenueFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Venue> getAllVenues() {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue ORDER BY venueName";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return venues;
    }
    

    private Venue extractVenueFromResultSet(ResultSet rs) throws SQLException {
        Venue venue = new Venue();
        venue.setVenueID(rs.getInt("venueID"));
        venue.setVenueName(rs.getString("venueName"));
        venue.setBuilding(rs.getString("building"));
        venue.setFloor(rs.getString("floor"));
        venue.setVenueType(rs.getString("venueType"));
        venue.setCapacity(rs.getInt("capacity"));
        venue.setDescription(rs.getString("description"));
        venue.setPrice(rs.getBigDecimal("price"));
        venue.setImageUrl(rs.getString("imageUrl"));
        venue.setAvailability(rs.getString("availability"));
        venue.setCreatedAt(rs.getTimestamp("createdAt"));
        venue.setUpdatedAt(rs.getTimestamp("updatedAt"));

        // Tukar semula String kemudahan kepada List<String>
        String facilitiesStr = rs.getString("facilities");
        if (facilitiesStr != null && !facilitiesStr.isEmpty()) {
            venue.setFacilities(new ArrayList<>(Arrays.asList(facilitiesStr.split(","))));
        } else {
            venue.setFacilities(new ArrayList<>()); // Senarai kosong jika tiada kemudahan
        }
        
        return venue;
    }

    public List<Venue> getAvailableVenues() {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE availability = 'available' ORDER BY venueName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting available venues: " + e.getMessage());
        }
        return venues;
    }
    
    
    public List<Venue> getVenuesByCapacity(int minCapacity) {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE capacity >= ? ORDER BY capacity ASC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, minCapacity);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting venues by capacity: " + e.getMessage());
        }
        return venues;
    }
    
    public List<Venue> getVenuesByBuilding(String building) {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE building = ? ORDER BY venueName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, building);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting venues by building: " + e.getMessage());
        }
        return venues;
    }
    
    public List<Venue> getVenuesByType(String venueType) {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE venueType = ? ORDER BY venueName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, venueType);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting venues by type: " + e.getMessage());
        }
        return venues;
    }
    
    public List<Venue> searchVenues(String searchTerm) {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE venueName LIKE ? OR description LIKE ? OR building LIKE ? " +
                    "ORDER BY venueName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching venues: " + e.getMessage());
        }
        return venues;
    }
    
    public List<Venue> getVenuesWithFilters(Integer minCapacity, String building, String venueType, String availability) {
        List<Venue> venues = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM venue WHERE 1=1");
        List<Object> parameters = new ArrayList<>();
        
        if (minCapacity != null && minCapacity > 0) {
            sql.append(" AND capacity >= ?");
            parameters.add(minCapacity);
        }
        
        if (building != null && !building.isEmpty()) {
            sql.append(" AND building = ?");
            parameters.add(building);
        }
        
        if (venueType != null && !venueType.isEmpty()) {
            sql.append(" AND venueType = ?");
            parameters.add(venueType);
        }
        
        if (availability != null && !availability.isEmpty()) {
            sql.append(" AND availability = ?");
            parameters.add(availability);
        }
        
        sql.append(" ORDER BY venueName");
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                venues.add(extractVenueFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting venues with filters: " + e.getMessage());
        }
        return venues;
    }
    
    public boolean isVenueAvailable(int venueID, Date date, Time startTime, Time endTime) {
        String sql = "SELECT COUNT(*) FROM venue_booking " +
                    "WHERE venueID = ? AND bookingDate = ? AND status IN ('confirmed', 'pending') " +
                    "AND ((startTime <= ? AND endTime > ?) OR (startTime < ? AND endTime >= ?))";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, venueID);
            stmt.setDate(2, date);
            stmt.setTime(3, startTime);
            stmt.setTime(4, startTime);
            stmt.setTime(5, endTime);
            stmt.setTime(6, endTime);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) == 0; // No conflicting bookings
            }
        } catch (SQLException e) {
            System.err.println("Error checking venue availability: " + e.getMessage());
        }
        return false;
    }
    
    public List<String> getAllBuildings() {
        List<String> buildings = new ArrayList<>();
        String sql = "SELECT DISTINCT building FROM venue ORDER BY building";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                buildings.add(rs.getString("building"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting buildings: " + e.getMessage());
        }
        return buildings;
    }
    
    public List<String> getAllVenueTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT venueType FROM venue ORDER BY venueType";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                types.add(rs.getString("venueType"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting venue types: " + e.getMessage());
        }
        return types;
    }
    
    public int getTotalVenues() {
        String sql = "SELECT COUNT(*) FROM venue";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total venues: " + e.getMessage());
        }
        return 0;
    }
    
    public int getAvailableVenuesCount() {
        String sql = "SELECT COUNT(*) FROM venue WHERE availability = 'available'";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting available venues count: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean updateVenueAvailability(int venueID, String availability) {
        String sql = "UPDATE venue SET availability = ?, updatedAt = CURRENT_TIMESTAMP WHERE venueID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, availability);
            stmt.setInt(2, venueID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating venue availability: " + e.getMessage());
            return false;
        }
    }
}
    
