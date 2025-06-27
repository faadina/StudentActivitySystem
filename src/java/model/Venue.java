package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Venue {
    private int venueID;
    private String venueName;
    private String building;
    private String floor;
    private String venueType;
    private int capacity;
    private String description;
    private List<String> facilities;
    private BigDecimal price;
    private String imageUrl;
    private String availability;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Venue() {}

    // Constructor for creating new venue
    public Venue(String venueName, String building, String floor, String venueType,
                 int capacity, String description, List<String> facilities,
                 BigDecimal price, String imageUrl) {
        this.venueName = venueName;
        this.building = building;
        this.floor = floor;
        this.venueType = venueType;
        this.capacity = capacity;
        this.description = description;
        this.facilities = facilities;
        this.price = price;
        this.imageUrl = imageUrl;
        this.availability = "available";
    }

    // Getters and Setters
    public int getVenueID() {
        return venueID;
    }

    public void setVenueID(int venueID) {
        this.venueID = venueID;
    }

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

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public String getVenueType() {
        return venueType;
    }

    public void setVenueType(String venueType) {
        this.venueType = venueType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getFacilities() {
        return facilities;
    }

    public void setFacilities(List<String> facilities) {
        this.facilities = facilities;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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
        return "available".equals(availability);
    }

    public boolean hasFacility(String facility) {
        return facilities != null && facilities.contains(facility);
    }

    public String getLocation() {
        return building + (floor != null ? ", " + floor : "");
    }

    @Override
    public String toString() {
        return "Venue{" +
                "venueID=" + venueID +
                ", venueName='" + venueName + '\'' +
                ", building='" + building + '\'' +
                ", venueType='" + venueType + '\'' +
                ", capacity=" + capacity +
                ", availability='" + availability + '\'' +
                '}';
    }
}