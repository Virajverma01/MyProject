package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Employee {
	private int empId;
	private String fullName;
	private String email;
	private String mobile;
	private Date doj;
	private Date dob;
	private String gender;
	private String address;
	private Timestamp created_at;
	
	public int getEmpId() {
	    return empId;
	}

	public void setEmpId(int empId) {
	    this.empId = empId;
	}

	public String getFullName() {
	    return fullName;
	}

	public void setFullName(String fullName) {
	    this.fullName = fullName;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	
	public String getPhone() {
		return mobile;
	}
	
	public void setPhone(String mobile) {
		this.mobile = mobile;
	}


	public Date getDob() {
	    return dob;
	}

	public void setDob(Date dob) {
	    this.dob = dob;
	}

	public Date getDoj() {
	    return doj;
	}

	public void setDoj(Date doj) {
	    this.doj = dob;
	}

	public String getGender() {
	    return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getAddress() {
	    return address;
	}

	public void setAddress(String address) {
	    this.address = address;
	}

	public Timestamp getcreated_at() {
		return created_at;
	}
	
	public void setcreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	

}
