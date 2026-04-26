package controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AttendanceDAO;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int empId = Integer.parseInt(req.getParameter("empId"));
       
        String status = req.getParameter("status");

        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        AttendanceDAO.markAttendance(empId, status);

        res.sendRedirect("attendance.jsp");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	

        request.getRequestDispatcher("attendance.jsp").forward(request, response);
    }
}





