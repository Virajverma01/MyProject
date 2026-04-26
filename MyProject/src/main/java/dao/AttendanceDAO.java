package dao;

import java.sql.*;
import util.DBConnection;

public class AttendanceDAO {

    // MARK ATTENDANCE
    public static boolean markAttendance(int empId, String status) {

    	String sql = "INSERT INTO attendance (emp_id, attendance_date, status) VALUES (?, ?, ?)";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empId);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setString(3, status);

            ps.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // FETCH ATTENDANCE LIST
    public static ResultSet getAttendanceList(Connection con) throws SQLException {

        String sql =
            "SELECT e.emp_id, e.emp_name, a.attendance_date, a.status " +
            "FROM attendance a " +
            "JOIN employeess e ON a.emp_id = e.emp_id " +
            "ORDER BY a.attendance_date DESC";

        Statement st = con.createStatement();
        return st.executeQuery(sql);
    }
    

}
