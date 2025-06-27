package dao;

import model.Event;
import model.EventRegistration;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventRegistrationDAO {

    public boolean addRegistration(EventRegistration registration) {
        String sql = "INSERT INTO event_registration (eventID, studentID, status, paymentStatus, paymentAmount, registered_at) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, registration.getEventID());
            stmt.setString(2, registration.getUserID());
            stmt.setString(3, "confirmed"); // Terus sahkan pendaftaran
            stmt.setString(4, "pending"); // Status bayaran adalah pending jika ada
            stmt.setBigDecimal(5, registration.getPaymentAmount());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isStudentRegistered(String studentID, String eventID) {
        String sql = "SELECT COUNT(*) FROM event_registration WHERE studentID = ? AND eventID = ? AND status != 'cancelled'";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentID);
            stmt.setString(2, eventID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<EventRegistration> getRegistrationsByStudent(String studentID) {
        List<EventRegistration> registrations = new ArrayList<>();
        // Query ini masih sama, ia mengambil maklumat tambahan dari jadual event
        String sql = "SELECT er.*, e.eventTitle, e.eventDate, e.eventLocation, e.eventCategory " +
                     "FROM event_registration er " +
                     "LEFT JOIN event e ON er.eventID = e.eventID " +
                     "WHERE er.studentID = ? ORDER BY e.eventDate DESC";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                EventRegistration reg = new EventRegistration();
                // Ambil data dari jadual 'event_registration'
                reg.setRegistrationID(rs.getInt("registrationID"));
                reg.setEventID(rs.getString("eventID"));
                reg.setUserID(rs.getString("studentID")); // Model anda menggunakan userID
                reg.setStatus(rs.getString("status"));
                reg.setRegistrationDate(rs.getTimestamp("registered_at"));
                reg.setPaymentStatus(rs.getString("paymentStatus"));

                // PEMBETULAN: Ambil data dari jadual 'event' dan set secara terus
                // ke dalam medan yang sedia ada di model EventRegistration.
                reg.setEventTitle(rs.getString("eventTitle"));
                // reg.setEventDate(...) // Anda perlu tambah 'private Date eventDate' jika mahu simpan ini
                // reg.setEventLocation(...) // Anda perlu tambah 'private String eventLocation' jika mahu simpan ini

                registrations.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public boolean cancelRegistration(String studentID, String eventID) {
        String sql = "UPDATE event_registration SET status = 'cancelled' WHERE studentID = ? AND eventID = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentID);
            stmt.setString(2, eventID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getCountByStatus(String studentID, String status) {
        String sql = "SELECT COUNT(*) FROM event_registration WHERE studentID = ? AND status = ?";
        try (Connection conn = DatabaseConnection.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentID);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}