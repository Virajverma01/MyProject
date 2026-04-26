package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DBConnection;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("employee_id") == null) {
            //System.out.println("❌ Session expired or employeeId missing");
            res.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        int employeeId = (int) session.getAttribute("employee_id");
        //System.out.println("✅ Employee ID from session: " + employeeId);

        if (employeeId <= 0) {
           // System.out.println("❌ Invalid employee ID");
            res.sendRedirect(req.getContextPath() + "/applyLeave.jsp?error=invalidEmployee");
            return;
        }

        
        String leaveType = req.getParameter("leave_type");
        String startDate = req.getParameter("start_date");
        String endDate   = req.getParameter("end_date");
        String reason    = req.getParameter("description");

        
        if (leaveType == null || startDate == null || endDate == null ||
            leaveType.trim().isEmpty() ||
            startDate.trim().isEmpty() ||
            endDate.trim().isEmpty()) {

            //System.out.println("❌ Empty form data");
            res.sendRedirect(req.getContextPath() + "/applyLeave.jsp?error=empty");
            return;
        }

       
        try (Connection con = DBConnection.getConnection()) {

        	int empId = (Integer) session.getAttribute("employee_id");
        	
            String sql =
                "INSERT INTO leave_requests " +
                "(employee_id, leave_type, start_date, end_date, reason, status) " +
                "VALUES (?, ?, ?, ?, ?, 'PENDING')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, empId);
            ps.setString(2, leaveType);
            ps.setDate(3, java.sql.Date.valueOf(startDate));
            ps.setDate(4, java.sql.Date.valueOf(endDate));
            ps.setString(5, reason);

            int rows = ps.executeUpdate();

            if (rows > 0) {
               // System.out.println("✅ Leave inserted successfully");
                res.sendRedirect(req.getContextPath()
                        + "/employeeLeaveStatus.jsp?success=1");
            } else {
               // System.out.println("❌ Insert failed");
                res.sendRedirect(req.getContextPath()
                        + "/applyLeave.jsp?error=failed");
            }

        } catch (Exception e) {
            //System.out.println("❌ Exception in ApplyLeaveServlet");
            e.printStackTrace();
            res.sendRedirect(req.getContextPath()
                    + "/applyLeave.jsp?error=server");
        }
    }
}
