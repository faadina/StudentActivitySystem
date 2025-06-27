package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

public class VenueBooking {
    private int bookingID;
    private int venueID;
    private String userID;
    private String eventType;
    private Date bookingDate;
    private Time startTime;
    private Time endTime;
    private String purpose;
    private int expectedAttendees;
    private List<String> facilitiesRequired;
    private String status;
    private BigDecimal totalAmount;
    private String approvedBy;
    private Timestamp approvedAt;
    private String rejectionReason;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // For joined queries
    private String venueName;
    private String building;
    private String userName;

    // Default constructor
    public VenueBooking() {}

    // Constructor for creating new booking
    public VenueBooking(int venueID, String userID, String eventType, Date bookingDate,
                       Time startTime, Time endTime, String purpose, int expectedAttendees,
                       List<String> facilitiesRequired, BigDecimal totalAmount) {
        this.venueID = venueID;
        this.userID = userID;
        this.eventType = eventType;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.purpose = purpose;
        this.expectedAttendees = expectedAttendees;
        this.facilitiesRequired = facilitiesRequired;
        this.totalAmount = totalAmount;
        this.status = "pending";
    }

    // Getters and Setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getVenueID() {
        return venueID;
    }

    public void setVenueID(int venueID) {
        this.venueID = venueID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public int getExpectedAttendees() {
        return expectedAttendees;
    }

    public void setExpectedAttendees(int expectedAttendees) {
        this.expectedAttendees = expectedAttendees;
    }

    public List<String> getFacilitiesRequired() {
        return facilitiesRequired;
    }

    public void setFacilitiesRequired(List<String> facilitiesRequired) {
        this.facilitiesRequired = facilitiesRequired;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public Timestamp getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(Timestamp approvedAt) {
        this.approvedAt = approvedAt;
    }

    public String getRejectionReason() {
        return rejectionReason;
    }

    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Joined query fields
    public String getVenueName() {
        return venueName;
    }

    public void setVenueName(String venueName) {
        this.venueName = venueName;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Helper methods
    public boolean isPending() {
        return "pending".equals(status);
    }

    public boolean isConfirmed() {
        return "confirmed".equals(status);
    }

    public boolean isCancelled() {
        return "cancelled".equals(status);
    }

    public boolean isCompleted() {
        return "completed".equals(status);
    }

    public long getDurationInHours() {
        if (startTime == null || endTime == null) return 0;
        
        long startMillis = startTime.getTime();
        long endMillis = endTime.getTime();
        
        // Handle case where end time is next day
        if (endMillis < startMillis) {
            endMillis += 24 * 60 * 60 * 1000; // Add 24 hours
        }
        
        return (endMillis - startMillis) / (60 * 60 * 1000);
    }

    public boolean isUpcoming() {
        Date today = new Date(System.currentTimeMillis());
        return bookingDate.after(today) || bookingDate.equals(today);
    }

    @Override
    public String toString() {
        return "VenueBooking{" +
                "bookingID=" + bookingID +
                ", venueID=" + venueID +
                ", eventType='" + eventType + '\'' +
                ", bookingDate=" + bookingDate +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", status='" + status + '\'' +
                '}';
    }
}