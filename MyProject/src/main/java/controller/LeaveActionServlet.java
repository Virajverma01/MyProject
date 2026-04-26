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

@WebServlet("/leaveAction")
public class LeaveActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int leaveId = Integer.parseInt(req.getParameter("leave_id"));
        String action = req.getParameter("action");
        String comment = req.getParameter("hr_comment");
        if(comment == null || comment.trim().isEmpty()){
            comment = "No comment";
        }

        Connection con = DBConnection.getConnection();

        String sql = "UPDATE leave_requests SET status=?, hr_comment=?, action_at=NOW() WHERE id=?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, action); 
            ps.setString(2, comment);
            ps.setInt(3, leaveId);
            ps.executeUpdate();

            res.sendRedirect("hrLeaves");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

