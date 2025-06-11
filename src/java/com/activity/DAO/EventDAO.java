package com.activity.DAO;

import com.activity.model.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    String jdbcURL = "jdbc:mysql://localhost:3306/student_activity_db";
    String jdbcUsername = "root";
    String jdbcPassword = "";

    public boolean insertEvent(Event event) {
        String sql = "INSERT INTO events (name, date, time, description, participants, category, fee, department, paperwork, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, event.getName());
            stmt.setString(2, event.getDate());
            stmt.setString(3, event.getTime());
            stmt.setString(4, event.getDescription());
            stmt.setInt(5, event.getParticipants());
            stmt.setString(6, event.getCategory());
            stmt.setDouble(7, event.getFee());
            stmt.setString(8, event.getDepartment());
            stmt.setString(9, event.getPaperworkFileName());
            stmt.setString(10, "Pending"); // default status

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY date DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Event e = new Event();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("name"));
                e.setDate(rs.getString("date"));
                e.setTime(rs.getString("time"));
                e.setDescription(rs.getString("description"));
                e.setParticipants(rs.getInt("participants"));
                e.setCategory(rs.getString("category"));
                e.setFee(rs.getDouble("fee"));
                e.setDepartment(rs.getString("department"));
                e.setPaperworkFileName(rs.getString("paperwork"));
                e.setStatus(rs.getString("status"));
                events.add(e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }
}
