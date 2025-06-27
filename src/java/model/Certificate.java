package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Certificate {
    private String certificateId;
    private String userID;
    private String eventID;
    private String eventTitle;
    private String eventCategory;
    private String organizer;
    private Date eventDate;
    private Date issueDate;
    private int duration; // in hours
    private String certificateUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Certificate() {}

    // Constructor for creating new certificate
    public Certificate(String userID, String eventID, String eventTitle, 
                      String eventCategory, String organizer) {
        this.userID = userID;
        this.eventID = eventID;
        this.eventTitle = eventTitle;
        this.eventCategory = eventCategory;
        this.organizer = organizer;
        this.issueDate = new Date(System.currentTimeMillis());
        this.certificateId = generateCertificateId();
    }

    // Full constructor
    public Certificate(String certificateId, String userID, String eventID, 
                      String eventTitle, String eventCategory, String organizer,
                      Date eventDate, Date issueDate, int duration, String certificateUrl) {
        this.certificateId = certificateId;
        this.userID = userID;
        this.eventID = eventID;
        this.eventTitle = eventTitle;
        this.eventCategory = eventCategory;
        this.organizer = organizer;
        this.eventDate = eventDate;
        this.issueDate = issueDate;
        this.duration = duration;
        this.certificateUrl = certificateUrl;
    }

    // Getters and Setters
    public String getCertificateId() {
        return certificateId;
    }

    public void setCertificateId(String certificateId) {
        this.certificateId = certificateId;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getEventCategory() {
        return eventCategory;
    }

    public void setEventCategory(String eventCategory) {
        this.eventCategory = eventCategory;
    }

    public String getOrganizer() {
        return organizer;
    }

    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }

    public Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getCertificateUrl() {
        return certificateUrl;
    }

    public void setCertificateUrl(String certificateUrl) {
        this.certificateUrl = certificateUrl;
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

    // Helper methods
    private String generateCertificateId() {
        // Generate unique certificate ID (CERT + timestamp + random)
        long timestamp = System.currentTimeMillis();
        int random = (int) (Math.random() * 1000);
        return "CERT" + timestamp + String.format("%03d", random);
    }

    public boolean isValid() {
        return certificateId != null && userID != null && eventID != null && 
               eventTitle != null && issueDate != null;
    }

    public String getFormattedIssueDate() {
        if (issueDate != null) {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
            return sdf.format(issueDate);
        }
        return "";
    }

    public String getFormattedEventDate() {
        if (eventDate != null) {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
            return sdf.format(eventDate);
        }
        return "";
    }

    public String getCategoryDisplayName() {
        if (eventCategory == null) return "";
        
        switch (eventCategory.toLowerCase()) {
            case "academic":
                return "Academic Achievement";
            case "sports":
                return "Sports Excellence";
            case "cultural":
                return "Cultural Participation";
            case "leadership":
                return "Leadership Development";
            case "community":
                return "Community Service";
            default:
                return "Participation";
        }
    }

    @Override
    public String toString() {
        return "Certificate{" +
                "certificateId='" + certificateId + '\'' +
                ", userID='" + userID + '\'' +
                ", eventTitle='" + eventTitle + '\'' +
                ", eventCategory='" + eventCategory + '\'' +
                ", issueDate=" + issueDate +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Certificate that = (Certificate) obj;
        return certificateId != null ? certificateId.equals(that.certificateId) : that.certificateId == null;
    }

    @Override
    public int hashCode() {
        return certificateId != null ? certificateId.hashCode() : 0;
    }
}