package com.activity.dao;

import com.activity.model.User;
import com.activity.util.DBConnection;

import java.sql.*;

public class UserDAO {
    public boolean register(User user) {
        boolean result = false;

        try (Connection conn = DBConnection.getConnection()) {
            String check = "SELECT * FROM user WHERE email = ?";
            PreparedStatement psCheck = conn.prepareStatement(check);
            psCheck.setString(1, user.getEmail());
            ResultSet rsCheck = psCheck.executeQuery();
            if (rsCheck.next()) return false;

            String insertUser = "INSERT INTO user (name, email, phone_no, password, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psUser = conn.prepareStatement(insertUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getName());
            psUser.setString(2, user.getEmail());
            psUser.setString(3, user.getPhoneNo());
            psUser.setString(4, user.getPassword());
            psUser.setString(5, user.getRole());
            psUser.executeUpdate();

            ResultSet rsUser = psUser.getGeneratedKeys();
            int userId = 0;
            if (rsUser.next()) userId = rsUser.getInt(1);

            String role = user.getRole();
            PreparedStatement ps;

            if ("student".equals(role)) {
                ps = conn.prepareStatement("INSERT INTO student (user_id, matrix_no, program, faculty) VALUES (?, ?, ?, ?)");
                ps.setInt(1, userId);
                ps.setString(2, user.getMatrixNo());
                ps.setString(3, user.getProgram());
                ps.setString(4, user.getFaculty());
                ps.executeUpdate();

            } else if ("staff".equals(role)) {
                ps = conn.prepareStatement("INSERT INTO staff (user_id, staffRole, department) VALUES (?, ?, ?)");
                ps.setInt(1, userId);
                ps.setString(2, user.getStaffRole());
                ps.setString(3, user.getDepartment());
                ps.executeUpdate();

            } else if ("admin".equals(role)) {
                ps = conn.prepareStatement("INSERT INTO admin (user_id, staff_no) VALUES (?, ?)");
                ps.setInt(1, userId);
                ps.setString(2, user.getStaffNo());
                ps.executeUpdate();

            } else if ("organization".equals(role)) {
                ps = conn.prepareStatement("INSERT INTO organization (user_ID, orgName, advisorName) VALUES (?, ?, ?)");
                ps.setInt(1, userId);
                ps.setString(2, user.getName());
                ps.setString(3, user.getAdvisorName());
                ps.executeUpdate();
            }

            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public User login(String email, String password) {
        User user = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_ID"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNo(rs.getString("phone_no"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
