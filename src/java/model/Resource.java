package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Map;

public class Resource {
    private int resourceID;
    private String resourceName;
    private String category;
    private String description;
    private String location;
    private int totalQuantity;
    private int availableQuantity;
    private String condition;
    private BigDecimal depositRequired;
    private String imageUrl;
    private Map<String, Object> specifications;
    private String usageInstructions;
    private String availability;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Resource() {}

    // Constructor for creating new resource
    public Resource(String resourceName, String category, String description, String location,
                   int totalQuantity, String condition, BigDecimal depositRequired,
                   String imageUrl, Map<String, Object> specifications, String usageInstructions) {
        this.resourceName = resourceName;
        this.category = category;
        this.description = description;
        this.location = location;
        this.totalQuantity = totalQuantity;
        this.availableQuantity = totalQuantity;
        this.condition = condition;
        this.depositRequired = depositRequired;
        this.imageUrl = imageUrl;
        this.specifications = specifications;
        this.usageInstructions = usageInstructions;
        this.availability = "available";
    }

    // Getters and Setters
    public int getResourceID() {
        return resourceID;
    }

    public void setResourceID(int resourceID) {
        this.resourceID = resourceID;
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(int availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public BigDecimal getDepositRequired() {
        return depositRequired;
    }

    public void setDepositRequired(BigDecimal depositRequired) {
        this.depositRequired = depositRequired;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Map<String, Object> getSpecifications() {
        return specifications;
    }

    public void setSpecifications(Map<String, Object> specifications) {
        this.specifications = specifications;
    }

    public String getUsageInstructions() {
        return usageInstructions;
    }

    public void setUsageInstructions(String usageInstructions) {
        this.usageInstructions = usageInstructions;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
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
    public boolean isAvailable() {
        return "available".equals(availability) && availableQuantity > 0;
    }

    public boolean hasQuantityAvailable(int requestedQuantity) {
        return availableQuantity >= requestedQuantity;
    }

    public int getBorrowedQuantity() {
        return totalQuantity - availableQuantity;
    }

    public double getUtilizationRate() {
        if (totalQuantity == 0) return 0.0;
        return (double) getBorrowedQuantity() / totalQuantity * 100;
    }

    public boolean requiresDeposit() {
        return depositRequired != null && depositRequired.compareTo(BigDecimal.ZERO) > 0;
    }

    @Override
    public String toString() {
        return "Resource{" +
                "resourceID=" + resourceID +
                ", resourceName='" + resourceName + '\'' +
                ", category='" + category + '\'' +
                ", location='" + location + '\'' +
                ", availableQuantity=" + availableQuantity +
                ", totalQuantity=" + totalQuantity +
                ", availability='" + availability + '\'' +
                '}';
    }
}