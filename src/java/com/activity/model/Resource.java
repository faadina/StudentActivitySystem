package com.activity.model;

public class Resource {
    private int id;
    private String date;
    private String duration;
    private String time;
    private String resourceName;
    private int quantity;
    private String status;

    // Getter & Setter for ID
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    // Getter & Setter for Date
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    // Getter & Setter for Duration
    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

    // Getter & Setter for Time
    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }

    // Getter & Setter for Resource Name
    public String getResourceName() {
        return resourceName;
    }
    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    // Getter & Setter for Quantity
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Getter & Setter for Status
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
