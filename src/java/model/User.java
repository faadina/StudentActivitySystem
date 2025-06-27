package model;

import java.sql.Timestamp;

public class User {
    private String userID;
    private String userName;
    private String userEmail;
    private String userPhoneNo;
    private String password;
    private String userRole;
    private String userStatus;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public User() {}

    // Constructor with all fields
    public User(String userID, String userName, String userEmail, String userPhoneNo, 
                String password, String userRole, String userStatus, 
                Timestamp createdAt, Timestamp updatedAt) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPhoneNo = userPhoneNo;
        this.password = password;
        this.userRole = userRole;
        this.userStatus = userStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Constructor without timestamps (for creation)
    public User(String userID, String userName, String userEmail, String userPhoneNo, 
                String password, String userRole) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPhoneNo = userPhoneNo;
        this.password = password;
        this.userRole = userRole;
        this.userStatus = "active";
    }

    // Getters and Setters
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
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

    public String getUserPhoneNo() {
        return userPhoneNo;
    }

    public void setUserPhoneNo(String userPhoneNo) {
        this.userPhoneNo = userPhoneNo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
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

    @Override
    public String toString() {
        return "User{" +
                "userID='" + userID + '\'' +
                ", userName='" + userName + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userRole='" + userRole + '\'' +
                ", userStatus='" + userStatus + '\'' +
                '}';
    }
}