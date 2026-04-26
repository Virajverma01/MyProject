<%
/* ROLE SECURITY */
String role = (String) session.getAttribute("role");
if (role == null || !role.equalsIgnoreCase("EMPLOYEE")) {
    response.sendRedirect("../index.jsp");
    return;
}
%>

<script>
    // Block back & forward buttons
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.pushState(null, null, location.href);
    };
</script>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String fullName = (String) session1.getAttribute("fullName");
    String username = (String) session1.getAttribute("username");
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("user") == null) {
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Dashboard</title>

<style>
:root{
    --primary:#6366f1;
    --bg:#f8fafc;
    --card:#ffffff;
    --text:#111827;
    --muted:#6b7280;
    --border:#e5e7eb;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Segoe UI", Arial, sans-serif;
}

body{
    background:var(--bg);
    color:var(--text);
}

/* NAVBAR */
.navbar{
    background:#fff;
    border-bottom:1px solid var(--border);
    padding:16px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.navbar h2{
    font-size:20px;
    color: black;
}

.navbar .right{
    display:flex;
    align-items:center;
    gap:20px;
}

.clock{
    font-size:14px;
    color:var(--muted);
}

.navbar a{
    text-decoration:none;
    color:var(--muted);
    font-weight:500;
}

.navbar a:hover{
    color:var(--primary);
}

/* CONTAINER */
.container{
    max-width:1100px;
    margin:30px auto;
    padding:0 20px;
}

/* HEADER */
.header{
    margin-bottom:25px;
}

.header h3{
    font-size:24px;
}

#pp{
		color: var(--primary);
		font-size:24px;
		display: inline;
}

.header p{
    color:var(--muted);
    font-size:14px;
}

/* STATS */
.stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-bottom:35px;
}

.stat-box{
    background:#fff;
    border:1px solid var(--border);
    border-radius:12px;
    padding:20px;
}

.stat-box span{
    font-size:13px;
    color:var(--muted);
}

.stat-box h2{
    margin-top:8px;
    font-size:26px;
    color:var(--primary);
}

/* NOTICE */
.notice{
    background:#eef2ff;
    border:1px solid #c7d2fe;
    padding:16px;
    border-radius:12px;
    margin-bottom:30px;
    font-size:14px;
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:24px;
}

.card{
    background:#fff;
    border:1px solid var(--border);
    border-radius:14px;
    padding:24px;
    cursor:pointer;
    transition:0.25s ease;
}

.card:hover{
    border-color:var(--primary);
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.card h4{
    font-size:16px;
}

.card p{
    margin-top:8px;
    font-size:14px;
    color:var(--muted);
}

/* FOOTER */
.footer{
    margin-top:50px;
    text-align:center;
    font-size:13px;
    color:var(--muted);
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>Employee Panel</h2>
    <div class="right">
        <div class="clock" id="clock"></div>
       <a href="<%= request.getContextPath() %>/employeeDashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <h3>Welcome, <p id="pp"><%= fullName %></p></h3>
        <p>Your daily work overview</p>
    </div>

    <!-- STATS -->
    <div class="stats">
        <div class="stat-box">
            <span>Attendance This Month</span>
            <h2 id="attCount">0</h2>
        </div>
        <div class="stat-box">
            <span>Leaves Taken</span>
            <h2 id="leaveTaken">0</h2>
        </div>
        <div class="stat-box">
            <span>Pending Leaves</span>
            <h2 id="pendingLeave">0</h2>
        </div>
    </div>

    <!-- NOTICE -->
    <div class="notice">
        📢 Remember to mark your attendance before <strong>10:15 AM</strong>.
    </div>

    <!-- EMPLOYEE ACTIONS -->
    <div class="cards">

        <div class="card" onclick="location.href='attendance.jsp'">
            <h4>Mark Attendance</h4>
            <p>Check-in and check-out for today</p>
        </div>

        <div class="card" onclick="location.href='myAttendance.jsp'">
            <h4>My Attendance</h4>
            <p>View your attendance history</p>
        </div>

        <div class="card" onclick="location.href='applyLeave.jsp'">
            <h4>Apply Leave</h4>
            <p>Request leave from HR</p>
        </div>

        <div class="card" onclick="location.href='ProfileServlet'">
            <h4>My Profile</h4>
            <p>View your personal & job details</p>
        </div>
        
        <div class="card" onclick="location.href='employeeLeaveStatus.jsp'">
            <h4>Leave Status</h4>
            <p>Check Leave Request</p>
        </div>

    </div>

    <div class="footer">
        © 2026 Attendance Management System | Employee Module
    </div>

</div>

<script>
/* LIVE CLOCK */
function updateClock(){
    const now = new Date();
    document.getElementById("clock").innerText =
        now.toLocaleDateString() + " | " + now.toLocaleTimeString();
}
setInterval(updateClock,1000);
updateClock();

/* UI COUNTERS */
function animate(id,target){
    let i=0;
    const el=document.getElementById(id);
    const interval=setInterval(()=>{
        i++;
        el.innerText=i;
        if(i>=target) clearInterval(interval);
    },30);
}

animate("attCount", 18);
animate("leaveTaken", 2);
animate("pendingLeave", 1);
</script>

</body>
</html>
