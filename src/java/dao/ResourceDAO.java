package dao;

import model.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import model.ResourceBooking;

public class ResourceDAO {
    
    private final Connection conn;

    public ResourceDAO() {
        // Ensure a live connection; DatabaseConnection can return a new or pooled connection
        this.conn = DatabaseConnection.getDBConnection();
    }
    
    public boolean createResource(Resource resource) {
        String sql = "INSERT INTO resource (resourceName, category, description, location, totalQuantity, availableQuantity, `condition`, depositRequired, imageUrl, specifications, usageInstructions, availability, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'available', NOW(), NOW())";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, resource.getResourceName());
            stmt.setString(2, resource.getCategory());
            stmt.setString(3, resource.getDescription());
            stmt.setString(4, resource.getLocation());
            stmt.setInt(5, resource.getTotalQuantity());
            stmt.setInt(6, resource.getTotalQuantity()); // Upon creation, available qty is total qty
            stmt.setString(7, resource.getCondition());
            stmt.setBigDecimal(8, resource.getDepositRequired());
            stmt.setString(9, resource.getImageUrl());
            // Nota: Menyimpan Map sebagai String. Penggunaan JSON library lebih disyorkan untuk aplikasi sebenar.
            stmt.setString(10, specificationsToString(resource.getSpecifications()));
            stmt.setString(11, resource.getUsageInstructions());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating resource: " + e.getMessage());
            return false;
        }
    }


    public boolean updateResource(Resource resource) {
        String sql = "UPDATE resource SET resourceName=?, category=?, description=?, location=?, totalQuantity=?, availableQuantity=?, `condition`=?, depositRequired=?, imageUrl=?, specifications=?, usageInstructions=?, availability=?, updatedAt=NOW() WHERE resourceID=?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, resource.getResourceName());
            stmt.setString(2, resource.getCategory());
            stmt.setString(3, resource.getDescription());
            stmt.setString(4, resource.getLocation());
            stmt.setInt(5, resource.getTotalQuantity());
            stmt.setInt(6, resource.getAvailableQuantity());
            stmt.setString(7, resource.getCondition());
            stmt.setBigDecimal(8, resource.getDepositRequired());
            stmt.setString(9, resource.getImageUrl());
            stmt.setString(10, specificationsToString(resource.getSpecifications()));
            stmt.setString(11, resource.getUsageInstructions());
            stmt.setString(12, resource.getAvailability());
            stmt.setInt(13, resource.getResourceID());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating resource: " + e.getMessage());
            return false;
        }
    }

    /**
     * Memadam satu rekod resource berdasarkan ID.
     * @param resourceId ID untuk resource yang hendak dipadam.
     * @return true jika berjaya, false jika gagal.
     */
    public boolean deleteResource(int resourceId) {
        String sql = "DELETE FROM resource WHERE resourceID = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, resourceId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting resource: " + e.getMessage());
            return false;
        }
    }

    // --- Kaedah-kaedah Sedia Ada (Untuk Paparan) ---

    public Resource getResourceById(int resourceID) {
        String sql = "SELECT * FROM resource WHERE resourceID = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, resourceID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractResourceFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Resource> getAllResources() {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT * FROM resource ORDER BY resourceName";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resources;
    }

    private String specificationsToString(Map<String, Object> specs) {
        if (specs == null || specs.isEmpty()) {
            return null;
        }
        List<String> entries = new ArrayList<>();
        for (Map.Entry<String, Object> entry : specs.entrySet()) {
            entries.add(entry.getKey() + ":" + entry.getValue());
        }
        return String.join(",", entries);
    }
    
    // Kaedah pembantu untuk menukar String ke Map
    private Map<String, Object> stringToSpecifications(String specStr) {
        Map<String, Object> specs = new HashMap<>();
        if (specStr != null && !specStr.isEmpty()) {
            String[] pairs = specStr.split(",");
            for (String pair : pairs) {
                String[] keyValue = pair.split(":", 2);
                if (keyValue.length == 2) {
                    specs.put(keyValue[0].trim(), keyValue[1].trim());
                }
            }
        }
        return specs;
    }
    

    
    public List<Resource> getAvailableResources() {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT * FROM resource WHERE availability = 'available' AND availableQuantity > 0 ORDER BY resourceName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting available resources: " + e.getMessage());
        }
        return resources;
    }
    

    
    public List<Resource> getResourcesByCategory(String category) {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT * FROM resource WHERE category = ? ORDER BY resourceName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting resources by category: " + e.getMessage());
        }
        return resources;
    }
    
    public List<Resource> getResourcesByLocation(String location) {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT * FROM resource WHERE location = ? ORDER BY resourceName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, location);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting resources by location: " + e.getMessage());
        }
        return resources;
    }
    
    public List<Resource> searchResources(String searchTerm) {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT * FROM resource WHERE resourceName LIKE ? OR description LIKE ? OR category LIKE ? " +
                    "ORDER BY resourceName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching resources: " + e.getMessage());
        }
        return resources;
    }
    
    public List<Resource> getResourcesWithFilters(String category, String availability, String location, String sort) {
        List<Resource> resources = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM resource WHERE 1=1");
        List<Object> parameters = new ArrayList<>();
        
        if (category != null && !category.isEmpty() && !category.equals("all")) {
            sql.append(" AND category = ?");
            parameters.add(category);
        }
        
        if (availability != null && !availability.isEmpty()) {
            sql.append(" AND availability = ?");
            parameters.add(availability);
        }
        
        if (location != null && !location.isEmpty()) {
            sql.append(" AND location = ?");
            parameters.add(location);
        }
        
        // Add sorting
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "name":
                    sql.append(" ORDER BY resourceName");
                    break;
                case "category":
                    sql.append(" ORDER BY category, resourceName");
                    break;
                case "availability":
                    sql.append(" ORDER BY availability, resourceName");
                    break;
                case "popular":
                    sql.append(" ORDER BY (totalQuantity - availableQuantity) DESC, resourceName");
                    break;
                default:
                    sql.append(" ORDER BY resourceName");
                    break;
            }
        } else {
            sql.append(" ORDER BY resourceName");
        }
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                resources.add(extractResourceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting resources with filters: " + e.getMessage());
        }
        return resources;
    }
    
    public boolean updateAvailableQuantity(int resourceID, int newQuantity) {
        String sql = "UPDATE resource SET availableQuantity = ?, updatedAt = CURRENT_TIMESTAMP WHERE resourceID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, resourceID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating available quantity: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateResourceAvailability(int resourceID, String availability) {
        String sql = "UPDATE resource SET availability = ?, updatedAt = CURRENT_TIMESTAMP WHERE resourceID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, availability);
            stmt.setInt(2, resourceID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating resource availability: " + e.getMessage());
            return false;
        }
    }
    
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM resource ORDER BY category";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting categories: " + e.getMessage());
        }
        return categories;
    }
    
    public List<String> getAllLocations() {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT DISTINCT location FROM resource ORDER BY location";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                locations.add(rs.getString("location"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting locations: " + e.getMessage());
        }
        return locations;
    }
    
    public int getTotalResources() {
        String sql = "SELECT COUNT(*) FROM resource";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total resources: " + e.getMessage());
        }
        return 0;
    }
    
    public int getAvailableResourcesCount() {
        String sql = "SELECT COUNT(*) FROM resource WHERE availability = 'available' AND availableQuantity > 0";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting available resources count: " + e.getMessage());
        }
        return 0;
    }
    
    public int getResourceCountByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM resource WHERE category = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting resource count by category: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean hasAvailableQuantity(int resourceID, int requestedQuantity) {
        String sql = "SELECT availableQuantity FROM resource WHERE resourceID = ? AND availability = 'available'";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resourceID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("availableQuantity") >= requestedQuantity;
            }
        } catch (SQLException e) {
            System.err.println("Error checking available quantity: " + e.getMessage());
        }
        return false;
    }
    
    private Resource extractResourceFromResultSet(ResultSet rs) throws SQLException {
        Resource resource = new Resource();
        resource.setResourceID(rs.getInt("resourceID"));
        resource.setResourceName(rs.getString("resourceName"));
        resource.setCategory(rs.getString("category"));
        resource.setDescription(rs.getString("description"));
        resource.setLocation(rs.getString("location"));
        resource.setTotalQuantity(rs.getInt("totalQuantity"));
        resource.setAvailableQuantity(rs.getInt("availableQuantity"));
        resource.setCondition(rs.getString("condition"));
        resource.setDepositRequired(rs.getBigDecimal("depositRequired"));
        resource.setImageUrl(rs.getString("imageUrl"));
        
        // Parse specifications from JSON string (simple approach)
        String specificationsJson = rs.getString("specifications");
        Map<String, Object> specifications = new HashMap<>();
        if (specificationsJson != null && !specificationsJson.isEmpty()) {
            // Simple JSON parsing for basic key-value pairs
            // This is a basic implementation, in production you might want to use a proper JSON library
            try {
                specificationsJson = specificationsJson.replace("{", "").replace("}", "").replace("\"", "");
                if (!specificationsJson.trim().isEmpty()) {
                    String[] pairs = specificationsJson.split(",");
                    for (String pair : pairs) {
                        String[] keyValue = pair.split(":");
                        if (keyValue.length == 2) {
                            specifications.put(keyValue[0].trim(), keyValue[1].trim());
                        }
                    }
                }
            } catch (Exception e) {
                // If JSON parsing fails, ignore and continue
                System.err.println("Error parsing specifications JSON: " + e.getMessage());
            }
        }
        resource.setSpecifications(specifications);
        
        resource.setUsageInstructions(rs.getString("usageInstructions"));
        resource.setAvailability(rs.getString("availability"));
        resource.setCreatedAt(rs.getTimestamp("createdAt"));
        resource.setUpdatedAt(rs.getTimestamp("updatedAt"));
        return resource;
    }
    
}