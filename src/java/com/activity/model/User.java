package com.activity.model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String phoneNo;
    private String password;
    private String role;

    // Student fields
    private String matrixNo;
    private String program;
    private String faculty;

    // Staff fields
    private String staffRole;
    private String department;

    // Admin fields
    private String staffNo;

    // Organization fields
    private String advisorName;

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNo() { return phoneNo; }
    public void setPhoneNo(String phoneNo) { this.phoneNo = phoneNo; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getMatrixNo() { return matrixNo; }
    public void setMatrixNo(String matrixNo) { this.matrixNo = matrixNo; }

    public String getProgram() { return program; }
    public void setProgram(String program) { this.program = program; }

    public String getFaculty() { return faculty; }
    public void setFaculty(String faculty) { this.faculty = faculty; }

    public String getStaffRole() { return staffRole; }
    public void setStaffRole(String staffRole) { this.staffRole = staffRole; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getStaffNo() { return staffNo; }
    public void setStaffNo(String staffNo) { this.staffNo = staffNo; }

    public String getAdvisorName() { return advisorName; }
    public void setAdvisorName(String advisorName) { this.advisorName = advisorName; }
}
