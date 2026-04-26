package model;

import java.sql.Date;
import java.sql.Timestamp;

public class LeaveRequest {

    private int id;
    private int employeeId;
    private String EmployeeName;
    private String leaveType;
    private Date startDate;
    private Date endDate;
    private String reason;
    private String status;
    private String hrComment;
    private Date appliedAt;
    private Timestamp actionAt;

   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getEmployeeName() {
    	return EmployeeName;
    }
    
    public void setEmployeeName(String EmployeeName) {
    	this.EmployeeName = EmployeeName;
    }

  
    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    
    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

 
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    
    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

   
    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public String getHrComment() {
        return hrComment;
    }

    public void setHrComment(String hrComment) {
        this.hrComment = hrComment;
    }


    public Date getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(Date appliedAt) {
        this.appliedAt = appliedAt;
    }

   
    public Timestamp getActionAt() {
        return actionAt;
    }

    public void setActionAt(Timestamp actionAt) {
        this.actionAt = actionAt;
    }
}


