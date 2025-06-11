package com.activity.dao;

import com.activity.model.Event;
import com.activity.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    public int getJoinedEventCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM registrations WHERE student_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getCertificateCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM certificates WHERE student_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getPendingFeedbackCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM registrations r " +
                     "LEFT JOIN feedback f ON r.event_id = f.event_id AND r.student_id = f.student_id " +
                     "WHERE r.student_id=? AND f.feedback_id IS NULL";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Event> getUpcomingEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT event_id, title, date, venue_id FROM events WHERE date >= CURRENT_DATE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setTitle(rs.getString("title"));
                e.setDate(rs.getDate("date").toString());
                e.setVenue("Venue " + rs.getInt("venue_id")); // You can improve by joining venue name
                events.add(e);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return events;
    }
}
