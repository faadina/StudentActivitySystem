package com.activity.DAO;

import com.activity.model.Feedback;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    String jdbcURL = "jdbc:mysql://localhost:3306/student_activity_db";
    String jdbcUsername = "root";
    String jdbcPassword = "";

    public boolean insertFeedback(Feedback fb) {
        String sql = "INSERT INTO feedback (event_name, experience_rating, comment) VALUES (?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fb.getEventName());
            stmt.setString(2, fb.getExperienceRating());
            stmt.setString(3, fb.getComment());
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY id DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setEventName(rs.getString("event_name"));
                fb.setExperienceRating(rs.getString("experience_rating"));
                fb.setComment(rs.getString("comment"));
                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
