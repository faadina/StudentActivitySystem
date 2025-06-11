package com.activity.controller;

import com.activity.util.DBConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/AprofileController")
public class AprofileController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("user_id"));
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("currentRole");

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps;

            if ("student".equals(role)) {
                String sql = "INSERT INTO student (user_id, matrix_no, program, faculty) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setString(2, request.getParameter("matrix_no"));
                ps.setString(3, request.getParameter("program"));
                ps.setString(4, request.getParameter("faculty"));

            } else if ("staff".equals(role)) {
                String sql = "INSERT INTO staff (user_id, staffRole, department) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setString(2, request.getParameter("staff_role"));
                ps.setString(3, request.getParameter("department"));

            } else if ("admin".equals(role)) {
                String sql = "INSERT INTO admin (user_id, staff_no) VALUES (?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setString(2, request.getParameter("staff_no"));

            } else if ("organization".equals(role)) {
                String sql = "INSERT INTO organization (user_ID, orgName, advisorName) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setString(2, request.getParameter("org_name"));
                ps.setString(3, request.getParameter("advisor_name"));
            } else {
                response.sendRedirect("error.jsp");
                return;
            }

            ps.executeUpdate();
            response.sendRedirect("dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
