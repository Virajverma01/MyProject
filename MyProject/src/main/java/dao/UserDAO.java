package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DBConnection;

public class UserDAO {

	public User login(String username, String password) {
	    User user = null;

	    try (Connection con = DBConnection.getConnection()) {
	        
	        String sql = "SELECT * FROM users WHERE BINARY username=? AND BINARY password=?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        ps.setString(2, password);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            user = new User();
	            user.setUsername(rs.getString("username"));
	            user.setRole(rs.getString("role"));
	            int empId = rs.getInt("emp_id");  
	            user.setEmpId(empId);
	            

	          
	            if ("EMPLOYEE".equalsIgnoreCase(user.getRole())) {
	                String empSql = "SELECT full_name FROM employeess WHERE emp_id=?";
	                PreparedStatement ps2 = con.prepareStatement(empSql);
	                ps2.setInt(1, empId);
	                ResultSet rs2 = ps2.executeQuery();
	                if (rs2.next()) {
	                    user.setFullName(rs2.getString("full_name")); 
	                } else {
	                    user.setFullName("Employee"); 
	                }
	            } else {
	               
	                user.setFullName(user.getUsername());
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}



}
