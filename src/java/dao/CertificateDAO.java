package dao;

import model.Certificate;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CertificateDAO {
    
    public boolean createCertificate(Certificate certificate) {
        String sql = "INSERT INTO certificate (certificateId, userID, eventID, eventTitle, " +
                    "eventCategory, organizer, eventDate, issueDate, duration, certificateUrl) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, certificate.getCertificateId());
            stmt.setString(2, certificate.getUserID());
            stmt.setString(3, certificate.getEventID());
            stmt.setString(4, certificate.getEventTitle());
            stmt.setString(5, certificate.getEventCategory());
            stmt.setString(6, certificate.getOrganizer());
            stmt.setDate(7, certificate.getEventDate());
            stmt.setDate(8, certificate.getIssueDate());
            stmt.setInt(9, certificate.getDuration());
            stmt.setString(10, certificate.getCertificateUrl());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating certificate: " + e.getMessage());
            return false;
        }
    }
    
    public Certificate getCertificateById(String certificateId) {
        String sql = "SELECT * FROM certificate WHERE certificateId = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, certificateId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCertificateFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificate by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Certificate getCertificateByUserAndEvent(String userID, String eventID) {
        String sql = "SELECT * FROM certificate WHERE userID = ? AND eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            stmt.setString(2, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCertificateFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificate by user and event: " + e.getMessage());
        }
        return null;
    }
    
    public List<Certificate> getCertificatesByUser(String userID) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT * FROM certificate WHERE userID = ? ORDER BY issueDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                certificates.add(extractCertificateFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificates by user: " + e.getMessage());
        }
        return certificates;
    }
    
    public List<Certificate> getCertificatesByEvent(String eventID) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT c.*, u.userName, u.userEmail FROM certificate c " +
                    "JOIN user u ON c.userID = u.userID " +
                    "WHERE c.eventID = ? ORDER BY c.issueDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Certificate certificate = extractCertificateFromResultSet(rs);
                // Add user information from joined query
                // certificate.setUserName(rs.getString("userName"));
                // certificate.setUserEmail(rs.getString("userEmail"));
                certificates.add(certificate);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificates by event: " + e.getMessage());
        }
        return certificates;
    }
    
    public List<Certificate> getCertificatesByCategory(String category) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT * FROM certificate WHERE eventCategory = ? ORDER BY issueDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                certificates.add(extractCertificateFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificates by category: " + e.getMessage());
        }
        return certificates;
    }
    
    public List<Certificate> getCertificatesByDateRange(Date startDate, Date endDate) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT * FROM certificate WHERE issueDate BETWEEN ? AND ? " +
                    "ORDER BY issueDate DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                certificates.add(extractCertificateFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificates by date range: " + e.getMessage());
        }
        return certificates;
    }
    
    public boolean updateCertificateUrl(String certificateId, String certificateUrl) {
        String sql = "UPDATE certificate SET certificateUrl = ?, updatedAt = CURRENT_TIMESTAMP " +
                    "WHERE certificateId = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, certificateUrl);
            stmt.setString(2, certificateId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating certificate URL: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteCertificate(String certificateId) {
        String sql = "DELETE FROM certificate WHERE certificateId = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, certificateId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting certificate: " + e.getMessage());
            return false;
        }
    }
    
    public int getCertificateCountByUser(String userID) {
        String sql = "SELECT COUNT(*) FROM certificate WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificate count by user: " + e.getMessage());
        }
        return 0;
    }
    
    public int getCertificateCountByEvent(String eventID) {
        String sql = "SELECT COUNT(*) FROM certificate WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificate count by event: " + e.getMessage());
        }
        return 0;
    }
    
    public int getCertificateCountByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM certificate WHERE eventCategory = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting certificate count by category: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean certificateExists(String userID, String eventID) {
        String sql = "SELECT COUNT(*) FROM certificate WHERE userID = ? AND eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            stmt.setString(2, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking certificate existence: " + e.getMessage());
        }
        return false;
    }
    
    public List<Certificate> getRecentCertificates(int limit) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT c.*, u.userName FROM certificate c " +
                    "JOIN user u ON c.userID = u.userID " +
                    "ORDER BY c.issueDate DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Certificate certificate = extractCertificateFromResultSet(rs);
                certificates.add(certificate);
            }
        } catch (SQLException e) {
            System.err.println("Error getting recent certificates: " + e.getMessage());
        }
        return certificates;
    }
    
    public String generateNextCertificateId() {
        String sql = "SELECT MAX(CAST(SUBSTRING(certificateId, 5) AS UNSIGNED)) FROM certificate " +
                    "WHERE certificateId LIKE 'CERT%' AND LENGTH(certificateId) = 8";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                int maxNumber = rs.getInt(1);
                return String.format("CERT%04d", maxNumber + 1);
            } else {
                return "CERT0001";
            }
        } catch (SQLException e) {
            System.err.println("Error generating certificate ID: " + e.getMessage());
            // Return a time-based ID as fallback
            return "CERT" + System.currentTimeMillis();
        }
    }
    
    private Certificate extractCertificateFromResultSet(ResultSet rs) throws SQLException {
        Certificate certificate = new Certificate();
        certificate.setCertificateId(rs.getString("certificateId"));
        certificate.setUserID(rs.getString("userID"));
        certificate.setEventID(rs.getString("eventID"));
        certificate.setEventTitle(rs.getString("eventTitle"));
        certificate.setEventCategory(rs.getString("eventCategory"));
        certificate.setOrganizer(rs.getString("organizer"));
        certificate.setEventDate(rs.getDate("eventDate"));
        certificate.setIssueDate(rs.getDate("issueDate"));
        certificate.setDuration(rs.getInt("duration"));
        certificate.setCertificateUrl(rs.getString("certificateUrl"));
        certificate.setCreatedAt(rs.getTimestamp("createdAt"));
        certificate.setUpdatedAt(rs.getTimestamp("updatedAt"));
        return certificate;
    }
}