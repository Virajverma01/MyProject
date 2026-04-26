package model;

public class User {

    private int id;
    private int empId;
    private String username;
    private String password;
    private String role;
    private String fullName;

    // ===== GETTERS =====

    public int getId() {
        return id;
    }

    public int getEmpId() {
        return empId;
    }

    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    public String getFullName() {
        return fullName;
    }

    // ===== SETTERS =====

    public void setId(int id) {
        this.id = id;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
