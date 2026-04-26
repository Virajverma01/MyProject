package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnection;

@WebServlet("/updateLeaveStatus")
public class UpdateLeaveStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int leaveId = Integer.parseInt(req.getParameter("leaveId"));
        String status = req.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE leave_requests SET status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, leaveId);

            ps.executeUpdate();

            res.sendRedirect("leaveRequests.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
