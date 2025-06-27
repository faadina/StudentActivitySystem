package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;

public class ResourceBooking {
    private int bookingID;
    private int resourceID;
    private String userID;
    private String eventName;
    private String eventLocation;
    private Date borrowDate;
    private Date returnDate;
    private int quantity;
    private String purpose;
    private String contactPerson;
    private String contactPhone;
    private String status;
    private BigDecimal depositAmount;
    private Date actualReturnDate;
    private String condition;
    private String approvedBy;
    private Timestamp approvedAt;
    private String rejectionReason;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // For joined queries
    private String resourceName;
    private String category;
    private String userName;

    // Default constructor
    public ResourceBooking() {}

    // Constructor for creating new booking
    public ResourceBooking(int resourceID, String userID, String eventName, String eventLocation,
                          Date borrowDate, Date returnDate, int quantity, String purpose,
                          String contactPerson, String contactPhone, BigDecimal depositAmount) {
        this.resourceID = resourceID;
        this.userID = userID;
        this.eventName = eventName;
        this.eventLocation = eventLocation;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.quantity = quantity;
        this.purpose = purpose;
        this.contactPerson = contactPerson;
        this.contactPhone = contactPhone;
        this.depositAmount = depositAmount;
        this.status = "pending";
        this.condition = "good";
    }

    // Getters and Setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getResourceID() {
        return resourceID;
    }

    public void setResourceID(int resourceID) {
        this.resourceID = resourceID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }

    public Date getActualReturnDate() {
        return actualReturnDate;
    }

    public void setActualReturnDate(Date actualReturnDate) {
        this.actualReturnDate = actualReturnDate;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
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
    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public boolean isBorrowed() {
        return "borrowed".equals(status);
    }

    public boolean isReturned() {
        return "returned".equals(status);
    }

    public boolean isOverdue() {
        return "overdue".equals(status);
    }

    public boolean isCancelled() {
        return "cancelled".equals(status);
    }

    public long getBorrowDurationInDays() {
        if (borrowDate == null || returnDate == null) return 0;
        
        long diffInMillies = returnDate.getTime() - borrowDate.getTime();
        return TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS) + 1; // +1 to include both start and end dates
    }

    public long getDaysOverdue() {
        if (!isOverdue() || returnDate == null) return 0;
        
        Date today = new Date(System.currentTimeMillis());
        long diffInMillies = today.getTime() - returnDate.getTime();
        return TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
    }

    public boolean isCurrentlyBorrowed() {
        Date today = new Date(System.currentTimeMillis());
        return (isConfirmed() || isBorrowed()) && 
               !today.before(borrowDate) && 
               !today.after(returnDate);
    }

    public boolean isUpcoming() {
        Date today = new Date(System.currentTimeMillis());
        return borrowDate.after(today);
    }

    public boolean isPast() {
        Date today = new Date(System.currentTimeMillis());
        return returnDate.before(today);
    }

    @Override
    public String toString() {
        return "ResourceBooking{" +
                "bookingID=" + bookingID +
                ", resourceID=" + resourceID +
                ", eventName='" + eventName + '\'' +
                ", borrowDate=" + borrowDate +
                ", returnDate=" + returnDate +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                '}';
    }
}