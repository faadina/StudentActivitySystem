package model;

import java.sql.Timestamp;

public class Feedback {
    private int feedbackID;
    private String eventID;
    private String userID;
    private int overallRating;
    private int organizationRating;
    private int contentRating;
    private int venueRating;
    private String comment;
    private String suggestions;
    private boolean wouldRecommend;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // For joined queries
    private String eventTitle;
    private String userName;
    private String userEmail;

    // Default constructor
    public Feedback() {}

    // Constructor for basic feedback
    public Feedback(String eventID, String userID, int overallRating, String comment) {
        this.eventID = eventID;
        this.userID = userID;
        this.overallRating = overallRating;
        this.comment = comment;
        this.wouldRecommend = overallRating >= 4; // Auto-set based on rating
    }

    // Constructor with detailed ratings
    public Feedback(String eventID, String userID, int overallRating, 
                   int organizationRating, int contentRating, int venueRating,
                   String comment, String suggestions, boolean wouldRecommend) {
        this.eventID = eventID;
        this.userID = userID;
        this.overallRating = overallRating;
        this.organizationRating = organizationRating;
        this.contentRating = contentRating;
        this.venueRating = venueRating;
        this.comment = comment;
        this.suggestions = suggestions;
        this.wouldRecommend = wouldRecommend;
    }

    // Getters and Setters
    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
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

    public int getOverallRating() {
        return overallRating;
    }

    public void setOverallRating(int overallRating) {
        this.overallRating = overallRating;
    }

    public int getOrganizationRating() {
        return organizationRating;
    }

    public void setOrganizationRating(int organizationRating) {
        this.organizationRating = organizationRating;
    }

    public int getContentRating() {
        return contentRating;
    }

    public void setContentRating(int contentRating) {
        this.contentRating = contentRating;
    }

    public int getVenueRating() {
        return venueRating;
    }

    public void setVenueRating(int venueRating) {
        this.venueRating = venueRating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(String suggestions) {
        this.suggestions = suggestions;
    }

    public boolean isWouldRecommend() {
        return wouldRecommend;
    }

    public void setWouldRecommend(boolean wouldRecommend) {
        this.wouldRecommend = wouldRecommend;
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
    public boolean isPositiveFeedback() {
        return overallRating >= 4;
    }

    public boolean isNegativeFeedback() {
        return overallRating <= 2;
    }

    public boolean isNeutralFeedback() {
        return overallRating == 3;
    }

    public String getRatingDescription() {
        switch (overallRating) {
            case 1:
                return "Poor";
            case 2:
                return "Fair";
            case 3:
                return "Good";
            case 4:
                return "Great";
            case 5:
                return "Excellent";
            default:
                return "Not Rated";
        }
    }

    public String getRatingEmoji() {
        switch (overallRating) {
            case 1:
                return "😞";
            case 2:
                return "😕";
            case 3:
                return "😐";
            case 4:
                return "😊";
            case 5:
                return "😍";
            default:
                return "❓";
        }
    }

    public double getAverageRating() {
        int ratingCount = 0;
        int totalRating = 0;

        if (overallRating > 0) {
            totalRating += overallRating;
            ratingCount++;
        }
        if (organizationRating > 0) {
            totalRating += organizationRating;
            ratingCount++;
        }
        if (contentRating > 0) {
            totalRating += contentRating;
            ratingCount++;
        }
        if (venueRating > 0) {
            totalRating += venueRating;
            ratingCount++;
        }

        return ratingCount > 0 ? (double) totalRating / ratingCount : 0.0;
    }

    public boolean hasComment() {
        return comment != null && !comment.trim().isEmpty();
    }

    public boolean hasSuggestions() {
        return suggestions != null && !suggestions.trim().isEmpty();
    }

    public boolean isComplete() {
        return overallRating > 0 && hasComment();
    }

    public String getFormattedCreatedDate() {
        if (createdAt != null) {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
            return sdf.format(createdAt);
        }
        return "";
    }

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackID=" + feedbackID +
                ", eventID='" + eventID + '\'' +
                ", userID='" + userID + '\'' +
                ", overallRating=" + overallRating +
                ", wouldRecommend=" + wouldRecommend +
                ", createdAt=" + createdAt +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Feedback feedback = (Feedback) obj;
        return feedbackID == feedback.feedbackID;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(feedbackID);
    }
}