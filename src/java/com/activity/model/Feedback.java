package com.activity.model;

public class Feedback {
    private int id;
    private String eventName;
    private String experienceRating;
    private String comment;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getExperienceRating() { return experienceRating; }
    public void setExperienceRating(String experienceRating) { this.experienceRating = experienceRating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
}
