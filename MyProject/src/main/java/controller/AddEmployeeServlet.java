package controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DBConnection;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        redirectToDashboard(request, response, role, null);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

       
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        
        if (!"ADMIN".equalsIgnoreCase(role) && !"HR".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String dojStr = request.getParameter("doj");
        String address = request.getParameter("address");

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            java.sql.Date dob = (dobStr != null && !dobStr.isEmpty())
                    ? java.sql.Date.valueOf(dobStr)
                    : null;

            java.sql.Date doj = (dojStr != null && !dojStr.isEmpty())
                    ? java.sql.Date.valueOf(dojStr)
                    : null;

           
            String empSql = "INSERT INTO employeess " +
                    "(emp_code, full_name, email, mobile, gender, date_of_birth, date_of_joining, address) " +
                    "VALUES (?,?,?,?,?,?,?,?)";

            String empCode = "EMP" + System.currentTimeMillis();

            PreparedStatement ps = con.prepareStatement(empSql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, empCode);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, mobile);
            ps.setString(5, gender);
            ps.setDate(6, dob);
            ps.setDate(7, doj);
            ps.setString(8, address);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int empId = rs.getInt(1);

            
            String loginSql =
                    "INSERT INTO users (emp_id, username, password, role) VALUES (?,?,?,?)";

            PreparedStatement ps2 = con.prepareStatement(loginSql);
            ps2.setInt(1, empId);
            ps2.setString(2, email);
            ps2.setString(3, "Emp@" + empId);
            ps2.setString(4, "EMPLOYEE");
            ps2.executeUpdate();

            con.commit();

            redirectToDashboard(request, response, role, "EmployeeCreated");

        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            throw new ServletException(e);
        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

  
    private void redirectToDashboard(HttpServletRequest request,
                                     HttpServletResponse response,
                                     String role,
                                     String msg) throws IOException {

        String message = (msg != null) ? "?msg=" + msg : "";

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() +
                    "/adminDashboard.jsp" + message);
        } else if ("HR".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() +
                    "/hrDashboard.jsp" + message);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
    
}
