package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Event {
    private String eventID;
    private String organizationID;
    private String eventTitle;
    private String eventDescription;
    private Date eventDate;
    private Time eventTime;
    private String eventLocation;
    private String eventCategory;
    private int participantLimit;
    private Date registrationDeadline;
    private BigDecimal registrationFee;
    private String requirements;
    private String specialInstructions;
    private String contactPerson;
    private String contactEmail;
    private String contactPhone;
    private String eventStatus;
    private String approvedBy;
    private Timestamp approvedAt;
    private String rejectionReason;
    private int registeredCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Event() {}

    // Constructor for creating new event
    public Event(String eventID, String organizationID, String eventTitle, String eventDescription,
                 Date eventDate, Time eventTime, String eventLocation, String eventCategory,
                 int participantLimit, Date registrationDeadline, BigDecimal registrationFee,
                 String requirements, String specialInstructions, String contactPerson,
                 String contactEmail, String contactPhone) {
        this.eventID = eventID;
        this.organizationID = organizationID;
        this.eventTitle = eventTitle;
        this.eventDescription = eventDescription;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.eventLocation = eventLocation;
        this.eventCategory = eventCategory;
        this.participantLimit = participantLimit;
        this.registrationDeadline = registrationDeadline;
        this.registrationFee = registrationFee;
        this.requirements = requirements;
        this.specialInstructions = specialInstructions;
        this.contactPerson = contactPerson;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
        this.eventStatus = "pending";
        this.registeredCount = 0;
    }

    // Getters and Setters
    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getOrganizationID() {
        return organizationID;
    }

    public void setOrganizationID(String organizationID) {
        this.organizationID = organizationID;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getEventDescription() {
        return eventDescription;
    }

    public void setEventDescription(String eventDescription) {
        this.eventDescription = eventDescription;
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

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventCategory() {
        return eventCategory;
    }

    public void setEventCategory(String eventCategory) {
        this.eventCategory = eventCategory;
    }

    public int getParticipantLimit() {
        return participantLimit;
    }

    public void setParticipantLimit(int participantLimit) {
        this.participantLimit = participantLimit;
    }

    public Date getRegistrationDeadline() {
        return registrationDeadline;
    }

    public void setRegistrationDeadline(Date registrationDeadline) {
        this.registrationDeadline = registrationDeadline;
    }

    public BigDecimal getRegistrationFee() {
        return registrationFee;
    }

    public void setRegistrationFee(BigDecimal registrationFee) {
        this.registrationFee = registrationFee;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public String getSpecialInstructions() {
        return specialInstructions;
    }

    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getEventStatus() {
        return eventStatus;
    }

    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
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

    public int getRegisteredCount() {
        return registeredCount;
    }

    public void setRegisteredCount(int registeredCount) {
        this.registeredCount = registeredCount;
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
    public boolean isRegistrationOpen() {
        Date today = new Date(System.currentTimeMillis());
        return registrationDeadline != null && registrationDeadline.after(today);
    }

    public boolean hasParticipantLimit() {
        return participantLimit > 0;
    }

    public boolean isFullyBooked() {
        return hasParticipantLimit() && registeredCount >= participantLimit;
    }

    public int getAvailableSlots() {
        if (!hasParticipantLimit()) {
            return Integer.MAX_VALUE;
        }
        return Math.max(0, participantLimit - registeredCount);
    }

    @Override
    public String toString() {
        return "Event{" +
                "eventID='" + eventID + '\'' +
                ", eventTitle='" + eventTitle + '\'' +
                ", eventDate=" + eventDate +
                ", eventTime=" + eventTime +
                ", eventLocation='" + eventLocation + '\'' +
                ", eventStatus='" + eventStatus + '\'' +
                ", registeredCount=" + registeredCount +
                '}';
    }
}