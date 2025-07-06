package dao;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    public User getUserById(String userID) {
        String sql = "SELECT * FROM user WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
        }
        return null;
    }
    
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM user WHERE userEmail = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
        }
        return null;
    }
    
    public User authenticateUser(String email, String password) {
        String sql = "SELECT * FROM user WHERE userEmail = ? AND password = ? AND userStatus = 'active'";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateUser(User user) {
        String sql = "UPDATE user SET userName = ?, userPhoneNo = ?, updated_at = CURRENT_TIMESTAMP WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getUserPhoneNo());
            stmt.setString(3, user.getUserID());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePassword(String userID, String newPassword) {
        String sql = "UPDATE user SET password = ?, updated_at = CURRENT_TIMESTAMP WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPassword);
            stmt.setString(2, userID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            return false;
        }
    }
    
    public boolean createUser(User user) {
        String sql = "INSERT INTO user (userID, userName, userEmail, userPhoneNo, password, userRole, userStatus) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getUserName());
            stmt.setString(3, user.getUserEmail());
            stmt.setString(4, user.getUserPhoneNo());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getUserRole());
            stmt.setString(7, user.getUserStatus());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            return false;
        }
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
        }
        return users;
    }
    
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE userRole = ? ORDER BY userName";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting users by role: " + e.getMessage());
        }
        return users;
    }
    
    public boolean deleteUser(String userID) {
        String sql = "DELETE FROM user WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateUserStatus(String userID, String status) {
        String sql = "UPDATE user SET userStatus = ?, updated_at = CURRENT_TIMESTAMP WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, userID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user status: " + e.getMessage());
            return false;
        }
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM user WHERE userEmail = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }
    
    public boolean userIdExists(String userID) {
        String sql = "SELECT COUNT(*) FROM user WHERE userID = ?";
        
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking user ID existence: " + e.getMessage());
        }
        return false;
    }
    
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getString("userID"));
        user.setUserName(rs.getString("userName"));
        user.setUserEmail(rs.getString("userEmail"));
        user.setUserPhoneNo(rs.getString("userPhoneNo"));
        user.setPassword(rs.getString("password"));
        user.setUserRole(rs.getString("userRole"));
        user.setUserStatus(rs.getString("userStatus"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
    
    
    public String generateNextUserID(String role) {
    String prefix = "";
    switch (role.toLowerCase()) {
        case "staff":
            prefix = "ST";
            break;
        case "organization":
            prefix = "O";
            break;
        case "student":      
            prefix = "STU"; 
            break; 
        default:
            return null; // Atau baling ralat
    }

    // SQL untuk mencari nombor maksimum bagi awalan (prefix) tertentu
     String sql = "SELECT MAX(CAST(SUBSTRING(userID,"+(prefix.length()+1)+") AS UNSIGNED)) "
               + "FROM user WHERE userID LIKE '"+prefix+"%'";
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        
        if (rs.next()) {
            int maxNumber = rs.getInt(1);
            // Format ID baharu, contoh: ST001, O001
            return String.format("%s%03d", prefix, maxNumber + 1);
        } else {
            // Jika tiada rekod, mulakan dengan 1
            return String.format("%s%03d", prefix, 1);
        }
    } catch (SQLException e) {
        System.err.println("Error generating next User ID: " + e.getMessage());
        return null; // Pulangkan null jika ralat
    }
}
    
    public int getTotalOrganizations() {
    String sql = "SELECT COUNT(*) FROM user WHERE userRole = 'organization' AND userStatus = 'active'";
    
    try (Connection conn = DatabaseConnection.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.err.println("Error getting total organizations: " + e.getMessage());
        e.printStackTrace();
    }
    return 0;
}
    
}