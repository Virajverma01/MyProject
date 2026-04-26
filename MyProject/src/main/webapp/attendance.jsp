<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="model.User, util.DBConnection" %>

<script>
    // Block back & forward buttons
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.pushState(null, null, location.href);
    };
</script>

<%
String role = (String) session.getAttribute("role");
if (role == null || (!role.equalsIgnoreCase("ADMIN") && !role.equalsIgnoreCase("HR"))) {
    response.sendRedirect("index.jsp");
    return;
}

response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("index.jsp");
    return;
}

Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(
    "SELECT e.emp_id, e.full_name, a.attendance_date, a.status " +
    "FROM attendance a JOIN employeess e ON a.emp_id = e.emp_id " +
    "ORDER BY a.attendance_date DESC"
);

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<title>Attendance Dashboard</title>

<style>
body{
    margin:0;
    font-family:Segoe UI, sans-serif;
    background:#f5f7fb;
}
.header{
    background:#e9f1ff;
    padding:12px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}
.header h2{margin:0;font-size:18px;color:#1e3a8a}

.container{padding:20px}

.cards{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:15px;
}
.card{
    background:#fff;
    border-radius:10px;
    padding:15px;
    box-shadow:0 4px 14px rgba(0,0,0,.08);
}
.card h4{margin:0;color:#64748b;font-size:13px}
.card h2{margin-top:10px;color:#1e293b}

.grid{
    display:grid;
    grid-template-columns:2.5fr 1.5fr;
    gap:20px;
    margin-top:20px;
}

.subcard{
    background:#fff;
    border-radius:10px;
    padding:15px;
    box-shadow:0 4px 14px rgba(0,0,0,.08);
}

.mode-box{
    display:flex;
    justify-content:space-between;
    margin-top:10px;
}
.mode{
    width:100%;
    padding:10px;
    border-radius:8px;
    margin-bottom:8px;
    font-size:13px;
}
.bio{background:#e0f2fe}
.web{background:#fff7ed}
.mob{background:#f0fdf4}

.donut{
    width:160px;height:160px;border-radius:50%;
    background:conic-gradient(#2563eb 0 65%, #f59e0b 65% 85%, #22c55e 85% 100%);
    margin:10px auto;
}

table{
    width:100%;
    border-collapse:collapse;
}
th{
    background:#f1f5f9;
    padding:10px;
    font-size:13px;
}
td{
    padding:8px;
    border-bottom:1px solid #e5e7eb;
    text-align:center;
    font-size:13px;
}

.present{
    background:#dcfce7;color:#166534;
    padding:4px 10px;border-radius:20px;
}
.absent{
    background:#fee2e2;color:#991b1b;
    padding:4px 10px;border-radius:20px;
}

.footer{
    margin-top:20px;
    background:#fff;
    border-radius:10px;
    padding:15px;
    box-shadow:0 4px 14px rgba(0,0,0,.08);
}

select,button{
    width:100%;
    padding:8px;
    margin-top:8px;
    display: block;
    border-radius:6px;
    border:1px solid #cbd5f5;
}
button{
    width:100%;
    padding:8px;
    margin-top:8px;
    background:#2563eb;
    color:white;
    cursor:pointer;
    border-radius:6px;
    border:1px solid #cbd5f5;
}

.btn-cancel {
    width:100%;
    padding:8px;
    margin-top:8px;
    background:#e74c3c;
    display: flex;
    color:white;
    cursor:pointer;
    justify-content: center;
    border-radius:6px;
    border:1px solid #cbd5f5;
    color:white;
    border:none;
    cursor:pointer;
    text-decoration: none;	
}

</style>

<script>
function updateTime(){
    document.getElementById("time").innerHTML =
        new Date().toLocaleTimeString();
}
setInterval(updateTime,1000);
</script>
</head>

<body onload="updateTime()">

<div class="header">
    <h2>Attendance Dashboard</h2>
    <div>
        <b id="time"></b><br>
        <small><%= new SimpleDateFormat("dd MMM yyyy").format(new Date()) %></small>
    </div>
</div>

<div class="container">

    <!-- TOP CARDS -->
    <div class="cards">
        <div class="card"><h4>Total Employees</h4><h2>236</h2></div>
        <div class="card"><h4>On Leave Today</h4><h2>2</h2></div>
        <div class="card"><h4>Total In Today</h4><h2>177</h2></div>
        <div class="card"><h4>Late Arrivals</h4><h2>24</h2></div>
    </div>

    <!-- MAIN GRID -->
    <div class="grid">

        <!-- LEFT -->
        <div class="subcard">
            <h3>Attendance</h3>
            <table>
                <tr>
                    <th>Emp ID</th>
                    <th>Name</th>
                    <th>Date & Time</th>
                    <th>Status</th>
                </tr>
                <%
                while(rs.next()){
                    String status = rs.getString("status");
                %>
                <tr>
                    <td><%=rs.getInt("emp_id")%></td>
                    <td><%=rs.getString("full_name")%></td>
                    <td><%=sdf.format(rs.getTimestamp("attendance_date"))%></td>
                    <td>
                        <span class="<%=status.equals("Present")?"present":"absent"%>">
                            <%=status%>
                        </span>
                    </td>
                </tr>
                <%}%>
            </table>
        </div>

        <!-- RIGHT -->
        <div>
            <div class="subcard">
                <h3>Mode of Punch In</h3>
                <div class="mode-box">
                    <div style="width:100%">
                        <div class="mode bio">Biometric – 158</div>
                        <div class="mode web">Web – 14</div>
                        <div class="mode mob">Mobile – 5</div>
                    </div>
                </div>
                <div class="donut"></div>
            </div>

            <div class="subcard" style="margin-top:15px">
                <h3>Mark Attendance</h3>
                <form action="attendance" method="post">
                    <select name="empId" required>
                        <option value="">Select Employee</option>
                        <option value="1">Virat</option>
                        <option value="2">Rohit</option>
                        <option value="3">Rahul</option>
                    </select>

                    <select name="status" required>
                        <option value="">Select Status</option>
                        <option value="Present">Present</option>
                        <option value="Absent">Absent</option>
                    </select>

                    <button type="submit">Submit</button>
                    
                    <a
						href="<%=role.equalsIgnoreCase("ADMIN") ? request.getContextPath() + "/adminDashboard.jsp"
		: request.getContextPath() + "/hrDashboard.jsp"%>"
						class="btn-cancel"> <i class="fa fa-times-circle"></i> Cancel
					</a>
					
                </form>
            </div>
        </div>

    </div>

</div>
</body>
</html>