package com.activity.util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDB {
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println(" Database connected successfully!");
                conn.close();
            } else {
                System.out.println(" Failed to connect to the database.");
            }
        } catch (SQLException e) {
            System.out.println(" SQL Error: " + e.getMessage());
        }
    }
}
