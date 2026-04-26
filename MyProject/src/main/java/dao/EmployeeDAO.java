package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Employee;
import util.DBConnection;

public class EmployeeDAO {

	public List<Employee> getAllEmployees() {

	    List<Employee> list = new ArrayList<>();

	    try (Connection con = DBConnection.getConnection()) {
	    	PreparedStatement ps =
	    			con.prepareStatement("SELECT * FROM employeess");
	    	
	    	ResultSet rs = ps.executeQuery();
	    	
	    	while (rs.next()) {
	    		Employee e = new Employee();
	    		e.setEmpId(rs.getInt("emp_id"));
	    		e.setFullName(rs.getString("full_name"));
	    		e.setEmail(rs.getString("email"));
	    		e.setPhone(rs.getString("mobile"));
	    		e.setDob(rs.getDate("date_of_birth"));
	    		e.setDoj(rs.getDate("date_of_joining"));
	    		e.setAddress(rs.getString("address"));
	    		list.add(e);
	    	}
	    	
	    	
	    } catch (Exception ex) {
	    	ex.printStackTrace();
	    }
	    
	    return list;
	    

	}
	public Employee getEmployeeById(int empId) {

	    Employee e = null;

	    try (Connection con = DBConnection.getConnection()) {

	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM employeess WHERE emp_id = ?"
	        );
	        ps.setInt(1, empId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            e = new Employee();
	            e.setEmpId(rs.getInt("emp_id"));
	            e.setFullName(rs.getString("full_name"));
	            e.setEmail(rs.getString("email"));
	            e.setPhone(rs.getString("mobile"));
	            e.setGender(rs.getString("gender"));
	            e.setDob(rs.getDate("date_of_birth"));
	            e.setDoj(rs.getDate("date_of_joining"));
	            e.setAddress(rs.getString("address"));
	            e.setcreated_at(rs.getTimestamp("created_at"));
	            
	        }

	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }

	    return e;
	}
	

}
