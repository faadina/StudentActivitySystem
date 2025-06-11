package com.activity.DAO;

import com.activity.model.Resource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResourceDAO {

    String jdbcURL = "jdbc:mysql://localhost:3306/student_activity_db";
    String jdbcUsername = "root";
    String jdbcPassword = "";

    public boolean insertResourceBooking(Resource resource) {
        String sql = "INSERT INTO resource_bookings (date, duration, time, resource_name, quantity, status) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, resource.getDate());
            stmt.setString(2, resource.getDuration());
            stmt.setString(3, resource.getTime());
            stmt.setString(4, resource.getResourceName());
            stmt.setInt(5, resource.getQuantity());
            stmt.setString(6, "Pending"); // default status

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Resource> getAllBookings() {
        List<Resource> bookings = new ArrayList<>();
        String sql = "SELECT * FROM resource_bookings ORDER BY date DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Resource r = new Resource();
                r.setId(rs.getInt("id"));
                r.setDate(rs.getString("date"));
                r.setDuration(rs.getString("duration"));
                r.setTime(rs.getString("time"));
                r.setResourceName(rs.getString("resource_name"));
                r.setQuantity(rs.getInt("quantity"));
                r.setStatus(rs.getString("status"));
                bookings.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public void updateBookingStatus(int id, String status) {
        String sql = "UPDATE resource_bookings SET status = ? WHERE id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Get one booking by ID (for edit page)
    public Resource getBookingById(int id) {
        Resource res = new Resource();
        String sql = "SELECT * FROM resource_bookings WHERE id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                res.setId(rs.getInt("id"));
                res.setDate(rs.getString("date"));
                res.setDuration(rs.getString("duration"));
                res.setTime(rs.getString("time"));
                res.setResourceName(rs.getString("resource_name"));
                res.setQuantity(rs.getInt("quantity"));
                res.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return res;
    }

    // ✅ Update booking fields (date, time, resource, etc.)
    public void updateBooking(Resource res) {
        String sql = "UPDATE resource_bookings SET date = ?, duration = ?, time = ?, resource_name = ?, quantity = ? WHERE id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, res.getDate());
            stmt.setString(2, res.getDuration());
            stmt.setString(3, res.getTime());
            stmt.setString(4, res.getResourceName());
            stmt.setInt(5, res.getQuantity());
            stmt.setInt(6, res.getId());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
