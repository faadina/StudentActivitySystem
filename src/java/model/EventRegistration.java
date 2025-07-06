package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class EventRegistration {
    private int registrationID;
    private String eventID;
    private String userID;
    private Timestamp registrationDate;
    private String status;
    private String paymentStatus;
    private BigDecimal paymentAmount;
    private String feedback;
    private int rating;
    private boolean certificateIssued;
    private Date eventDate;   
    private Time eventTime;  

    // For joined queries
    private String eventTitle;
    private String userName;
    private String userEmail;

    // Default constructor
    public EventRegistration() {}

    // Constructor for creating new registration
    public EventRegistration(String eventID, String userID, String status, 
                           String paymentStatus, BigDecimal paymentAmount) {
        this.eventID = eventID;
        this.userID = userID;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.paymentAmount = paymentAmount;
        this.certificateIssued = false;
    }

    // Getters and Setters
    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Timestamp getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Timestamp registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public BigDecimal getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(BigDecimal paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public boolean isCertificateIssued() {
        return certificateIssued;
    }

    public void setCertificateIssued(boolean certificateIssued) {
        this.certificateIssued = certificateIssued;
    }

    // Joined query fields
    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // Helper methods
    public boolean isRegistered() {
        return "registered".equals(status);
    }

    public boolean hasAttended() {
        return "attended".equals(status);
    }

    public boolean wasAbsent() {
        return "absent".equals(status);
    }

    public boolean isCancelled() {
        return "cancelled".equals(status);
    }

    public boolean isPaymentPending() {
        return "pending".equals(paymentStatus);
    }

    public boolean isPaymentComplete() {
        return "paid".equals(paymentStatus);
    }

    public boolean isRefunded() {
        return "refunded".equals(paymentStatus);
    }

    public boolean hasProvidedFeedback() {
        return feedback != null && !feedback.trim().isEmpty();
    }

    public boolean hasRated() {
        return rating > 0;
    }

    @Override
    public String toString() {
        return "EventRegistration{" +
                "registrationID=" + registrationID +
                ", eventID='" + eventID + '\'' +
                ", userID='" + userID + '\'' +
                ", status='" + status + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", certificateIssued=" + certificateIssued +
                '}';
    }
    
    public Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

    public Time getEventTime() {
        return eventTime;
    }

    public void setEventTime(Time eventTime) {
        this.eventTime = eventTime;
    }
}