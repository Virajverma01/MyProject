package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LeaveRequest;
import util.DBConnection;

@WebServlet("/hrLeaves")
public class HRLeaveServlet extends HttpServlet{
	 protected void doGet(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {

	        List<LeaveRequest> list = new ArrayList<>();

	        Connection con = DBConnection.getConnection();
	        String sql = "SELECT lr.*, e.full_name " +
	                "FROM leave_requests lr " +
	                "JOIN employeess e ON lr.employee_id = e.emp_id";

	        try {
	            PreparedStatement ps = con.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                LeaveRequest lr = new LeaveRequest();
	                lr.setId(rs.getInt("id"));
	                lr.setEmployeeName(rs.getString("full_name"));
	                lr.setStartDate(rs.getDate("start_date"));
	                lr.setEndDate(rs.getDate("end_date"));
	                lr.setReason(rs.getString("reason"));
	                lr.setAppliedAt(rs.getDate("applied_at"));
	                lr.setStatus(rs.getString("status"));
	                lr.setLeaveType(rs.getString("leave_type"));
	                list.add(lr);
	            }

	            req.setAttribute("leaves", list);
	            //System.out.println("Total Leaves: " + list.size());
	            req.getRequestDispatcher("leaveRequests.jsp").forward(req, res);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

}
