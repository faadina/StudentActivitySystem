package dao;

import model.Feedback;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class FeedbackDAO {
    
    public boolean createFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (eventID, userID, overallRating, organizationRating, " +
                    "contentRating, venueRating, comment, suggestions, wouldRecommend) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, feedback.getEventID());
            stmt.setString(2, feedback.getUserID());
            stmt.setInt(3, feedback.getOverallRating());
            stmt.setInt(4, feedback.getOrganizationRating());
            stmt.setInt(5, feedback.getContentRating());
            stmt.setInt(6, feedback.getVenueRating());
            stmt.setString(7, feedback.getComment());
            stmt.setString(8, feedback.getSuggestions());
            stmt.setBoolean(9, feedback.isWouldRecommend());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating feedback: " + e.getMessage());
            return false;
        }
    }
    
    public Feedback getFeedbackById(int feedbackID) {
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.feedbackID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedbackID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractFeedbackFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedback by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Feedback getFeedbackByUserAndEvent(String userID, String eventID) {
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.userID = ? AND f.eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            stmt.setString(2, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractFeedbackFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedback by user and event: " + e.getMessage());
        }
        return null;
    }
    
    public List<Feedback> getFeedbacksByUser(String userID) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.userID = ? ORDER BY f.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedbacks by user: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public List<Feedback> getFeedbacksByEvent(String eventID) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.eventID = ? ORDER BY f.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedbacks by event: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public List<Feedback> getFeedbacksByOrganization(String organizationID) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE e.organizationID = ? ORDER BY f.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedbacks by organization: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public List<Feedback> getFeedbacksByRating(int minRating, int maxRating) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.overallRating BETWEEN ? AND ? ORDER BY f.createdAt DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, minRating);
            stmt.setInt(2, maxRating);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedbacks by rating: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE feedback SET overallRating = ?, organizationRating = ?, " +
                    "contentRating = ?, venueRating = ?, comment = ?, suggestions = ?, " +
                    "wouldRecommend = ?, updatedAt = CURRENT_TIMESTAMP WHERE feedbackID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedback.getOverallRating());
            stmt.setInt(2, feedback.getOrganizationRating());
            stmt.setInt(3, feedback.getContentRating());
            stmt.setInt(4, feedback.getVenueRating());
            stmt.setString(5, feedback.getComment());
            stmt.setString(6, feedback.getSuggestions());
            stmt.setBoolean(7, feedback.isWouldRecommend());
            stmt.setInt(8, feedback.getFeedbackID());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating feedback: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteFeedback(int feedbackID) {
        String sql = "DELETE FROM feedback WHERE feedbackID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedbackID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting feedback: " + e.getMessage());
            return false;
        }
    }
    
    public int getFeedbackCountByUser(String userID) {
        String sql = "SELECT COUNT(*) FROM feedback WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedback count by user: " + e.getMessage());
        }
        return 0;
    }
    
    public int getFeedbackCountByEvent(String eventID) {
        String sql = "SELECT COUNT(*) FROM feedback WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting feedback count by event: " + e.getMessage());
        }
        return 0;
    }
    
    public double getAverageRatingByEvent(String eventID) {
        String sql = "SELECT AVG(overallRating) FROM feedback WHERE eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting average rating by event: " + e.getMessage());
        }
        return 0.0;
    }
    
    public double getAverageRatingByOrganization(String organizationID) {
        String sql = "SELECT AVG(f.overallRating) FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "WHERE e.organizationID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, organizationID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting average rating by organization: " + e.getMessage());
        }
        return 0.0;
    }
    
    public Map<Integer, Integer> getRatingDistributionByEvent(String eventID) {
        Map<Integer, Integer> distribution = new HashMap<>();
        String sql = "SELECT overallRating, COUNT(*) as count FROM feedback " +
                    "WHERE eventID = ? GROUP BY overallRating ORDER BY overallRating";
        
        // Initialize all ratings to 0
        for (int i = 1; i <= 5; i++) {
            distribution.put(i, 0);
        }
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, eventID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                distribution.put(rs.getInt("overallRating"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting rating distribution: " + e.getMessage());
        }
        return distribution;
    }
    
    public List<Feedback> getRecentFeedbacks(int limit) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "ORDER BY f.createdAt DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting recent feedbacks: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public List<Feedback> getPositiveFeedbacks(int limit) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, e.eventTitle, u.userName, u.userEmail " +
                    "FROM feedback f " +
                    "JOIN event e ON f.eventID = e.eventID " +
                    "JOIN user u ON f.userID = u.userID " +
                    "WHERE f.overallRating >= 4 ORDER BY f.overallRating DESC, f.createdAt DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                feedbacks.add(extractFeedbackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting positive feedbacks: " + e.getMessage());
        }
        return feedbacks;
    }
    
    public boolean feedbackExists(String userID, String eventID) {
        String sql = "SELECT COUNT(*) FROM feedback WHERE userID = ? AND eventID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            stmt.setString(2, eventID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking feedback existence: " + e.getMessage());
        }
        return false;
    }
    
    private Feedback extractFeedbackFromResultSet(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setFeedbackID(rs.getInt("feedbackID"));
        feedback.setEventID(rs.getString("eventID"));
        feedback.setUserID(rs.getString("userID"));
        feedback.setOverallRating(rs.getInt("overallRating"));
        feedback.setOrganizationRating(rs.getInt("organizationRating"));
        feedback.setContentRating(rs.getInt("contentRating"));
        feedback.setVenueRating(rs.getInt("venueRating"));
        feedback.setComment(rs.getString("comment"));
        feedback.setSuggestions(rs.getString("suggestions"));
        feedback.setWouldRecommend(rs.getBoolean("wouldRecommend"));
        feedback.setCreatedAt(rs.getTimestamp("createdAt"));
        feedback.setUpdatedAt(rs.getTimestamp("updatedAt"));
        
        // Joined fields
        feedback.setEventTitle(rs.getString("eventTitle"));
        feedback.setUserName(rs.getString("userName"));
        feedback.setUserEmail(rs.getString("userEmail"));
        
        return feedback;
    }
}